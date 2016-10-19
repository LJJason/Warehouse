//
//  TRSettingsTableViewController.h
//  TRHouse
//
//  Created by wgf on 16/10/18.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRSettingsTableViewController : UITableViewController

/** 退出登录 */
@property (nonatomic, copy) void (^logoutBlock)();

@end
