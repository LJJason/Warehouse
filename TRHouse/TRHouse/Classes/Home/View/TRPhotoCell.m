//
//  TRPhotoCell.m
//  TRHouse
//
//  Created by wgf on 16/10/24.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRPhotoCell.h"

@implementation TRPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = self.frame;
    self.imageView = imageView;
    [self.contentView addSubview:imageView];
    
}

@end
