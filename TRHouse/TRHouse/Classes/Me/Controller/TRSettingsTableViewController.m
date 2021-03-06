//
//  TRSettingsTableViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/18.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRSettingsTableViewController.h"
#import "TRAccountTool.h"
#import "TRProgressTool.h"

@interface TRSettingsTableViewController ()

@end

@implementation TRSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setupNav];
}

- (void)setupNav{
    self.navigationItem.title = @"个人设置";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"返回";
    self.navigationItem.backBarButtonItem = item;
}

- (IBAction)logoutBtn {
    
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"退出当前登录" message:@"你确定要退出当前登录吗?" preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) weakSelf = self;
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        
        if (weakSelf.logoutBlock) {
            weakSelf.logoutBlock();
        }
        
        [TRAccountTool saveAccount:nil];
        [TRAccountTool saveLoginState:NO];
        
        [TRProgressTool showWithMessage:@"正在退出..."];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [TRProgressTool dismiss];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
        
    }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertControl animated:YES completion:nil];
    
}


- (void)dealloc
{
    TRLog(@"gg");
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
