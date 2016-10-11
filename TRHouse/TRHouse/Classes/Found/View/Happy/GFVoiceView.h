//
//  GFVoiceView.h
//  百思不得姐
//
//  Created by wgf on 16/5/29.
//  Copyright © 2016年 wgf. All rights reserved.
// 声音帖子中间的内容

#import <UIKit/UIKit.h>
@class GFPiece;

@interface GFVoiceView : UIView


+ (instancetype) voiceView;

/** 模型 */
@property (nonatomic, strong) GFPiece *piece;

@end
