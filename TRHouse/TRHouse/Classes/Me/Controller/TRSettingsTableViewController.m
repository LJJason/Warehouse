//
//  TRSettingsTableViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/18.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRSettingsTableViewController.h"
#import "TRAccountTool.h"

@interface TRSettingsTableViewController ()

@end

@implementation TRSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)logoutBtn {
    
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"退出当前登录" message:@"你确定要退出当前登录吗?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        [TRAccountTool saveAccount:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertControl animated:YES completion:nil];
    
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
