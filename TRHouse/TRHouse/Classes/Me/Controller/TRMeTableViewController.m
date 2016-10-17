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
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
