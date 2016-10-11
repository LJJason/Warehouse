//
//  GFVideoView.h
//  百思不得姐
//
//  Created by wgf on 16/5/29.
//  Copyright © 2016年 wgf. All rights reserved.
// 视频帖子中间的内容

#import <UIKit/UIKit.h>
@class GFPiece;

@interface GFVideoView : UIView


+ (instancetype) videoView;

/** 模型 */
@property (nonatomic, strong) GFPiece *piece;

@end
