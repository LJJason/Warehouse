//
//  TRCircleCommentViewController.m
//  TRHouse
//
//  Created by nankeyimeng on 16/10/23.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRCircleCommentViewController.h"
#import "TRPostCommentTableViewCell.h"
#import "TRPostTableViewCell.h"
#import "TRPost.h"
#import "TRPostComment.h"
#import "TRAccount.h"
#import "TRAccountTool.h"
#import "TRLoginViewController.h"
#import "TRInteractiveCell.h"
#import "TRComentCellTableViewCell.h"

@interface TRCircleCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFiledLayout;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UIView *BgView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

/** 互动最大的条数 */
@property (nonatomic, assign) NSInteger maxCount;

/** 当前页码 */
@property (nonatomic, assign) NSInteger page;

/** 评论 */
@property (nonatomic, strong) NSMutableArray *comments;

@end

@implementation TRCircleCommentViewController

- (NSMutableArray *)comments {
    if (!_comments) {
        _comments = [NSMutableArray array];
    }
    return _comments;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHader];
    
    [self setupBasic];
    
    [self setupRefresh];
    
    
    // Do any additional setup after loading the view.
}
- (IBAction)SendClickAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
    
    if ([TRAccountTool loginState]) {
        TRAccount *account = [TRAccountTool account];
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = account.uid;
        param[@"postId"] = @(self.post.ID);
        param[@"comments"] = self.contentTextField.text;
        
        [TRHttpTool POST:TRCirleSendComment parameters:param success:^(id responseObject) {
            
            NSInteger state = [responseObject[@"state"] integerValue];
            
            if (state) {
                [self.tableView.mj_header beginRefreshing];
            }else {
                [Toast makeText:@"评论失败!!"];
            }
        } failure:^(NSError *error) {
            [Toast makeText:@"请检查网络连接!"];
        }];
        
        self.contentTextField.text = nil;
        self.sendBtn.enabled = NO;
    }else {
        //没有登录
        [self loginVc];
    }

}

- (void)setupBasic{
    self.title = @"评论";
    
    self.textFiledLayout.constant = 0;
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 54, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.contentTextField addTarget:self action:@selector(contentDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //设置table的固定高度
    self.tableView.estimatedRowHeight = 44;
    //设置tableView的行高自适应
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}
/**
 *  添加刷新控件
 */
- (void)setupRefresh{
    
    //添加下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    //根据拖拽比例自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //一进来就开始刷新
    [self.tableView.mj_header beginRefreshing];
    
    //添加上拉刷新控件
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
    //隐藏点击加载更多
    self.tableView.mj_footer.hidden = YES;
}
- (void) setupHader{
    
    //创建header
    UIView *header = [[UIView alloc] init];
    TRPostTableViewCell *cell = [TRPostTableViewCell cell];
    cell.backgroundColor = [UIColor whiteColor];
    cell.posts = self.post;
    
    cell.size = CGSizeMake(TRScreenW, self.post.cellRowHeight);
    
    header.height = self.post.cellRowHeight + GFPieceCellMargin;
    
    [header addSubview:cell];
    
    //设置header
    self.tableView.tableHeaderView = header;
}


- (void)contentDidChange:(UITextField *)textField{
    
    if (textField.text.length > 0) {
        self.sendBtn.enabled = YES;
    }else {
        self.sendBtn.enabled = NO;
    }
    
}
- (void)loadNewComment{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"ID"] = @(self.post.ID);
    
    [TRHttpTool GET:TRGetCirleComment parameters:param success:^(id responseObject) {
        
        self.maxCount = [responseObject[@"maxCount"] integerValue];
        TRLog(@"%@",responseObject);
        self.comments = [TRPostComment mj_objectArrayWithKeyValuesArray:responseObject[@"comments"]];
        
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        //清空页码
        self.page = 1;
        self.tableView.mj_footer.hidden = NO;
        
        //监测footer的状态
        [self chackFooterState];
    } failure:^(NSError *error) {
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        [Toast makeText:@"加载失败!!"];
        self.tableView.mj_footer.hidden = NO;
    }];
}

- (void)loadMoreComment{
    NSInteger page = self.page + 1;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(page);
    param[@"ID"] = @(self.post.ID);
    
    [TRHttpTool GET:TRGetCirleComment parameters:param success:^(id responseObject) {
        
        [self.comments addObjectsFromArray:[TRPostComment mj_objectArrayWithKeyValuesArray:responseObject[@"comments"]]];
        
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        //
        self.page = page;
        
        
        //监测footer的状态
        [self chackFooterState];
        
    } failure:^(NSError *error) {
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        [Toast makeText:@"加载失败!!"];
    }];
}

/**
 *  监测footer的状态
 */
- (void)chackFooterState{
    if (self.comments.count == self.maxCount) {
        //没有更多数据
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.tableView.mj_footer resetNoMoreData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRPostCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCommentCell"];
    cell.comment = self.comments[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"评论";
}


/**
 *  跳转控制器
 */
- (void)loginVc {
    
    [Toast makeText:@"请先登录!"];
    
    TRLoginViewController *loginVc = [TRLoginViewController instantiateInitialViewControllerWithStoryboardName:@"LoginAndRegist"];
    loginVc.refreshDataBlock = ^ {
        
    };
    [self presentViewController:loginVc animated:YES completion:nil];
}

#pragma mark - 键盘弹出
- (void)keyboardDidChangeFrame:(NSNotification *) note{
    //获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取键盘弹起的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (frame.origin.y == TRScreenH) {
        self.BgView.hidden = YES;
    }else {
        self.BgView.hidden = NO;
    }
    
    
    
    self.textFiledLayout.constant = TRScreenH - frame.origin.y;
    
    [UIView animateWithDuration:duration animations:^{
        
        //强制布局
        [self.view layoutIfNeeded];
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
