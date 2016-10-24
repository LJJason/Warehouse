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
    //设置内容模式(短边撑满, 多余部分剪裁掉, 图片看不全)
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = self.frame;
    //设置允许与用户交互
    imageView.userInteractionEnabled = YES;
    //创建手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigImage:)];
    //添加手势
    [imageView addGestureRecognizer:tap];
    self.imageView = imageView;
    [self.contentView addSubview:imageView];
    
}

- (void)seeBigImage:(UITapGestureRecognizer *)tap {
    
    if (tap.state == UIGestureRecognizerStateEnded) {
        if (self.didTapImageView) {
            self.didTapImageView();
        }
    }
}

@end
