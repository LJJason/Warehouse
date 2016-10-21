//
//  TRImageView.m
//  TRHouse
//
//  Created by admin1 on 2016/10/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRImageView.h"
#import "TRPost.h"
#import <HUPhotoBrowser.h>
@implementation TRImageView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        
        for (int i = 0; i < 9; i ++) {
            
            UIImageView *vw = [[UIImageView alloc]init];
            [self addSubview:vw];
           
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPhoto:)];
            [vw addGestureRecognizer:tap];
            vw.userInteractionEnabled = YES;
            vw.tag = i;
            vw.clipsToBounds = YES;
            
        }

        
    }
    
    
    return self;
}
- (void)setPhotos:(NSArray *)photos{
    _photos = photos;
    
    for (int i = 0; i < photos.count; i ++) {
        
        if (!photos) {
            
            return;
        }else{
        
        UIImageView *image = self.subviews[i];
        
        [image sd_setImageWithURL:photos[i] placeholderImage:[UIImage imageNamed:@"default_bg"]];
        }
    }
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 10;
    
    CGFloat imgW = (TRScreenW - 4 * margin) / 3;
    CGFloat imgH = imgW;
    
    //    NSInteger maxCols = photos.count == 4 ? 2 : 3;
    
    for (int i = 0; i < self.subviews.count; i ++) {
        
        UIImageView *imageView = self.subviews[i];
        
        
        
        if (i < self.photos.count) {
            
            
            imageView.hidden = NO;
            
            CGFloat imgX = (i % 3) * (imgW + margin);
            CGFloat imgY = (i / 3) * (imgW + margin);
            
            imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
            
            
        }else {
            imageView.hidden = YES;
        }
    }
    

}

- (void)tapPhoto:(UITapGestureRecognizer *)tap{
   
    UIImageView *view = (UIImageView *)tap.view;
    

    [HUPhotoBrowser showFromImageView:view withURLStrings:self.photos placeholderImage:[UIImage imageNamed:@"default_bg"] atIndex:view.tag dismiss:nil];
    
}
@end
