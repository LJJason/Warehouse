//
//  TRSelectCityViewController.h
//  TRHouse
//
//  Created by wgf on 16/10/23.
//  Copyright © 2016年 wgf. All rights reserved.
//  城市选择控制器

#import <UIKit/UIKit.h>

@interface TRSelectCityViewController : UIViewController

/** 选择完城市的回调 */
@property (nonatomic, copy) void (^didSelectCityBlock)(NSString *city);

@end
