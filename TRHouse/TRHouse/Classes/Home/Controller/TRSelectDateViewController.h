//
//  TRSelectDateViewController.h
//  TRHouse
//
//  Created by wgf on 16/10/23.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRSelectDateViewController : UIViewController

/** 选完日期回调 */
@property (nonatomic, copy) void (^didSelectDateBlock)(NSString *firstDateStr, NSString *lastDateStr, NSInteger count);

@end
