//
//  TRMeTableViewController.m
//  TRHouse
//
//  Created by wgf on 16/9/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRMeTableViewController.h"
#import "TRMeHeaderView.h"
#import "TRLoginViewController.h"
#import "TRAccountTool.h"
#import "TRGetPersonalParam.h"
#import "TRAccount.h"
#import "TRProgressTool.h"
#import "TRPersonal.h"
#import "TRPersonalHomeViewController.h"
#import "TRSettingsTableViewController.h"


@interface TRMeTableViewController ()

@property (weak, nonatomic) IBOutlet UIView *headerView;


/** meHeader */
@property (nonatomic, strong) TRMeHeaderView *meHeader;

@end

@implementation TRMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // 设置tableView和nav相关
    [self setupHeaderViewAndNav];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //加载数据
    [self refreshData];
}

/**
 *  设置tableView和nav相关
 */
- (void) setupHeaderViewAndNav{
    
    self.navigationItem.title = @"我的";
    
    TRMeHeaderView *meHeader = [TRMeHeaderView meHeaderView];
    self.meHeader = meHeader;
    
    [self.headerView addSubview:meHeader];
    self.tableView.tableFooterView = [[UIView alloc] init];
    meHeader.loginBlock = ^{
        [self loginVc];
    };
    
}

/**
 *  跳转控制器
 */
- (void)loginVc {
    
    TRLoginViewController *loginVc = [TRLoginViewController instantiateInitialViewControllerWithStoryboardName:@"LoginAndRegist"];
    loginVc.refreshDataBlock = ^ {
        [self refreshData];
    };
    [self presentViewController:loginVc animated:YES completion:nil];
}


/**
 *  加载数据
 */
- (void)refreshData {
    
    if ([TRAccountTool loginState]) {
        
        if ([TRAccountTool account]) {
            
            TRGetPersonalParam *param = [[TRGetPersonalParam alloc] init];
            TRAccount *account = [TRAccountTool account];
            param.uid = account.uid;
            
            [TRHttpTool GET:TRGetPersonalUrl parameters:param.mj_keyValues success:^(id responseObject) {
                self.meHeader.personal = [TRPersonal mj_objectWithKeyValues:responseObject];
                
            } failure:^(NSError *error) {
                
                [Toast makeText:@"请检查网络连接!!"];
                
            }];
            
        }
        
    }else {
        
        TRPersonal *personal = [[TRPersonal  alloc] init];
        personal.userName = @"登录/注册";
        personal.icon = @"";
        personal.count = 0;
        self.meHeader.personal = personal;
    }
    
}

- (void)viewWillLayoutSubviews {
    
    self.meHeader.frame = self.headerView.frame;
    
}

/**
 *  个人主页
 */
- (IBAction)myHomePage {
    
    if ([TRAccountTool loginState]) {//已登录
        
        TRPersonalHomeViewController *homeVc = [TRPersonalHomeViewController viewControllerWtithStoryboardName:TRMeStoryboardName identifier:NSStringFromClass([TRPersonalHomeViewController class])];
        homeVc.personal = self.meHeader.personal;
        [self.navigationController pushViewController:homeVc animated:YES];
    }else {//未登录
        //跳转登录界面
        [self loginVc];
    }
    
}

/**
 *  个人设置
 */
- (IBAction)mySetting {
    
    if ([TRAccountTool loginState]) {//已登录
        
        TRSettingsTableViewController *settingVc = [TRSettingsTableViewController viewControllerWtithStoryboardName:TRMeStoryboardName identifier:NSStringFromClass([TRSettingsTableViewController class])];
        settingVc.logoutBlock = ^ {
            [self refreshData];
        };
        [self.navigationController pushViewController:settingVc animated:YES];
    }else {//未登录
        //跳转登录界面
        [self loginVc];
    }
    
}



@end
