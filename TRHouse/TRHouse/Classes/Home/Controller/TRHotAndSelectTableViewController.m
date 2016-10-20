//
//  TRHotAndSelectTableViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/20.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRHotAndSelectTableViewController.h"
#import "TRTableViewCell.h"
#import "TRRoom.h"

@interface TRHotAndSelectTableViewController ()


/** room模型数组 */
@property (nonatomic, strong) NSMutableArray *rooms;

/** 互动最大的条数 */
@property (nonatomic, assign) NSInteger maxCount;

/** 当前页码 */
@property (nonatomic, assign) NSInteger page;

@end

@implementation TRHotAndSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.navTitle;
    
    [self setupRefresh];
}

static NSString * const cellId = @"hotCellId";

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

/**
 *  加载新的数据
 */
- (void)loadNewRoom{
    
    
    [TRHttpTool GET:self.urlStr parameters:nil success:^(id responseObject) {
        
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
    
    [TRHttpTool GET:self.urlStr parameters:param success:^(id responseObject) {
        
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.rooms.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.room = self.rooms[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130.0;
}

@end
