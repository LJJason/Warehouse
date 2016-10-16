//
//  TRRegistViewController.h
//  TRHouse
//
//  Created by wgf on 16/10/15.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRRegistViewController : UIViewController

/** 点击返回按钮 */
@property (nonatomic, copy) void (^cancelBlock)();

/** 点击返回按钮执行动画前回调 */
@property (nonatomic, copy) void (^annimation)();

@end
