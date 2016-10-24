//
//  TRPhotoCell.h
//  TRHouse
//
//  Created by wgf on 16/10/24.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRPhotoCell : UICollectionViewCell

/** 图片 */
@property (nonatomic, weak) UIImageView *imageView;

/** 点击图片回调 */
@property (nonatomic, copy) void (^didTapImageView)();

@end
