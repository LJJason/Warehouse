//
//  UIViewController+TRExtension.m
//  TRMerchants
//
//  Created by wgf on 16/9/27.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "UIViewController+TRExtension.h"

@implementation UIViewController (TRExtension)

+ (instancetype)viewControllerWtithStoryboardName:(NSString *)name identifier:(NSString *)identifier {
    
    //创建Storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];

    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    
    return viewController;
}

+ (instancetype)viewControllerWtithMainStoryboardIdentifier:(NSString *)identifier {
    return [self viewControllerWtithStoryboardName:@"Main" identifier:identifier];
}

+ (instancetype)instantiateInitialViewControllerWithStoryboardName:(NSString *)name {
    return [[UIStoryboard storyboardWithName:name bundle:nil] instantiateInitialViewController];
}

@end
