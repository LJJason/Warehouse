//
//  TRHomeTableViewController.m
//  TRHouse
//
//  Created by wgf on 16/9/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRHomeTableViewController.h"
#import "TRRoom.h"
#import "TRTableViewCell.h"
#import "TRHomeHeaderView.h"

@interface TRHomeTableViewController ()

/** 互动最大的条数 */
@property (nonatomic, assign) NSInteger maxCount;

/** 当前页码 */
@property (nonatomic, assign) NSInteger page;


/** 新品推荐的模型数组 */
@property (nonatomic, strong) NSMutableArray *rooms;


/** 推荐的模型数组 */
@property (nonatomic, strong) NSArray *recommendRoom;


/** header */
@property (nonatomic, strong) TRHomeHeaderView *headerView;

@end

@implementation TRHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条相关
    [self setupNav];
    
    [self setupHeader];
    
    //添加刷新控件
    [self setupRefresh];
}

- (void)setupHeader{
    
    TRHomeHeaderView *header = [[TRHomeHeaderView alloc] init];
    header.height = 400.0;
    self.headerView = header;
    self.tableView.tableHeaderView = header;
    
}

/**
 *  设置导航条相关
 */
- (void)setupNav{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_home"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_map"] style:UIBarButtonItemStyleDone target:self action:@selector(mapButtonClick)];
    self.navigationItem.title = @"首页";
}

static NSString * const cellId = @"cellId";

/**
 *  添加刷新控件
 */
- (void)setupRefresh{
    
    //添加下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewRoom)];
    //根据拖拽比例自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //一进来就开始刷新
    [self.tableView.mj_header beginRefreshing];
    
    //添加上拉刷新控件
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRoom)];
    //隐藏点击加载更多
    self.tableView.mj_footer.hidden = YES;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TRTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

- (void)loadRecommendData{
    
    [TRHttpTool GET:TRGetRecommendedRoomUrl parameters:nil success:^(id responseObject) {
        
        self.recommendRoom = [TRRoom mj_objectArrayWithKeyValuesArray:responseObject];
        self.headerView.rooms = self.recommendRoom;
        
    } failure:^(NSError *error) {
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        [Toast makeText:@"加载失败!!"];
        self.tableView.mj_footer.hidden = NO;
    }];
    
}

/**
 *  加载新的数据
 */
- (void)loadNewRoom{
    
    [self loadRecommendData];
    
    [TRHttpTool GET:TRGetNewRoomUrl parameters:nil success:^(id responseObject) {
        
        self.maxCount = [responseObject[@"maxCount"] integerValue];
        
        self.rooms = [TRRoom mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
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

/**
 *  加载更多数据
 */
- (void)loadMoreRoom{
    NSInteger page = self.page + 1;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(page);
    
    [TRHttpTool GET:TRGetAllInteractiveUrl parameters:param success:^(id responseObject) {
        
        [self.rooms addObjectsFromArray:[TRRoom mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        
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
    if (self.rooms.count == self.maxCount) {
        //没有更多数据
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.tableView.mj_footer resetNoMoreData];
    }
}

#pragma mark - mapButton

- (void)mapButtonClick
{
    NSLog(@"%s", __func__);
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.rooms.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.room = self.rooms[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"新品推荐";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130.0;
}
@end
