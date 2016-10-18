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
    if ([TRAccountTool account]) {
        
        [TRProgressTool showWithMessage:@"正在加载..."];
        
        TRGetPersonalParam *param = [[TRGetPersonalParam alloc] init];
        TRAccount *account = [TRAccountTool account];
        param.uid = account.uid;
        
        [TRHttpTool GET:TRGetPersonalUrl parameters:param.mj_keyValues success:^(id responseObject) {
            [TRProgressTool dismiss];
            self.meHeader.personal = [TRPersonal mj_objectWithKeyValues:responseObject];
            
        } failure:^(NSError *error) {
            
            [TRProgressTool dismiss];
            [Toast makeText:@"请检查网络连接!!"];
            
        }];
        
        
    }
    
    
}


- (void)viewWillLayoutSubviews {
    
    self.meHeader.frame = self.headerView.frame;
    
}

/**
 *  个人主页
 */
- (IBAction)myHomePage {
    
    if ([TRAccountTool account]) {//已登录
        
        
        
    }else {//未登录
        //跳转登录界面
        [self loginVc];
    }
    
    
}

/**
 *  个人设置
 */
- (IBAction)mySetting {
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    id destinationViewController = segue.destinationViewController;
    
    if ([destinationViewController isKindOfClass:[TRPersonalHomeViewController class]]) {
        TRPersonalHomeViewController *homeVc = destinationViewController;
        homeVc.personal = self.meHeader.personal;
    }
    
}


@end
