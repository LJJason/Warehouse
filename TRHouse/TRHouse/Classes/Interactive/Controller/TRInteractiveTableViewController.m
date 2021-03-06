//
//  TRInteractiveTableViewController.m
//  TRHouse
//
//  Created by wgf on 16/9/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRInteractiveTableViewController.h"
#import "TRInteractive.h"
#import "TRInteractiveCell.h"
#import "CZComposeViewController.h"
#import "TRInteractiveCommentViewController.h"
#import "TRAccountTool.h"
#import "TRLoginViewController.h"
#import "TRAccount.h"
#import "TRNoInternetConnectionView.h"

@interface TRInteractiveTableViewController ()

/** 互动最大的条数 */
@property (nonatomic, assign) NSInteger maxCount;

/** 当前页码 */
@property (nonatomic, assign) NSInteger page;

/** 所有的互动信息 */
@property (nonatomic, strong) NSMutableArray *interactives;

/** 真实请求url */
@property (nonatomic, copy) NSString *urlString;

@end

@implementation TRInteractiveTableViewController

- (NSMutableArray *)interactives {
    if (!_interactives) {
        _interactives = [NSMutableArray array];
    }
    return _interactives;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //url处理
    [self setupUrl];
    
    //设置导航条
    [self setupNav];
    //设置刷新控件
    [self setupRefresh];
    
}

/**
 *  url处理
 */
- (void)setupUrl{
    if (self.urlStr == nil) {
        self.urlString = TRGetAllInteractiveUrl;
    }else {
        self.urlString = self.urlStr;
    }
}


/**
 *  设置导航条相关
 */
- (void)setupNav{
    self.navigationItem.title = @"互动";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(compose)];
}

static NSString * const cellId = @"TRInteractiveCell";

/**
 *  添加刷新控件
 */
- (void)setupRefresh{
    
    //添加下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInter)];
    //根据拖拽比例自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //一进来就开始刷新
    [self.tableView.mj_header beginRefreshing];
    
    //添加上拉刷新控件
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInter)];
    //隐藏点击加载更多
    self.tableView.mj_footer.hidden = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TRInteractiveCell class]) bundle:nil]  forCellReuseIdentifier:cellId];
}

/**
 *  加载新的数据
 */
- (void)loadNewInter{
    
    NSMutableDictionary *param = nil;
    
    if (self.urlStr) {
        param = [NSMutableDictionary dictionary];
        TRAccount *account = [TRAccountTool account];
        param[@"uid"] = account.uid;
    }
    
    [TRHttpTool GET:self.urlString parameters:param success:^(id responseObject) {
        
        self.maxCount = [responseObject[@"maxCount"] integerValue];
        
        self.interactives = [TRInteractive mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
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
        //显示错误界面
        [self showErrorView];
    }];
}


/**
 *  展示无网络连接页面
 */
- (void)showErrorView {
    
    TRNoInternetConnectionView *noInterNet = [TRNoInternetConnectionView noInternetConnectionView];
    noInterNet.frame = self.view.frame;
    noInterNet.reloadAgainBlock = ^{
        [self.tableView.mj_header beginRefreshing];
    };
    
    [self.view addSubview:noInterNet];
    
}

/**
 *  加载更多数据
 */
- (void)loadMoreInter{
    NSInteger page = self.page + 1;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(page);
    
    if (self.urlStr) {
        TRAccount *account = [TRAccountTool account];
        param[@"uid"] = account.uid;
    }
    
    [TRHttpTool GET:self.urlString parameters:param success:^(id responseObject) {
        
        [self.interactives addObjectsFromArray:[TRInteractive mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        
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
    if (self.interactives.count == self.maxCount) {
        //没有更多数据
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.tableView.mj_footer resetNoMoreData];
    }
}

- (void)compose{
    
    if ([TRAccountTool loginState]) {
        CZComposeViewController *compVc = [[CZComposeViewController alloc] init];
        compVc.composeInteractiveSuccessBlock = ^{
            [self.tableView.mj_header beginRefreshing];
        };
        
        [self.navigationController pushViewController:compVc animated:YES];
    }else{
        //没有登录
        [self loginVc];
    }
    
    
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.interactives.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRInteractiveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.inter = self.interactives[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRInteractive *inter = self.interactives[indexPath.row];
    
    return inter.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TRInteractiveCommentViewController *commentVc = [TRInteractiveCommentViewController viewControllerWtithStoryboardName:TRInteractiveStoryboardName identifier:NSStringFromClass([TRInteractiveCommentViewController class])];
    
    commentVc.inter = self.interactives[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
    
}

@end
