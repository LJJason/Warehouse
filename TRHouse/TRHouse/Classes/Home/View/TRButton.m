//
//  TRButton.m
//  TRHouse
//
//  Created by wgf on 16/10/23.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRButton.h"
#define ImageW 17

@implementation TRButton

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
        //设置图片显示的样式
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW = contentRect.size.width - ImageW;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(0, 0, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageH = 10;
    CGFloat imageY = (contentRect.size.height - imageH) / 2;
    CGFloat imageW = ImageW;
    CGFloat imageX = contentRect.size.width - ImageW + 2;
    //self.imageView.contentMode = UIViewContentModeCenter;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
