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
#import "TRRoomDetailViewController.h"
#import "LNSearchManager.h"
#import "LNLocationManager.h"
#import "TRButton.h"
#import "TRSelectCityViewController.h"
#import "TRNavigationController.h"

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

/**
 *  反地理编码管理者
 */
@property (nonatomic, strong) LNSearchManager *searchManager;

/**
 *  定位管理者
 */
@property (nonatomic, strong) LNLocationManager *locationManager;


/** 导航条左边的按钮 */
@property (nonatomic, strong) TRButton *leftButton;

/** 地标 */
@property (nonatomic, strong) CLPlacemark *placemark;

/** 城市 */
@property (nonatomic, copy) NSString *city;

@end

@implementation TRHomeTableViewController

/**
 *  懒加载
 */
- (LNLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[LNLocationManager alloc] init];
    }
    return _locationManager;
}

- (LNSearchManager *)searchManager {
    if (_searchManager == nil) {
        _searchManager = [[LNSearchManager alloc] init];
    }
    return _searchManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //定位
    [self setupLocation];
    
    //设置导航条相关
    [self setupNav];
    
    [self setupHeader];
    
    //添加刷新控件
    [self setupRefresh];
}
/**
 *  定位
 */
- (void)setupLocation{
    [self.locationManager startWithBlock:^{} completionBlock:^(CLLocation *location) {
        //定位成功
        //开始反地理编码
        [self.searchManager startReverseGeocode:location completeionBlock:^(LNLocationGeocoder *locationGeocoder, CLPlacemark *placemark, NSError *error) {
            if (!error) {
                self.placemark = placemark;
                self.headerView.placemark = placemark;
                NSMutableString *mutableString = [NSMutableString stringWithFormat:@"%@",locationGeocoder.city];
                NSString *title = [mutableString stringByReplacingOccurrencesOfString:@"市" withString:@""];
                self.city = title;
                [self.leftButton setTitle:title forState:UIControlStateNormal];
                [self.leftButton sizeToFit];
                [self.tableView.mj_header beginRefreshing];
            }else {
                TRLog(@"%@", error);
            }
            
        }];
        
    } failure:^(CLLocation *location, NSError *error) {
        //定位失败
        [Toast makeText:@"定位失败!"];
    }];
}

/**
 *  设置顶部轮播视图
 */
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
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_map"] style:UIBarButtonItemStyleDone target:self action:@selector(mapButtonClick)];
    self.navigationItem.title = @"首页";
    
    TRButton *button = [TRButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"全部" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"nav_ down"] forState:UIControlStateNormal];
    self.leftButton = button;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button sizeToFit];
    [button addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

/**
 *  跳转城市选择控制器
 */
- (void)selectCity{
    //城市选择控制器
    TRSelectCityViewController *selectCityVc = [[TRSelectCityViewController alloc] init];
    selectCityVc.didSelectCityBlock = ^(NSString *city){
        //选择完城市
        [self.leftButton setTitle:city forState:UIControlStateNormal];
        [self.leftButton sizeToFit];
        self.city = city;
        [self.tableView.mj_header beginRefreshing];
    };
    
    TRNavigationController *nav = [[TRNavigationController alloc] initWithRootViewController:selectCityVc];
    
    [self presentViewController:nav animated:YES completion:nil];
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

/**
 *  加载顶部轮播的数据
 */
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
    
    NSMutableDictionary *param;
    
    if (self.city) {
        param = [NSMutableDictionary dictionary];
        param[@"region"] = self.city;
    }
    
    [TRHttpTool GET:TRGetNewRoomUrl parameters:param success:^(id responseObject) {
        
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
    //如果定位到了城市或者选择了城市
    if (self.city) {
        param[@"region"] = self.city;
    }
    
    [TRHttpTool GET:TRGetNewRoomUrl parameters:param success:^(id responseObject) {
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TRRoomDetailViewController *detail = [TRRoomDetailViewController viewControllerWtithStoryboardName:TRHomeStoryboardName identifier:NSStringFromClass([TRRoomDetailViewController class])];
    detail.room = self.rooms[indexPath.row];
    detail.placemark = self.placemark;
    [self.navigationController pushViewController:detail animated:YES];

}
@end
















