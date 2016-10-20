//
//  TRMeInteractiveTableViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/18.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRMeInteractiveTableViewController.h"
#import "TRAccountTool.h"
#import "TRAccount.h"
#import "TRMeInteractive.h"
#import "TRMeInterTableViewCell.h"
#import "TRMeDetailTableViewController.h"

@interface TRMeInteractiveTableViewController ()


/** 存储一拍即合的请求 */
@property (nonatomic, strong) NSArray *meInteractive;

@end

@implementation TRMeInteractiveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    //加载数据
    [self setupRefresh];
    
}

//设置导航条相关
- (void)setupNav{
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationItem.title = @"互动";
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh{
    
    //添加下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    //根据拖拽比例自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //一进来就开始刷新
    [self.tableView.mj_header beginRefreshing];
    
}


- (void)loadData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    TRAccount *account = [TRAccountTool account];
    param[@"uid"] = account.uid;
    
    [TRHttpTool GET:TRGetMeInteractiveUrl parameters:param success:^(id responseObject) {
        
        self.meInteractive = [TRMeInteractive mj_objectArrayWithKeyValuesArray:responseObject];
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        
    } failure:^(NSError *error) {
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 1) {
        return 0;
    }else {
        return self.meInteractive.count;
    }
}

static NSString * const cellID = @"cellMe";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        TRMeInterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        cell.meInter = self.meInteractive[indexPath.row];
        
        return cell;
        
    }else {
        TRMeInterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        return cell;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section) {
        return @"我的互动";
    }else {
        return @"互动请求";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        TRMeDetailTableViewController *detailVc = [TRMeDetailTableViewController viewControllerWtithStoryboardName:TRMeStoryboardName identifier:NSStringFromClass([TRMeDetailTableViewController class])];
        detailVc.meInter = self.meInteractive[indexPath.row];
        [self.navigationController pushViewController:detailVc animated:YES];
    }
    
}

@end
