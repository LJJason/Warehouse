

#import "GFCommentViewController.h"
#import "GFPieceCell.h"
#import "GFPiece.h"
#import "GFPieceComment.h"
#import "GFCommentHeaderView.h"
#import "GFCommentCell.h"
#import "UIBarButtonItem+GFExtension.h"

@interface GFCommentViewController ()<UITableViewDelegate, UITableViewDataSource>
/**
 *  底部工具条的底部约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barBottomContstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 热门评论的数据 */
@property (nonatomic, strong) NSArray *hotComments;

/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;

/** 保存当前的页码 */
@property (nonatomic, assign)NSInteger page;

/** 请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manger;
/** 保存的最热评论模型 */
@property (nonatomic, strong) GFPieceComment *savedTop_cmt;

@end

@implementation GFCommentViewController

/**
 *  懒加载
 */
- (AFHTTPSessionManager *)manger {
    if (_manger == nil) {
        _manger = [AFHTTPSessionManager manager];
    }
    return _manger;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //基本设置
    [self setUpBasic];
    
    //设置header
    [self setupHader];
    
    
    [self setupRefresh];
    
    
}


- (void) setupRefresh{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    //开始刷新
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}


/**
 *  加载更多数据
 */
- (void)loadMoreComments {
    
    //结束所有请求
    [self.manger.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSInteger page = self.page + 1;
    
    //参数
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"dataList";
    parms[@"c"] = @"comment";
    parms[@"data_id"] = self.piece.ID;
    parms[@"page"] = @(page);
    GFPieceComment *comment = [self.latestComments lastObject];
    
    parms[@"lastcid"] = comment.ID;
    
    //加载数据
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        
        NSArray *comments = [GFPieceComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.latestComments addObjectsFromArray:comments];
        
        //刷新表格
        [self.tableView reloadData];
        
        self.page = page;
        
        
        NSInteger total = [responseObject[@"total"] integerValue];
        
        //控制footer的状态
        if (self.latestComments.count >= total) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            //结束刷新
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}

/**
 *  加载新数据
 */
- (void)loadNewComments {
    //结束所有请求
    [self.manger.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //参数
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"dataList";
    parms[@"c"] = @"comment";
    parms[@"data_id"] = self.piece.ID;
    parms[@"hot"] = @"1";
    
    //加载数据
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            //结束刷新
            [self.tableView.mj_header endRefreshing];
            return;
        }
        
        self.hotComments = [GFPieceComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComments = [GFPieceComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //设置页码
        self.page = 1;
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        
        //控制footer的状态
        if (self.latestComments.count >= total) {
            self.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
    
    
}

- (void) setupHader{
    
    if (self.piece.top_cmt) {
        self.savedTop_cmt = self.piece.top_cmt;
        self.piece.top_cmt = nil;
        [self.piece setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    
    
    //创建header
    UIView *header = [[UIView alloc] init];
    
    
    GFPieceCell *cell = [GFPieceCell cell];
    
    cell.piece = self.piece;
    
    cell.size = CGSizeMake(TRScreenW, self.piece.cellHeight);
    
    header.height = self.piece.cellHeight + GFPieceCellMargin;
    
    [header addSubview:cell];

    //设置header
    self.tableView.tableHeaderView = header;
}

/**
 *  CommentCell的标识
 */
static NSString * const GFCommentCellId = @"CommentCell";


#pragma mark - 控制器的基本配置
- (void)setUpBasic{
    
    self.title = @"评论";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" hlImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    self.tableView.backgroundColor = GFGlobalBg;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GFCommentCell class]) bundle:nil] forCellReuseIdentifier:GFCommentCellId];
    
    //设置table的固定高度
    self.tableView.estimatedRowHeight = 44;
    //设置tableView的行高自适应
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //去掉tableView的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置tableView的底部间距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, GFPieceCellMargin, 0);
    
}


#pragma mark - 键盘弹出
- (void)keyboardDidChangeFrame:(NSNotification *) note{
    
    /**
     userInfo:
     UIKeyboardFrameBeginUserInfoKey : NSRect: {{0, 667}, {375, 258}},
     UIKeyboardCenterEndUserInfoKey : NSPoint: {187.5, 538},
     UIKeyboardBoundsUserInfoKey : NSRect: {{0, 0}, {375, 258}},
     UIKeyboardFrameEndUserInfoKey : NSRect: {{0, 409}, {375, 258}},
     UIKeyboardAnimationDurationUserInfoKey : 0.25,
     UIKeyboardCenterBeginUserInfoKey : NSPoint: {187.5, 796},
     UIKeyboardAnimationCurveUserInfoKey : 7,
     UIKeyboardIsLocalUserInfoKey : 1
     **/
    
    //获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取键盘弹起的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.barBottomContstraint.constant = TRScreenH - frame.origin.y;
    
    [UIView animateWithDuration:duration animations:^{
        
        //强制布局
        [self.view layoutIfNeeded];
    }];
    
    
}

#pragma mark <UITableViewDataSource>

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (hotCount) return 2;//有"热门评论" + "最新评论"
    if (latestCount) return 1; //只有"最新评论"
    return 0;//没有评论
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    //设置footer的显示和隐藏
    self.tableView.mj_footer.hidden = (latestCount == 0);
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    
    return latestCount;
    
    
}

/**
 *  根据组号获得对应得评论数据
 *
 *  @param section 组索引
 *
 *  @return 评论数据数组
 */
- (NSArray *)commentsInSection:(NSInteger)section{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    
    return self.latestComments;
}

- (GFPieceComment *)commentInIndexPath:(NSIndexPath *)indexPath{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GFCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:GFCommentCellId];
    
    GFPieceComment *comment = [self commentInIndexPath:indexPath];
    
    cell.comment = comment;
    
    return cell;
    
}

//返回组标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    NSInteger hotCount = self.hotComments.count;
//
//    if (section == 0) {
//        return hotCount ? @"热门评论" : @"最新评论";
//    }
//    
//    return @"最新评论";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    GFCommentHeaderView *header = [GFCommentHeaderView headerViewWithTableView:tableView];

    NSInteger hotCount = self.hotComments.count;

    if (section == 0) {
        header.title = hotCount ? @"热门评论" : @"最新评论";
    }else {
         header.title = @"最新评论";
    }

    return header;
}

#pragma mark <UITableViewDelegate>

//tableView即将拖拽时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //让当前view结束编辑
    [self.view endEditing:YES];
}

- (void)dealloc{
    
    if (self.savedTop_cmt) {
        self.piece.top_cmt = self.savedTop_cmt;
        [self.piece setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //终止所有请求
    [self.manger.tasks makeObjectsPerformSelector:@selector(cancel)];
}
@end
























