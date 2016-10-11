//
//  UIBarButtonItem+GFExtension.h
//  百思不得姐
//
//  Created by wgf on 16/4/26.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GFExtension)
/**
 *  创建一个UIBarButtonItem
 *
 *  @param image   默认图片
 *  @param hlImage 高亮图片
 *  @param target  传入的对象
 *  @param action  传入的对象下的方法
 *
 *  @return 返回一个UIBarButtonItem
 */
+ (instancetype)itemWithImage:(NSString *)image hlImage:(NSString *)hlImage target:(id)target action:(SEL)action;

@end
