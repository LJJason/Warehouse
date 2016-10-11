//
//  GFPieceComment.h
//  百思不得姐
//
//  Created by wgf on 16/5/30.
//  Copyright © 2016年 wgf. All rights reserved.
//  评论模型

#import <Foundation/Foundation.h>

@class GFUser;

@interface GFPieceComment : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;

/** 评论内容 */
@property (nonatomic, copy) NSString *content;
/** 点赞数 */
@property (nonatomic, assign)NSInteger like_count;
/** 用户模型 */
@property (nonatomic, strong) GFUser *user;

/** 音频评论的url */
@property (nonatomic, copy) NSString *voiceuri;

/** 音频 */
@property (nonatomic, assign) NSInteger voicetime;

@end
