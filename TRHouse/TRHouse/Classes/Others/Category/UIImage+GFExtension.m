//
//  UIImage+GFExtension.m
//  百思不得姐
//
//  Created by wgf on 16/6/20.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "UIImage+GFExtension.h"

@implementation UIImage (GFExtension)


- (UIImage *)circleImage {
    //开启图形上下文, NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    //裁剪
    CGContextClip(ctx);
    
    //将图片画上去
    [self drawInRect:rect];
    
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
