//
//  GFPictureView.h
//  百思不得姐
//
//  Created by wgf on 16/5/16.
//  Copyright © 2016年 wgf. All rights reserved.
//  图片帖子中间的内容

#import <UIKit/UIKit.h>
@class GFPiece;
@interface GFPictureView : UIView

+ (instancetype) pictureView;

/** 模型 */
@property (nonatomic, strong) GFPiece *piece;

@end
