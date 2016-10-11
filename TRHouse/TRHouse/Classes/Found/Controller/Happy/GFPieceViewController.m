

#import "GFPieceViewController.h"
#import "GFPiece.h"
#import "GFPieceCell.h"
#import "GFCommentViewController.h"



@interface GFPieceViewController ()

/** 服务器返回的段子数据 */
@property (nonatomic, strong) NSMutableArray *pieces;
/** 页码 */
@property (nonatomic, assign)NSInteger page;
/** 服务器返回的用来上拉刷新获取数据的maxtime */
@property (nonatomic, copy) NSString *maxtime;
/** 请求参数 */
@property (nonatomic, strong) NSDictionary *prams;
/** 上一次选中的tabBarItem的索引 */
@property (nonatomic, assign)NSInteger lastSelectIndex;
@end

@implementation GFPieceViewController

/**
 *  懒加载
 */
- (NSMutableArray *)pieces {
    if (_pieces == nil) {
        _pieces = [NSMutableArray array];
    }
    return _pieces;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化表格
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
}

static NSString * const GFPieceCellId = @"piece";

/**
 *  初始化表格
 */
- (void) setupTableView {
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GFPieceCell class]) bundle:nil] forCellReuseIdentifier:GFPieceCellId];
    self.view.backgroundColor = [UIColor clearColor];
    //设置内边距
    CGFloat top = GFTitlesViewY + GFTitlesViewH;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //监听tabBar的选中
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarItemDidSelected) name:GFTabBarDidSelectedNotification object:nil];
}

- (void)tabBarItemDidSelected{
    if (self.tabBarController.selectedIndex == self.lastSelectIndex && self.view.isShowingOnKeyWindow) {

        [self.tableView.mj_header beginRefreshing];
    }
    //重新赋值索引
    self.lastSelectIndex = self.tabBarController.selectedIndex;
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh{
    
    //添加下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewPieces)];
    //根据拖拽比例自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //一进来就开始刷新
    [self.tableView.mj_header beginRefreshing];
    
    //添加上拉刷新控件
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMorePiece)];
    
}
#pragma mark a参数
- (NSString *)a{
    return @"list";
}

/**
 *  加载新的数据
 */
- (void)loadNewPieces{
    
    
    //请求参数
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    
    prams[@"a"] = self.a;
    prams[@"c"] = @"data";
    prams[@"type"] = @(self.type);
    self.prams = prams;
    
    //发起请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:prams progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        if (self.prams != prams) return;
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.pieces = [GFPiece mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        //清空页码
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}


/**
 *  加载更多数据
 */
- (void)loadMorePiece{
    //请求参数
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    
    NSInteger page = self.page + 1;
    prams[@"a"] = self.a;
    prams[@"c"] = @"data";
    prams[@"type"] = @(self.type);
    prams[@"page"] = @(page);
    prams[@"maxtime"] = self.maxtime;
    self.prams = prams;
    //发起请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:prams progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (self.prams != prams) return;
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *newPieces = [GFPiece mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.pieces addObjectsFromArray:newPieces];
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        self.page = page;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //判断是否隐藏上拉刷新控件, 如果表格没有数据的时候就隐藏
    self.tableView.mj_footer.hidden = (self.pieces.count == 0);
    return self.pieces.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GFPieceCell *cell = [tableView dequeueReusableCellWithIdentifier:GFPieceCellId];
    
    cell.piece = self.pieces[indexPath.row];
    
    
    return cell;
}


#pragma mark - <UITableView代理>
//计算行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GFPiece *piece = self.pieces[indexPath.row];
 
    //返回cell的高度
    return piece.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GFCommentViewController *commentVc = [[GFCommentViewController alloc] init];
    commentVc.piece = self.pieces[indexPath.row];
    
    [self.navigationController pushViewController:commentVc animated:YES];
    
}


@end
