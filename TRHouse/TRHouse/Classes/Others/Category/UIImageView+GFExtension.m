

//
//  UIImageView+GFExtension.m
//  百思不得姐
//
//  Created by wgf on 16/6/20.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "UIImageView+GFExtension.h"
#import "UIImage+GFExtension.h"

@implementation UIImageView (GFExtension)

- (void)setHaderWithUrl:(NSString *)url {
    
    UIImage *placehoder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placehoder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placehoder;
    }];
    
}

@end
