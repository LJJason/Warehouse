//
//  UIViewController+TRExtension.h
//  TRMerchants
//
//  Created by wgf on 16/9/27.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TRExtension)

/** 根据Storyboard名 和 Storyboard ID 获得控制器 */
+ (instancetype)viewControllerWtithStoryboardName:(NSString *)name identifier:(NSString *)identifier;


/** 从MainStoryboard 根据 Storyboard ID 获得控制器 */
+ (instancetype)viewControllerWtithMainStoryboardIdentifier:(NSString *)identifier;

/** 根据Storyboard名 获得箭头指向的控制器 */
+ (instancetype)instantiateInitialViewControllerWithStoryboardName:(NSString *)name;

@end
