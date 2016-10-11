//
//  GFPiece.h
//  百思不得姐
//
//  Created by wgf on 16/5/10.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GFPieceComment;

@interface GFPiece : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;

/** 昵称 */
@property (nonatomic, copy) NSString *name;
/** 头像的URL */
@property (nonatomic, copy) NSString *profile_image;
/** 内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子的转发数量 */
@property (nonatomic, assign)NSInteger repost;
/** 踩得人数 */
@property (nonatomic, assign)NSInteger cai;

/** 顶的人数 */
@property (nonatomic, assign)NSInteger ding;
/** 帖子的被评论的数量 */
@property (nonatomic, assign)NSInteger comment;

/** 帖子创建的时间 */
@property (nonatomic, copy) NSString *created_at;

/** 新浪加V */
@property (nonatomic, assign, getter=isSina_v) BOOL *sina_v;

/** 图片的宽度 */
@property (nonatomic, assign)CGFloat width;

/** 图片的高度 */
@property (nonatomic, assign)CGFloat height;

/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;

/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;

/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;

/** 帖子的类型 */
@property (nonatomic, assign) NSInteger type;

/** gif标识 */
@property (nonatomic, assign)BOOL is_gif;
/** 音频的时长*/
@property (nonatomic, assign)NSInteger voicetime;
/** 视频的时长*/
@property (nonatomic, assign)NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign)NSInteger playcount;
/** 最热评论 */
@property (nonatomic, strong) GFPieceComment *top_cmt;



/****************** 额外属性 ******************/
/** cell的高度 */
@property (nonatomic, assign, readonly)CGFloat cellHeight;

/** 是否是大图 */
@property (nonatomic, assign, getter=isBigPicture)BOOL bigPicture;
/** 图片下载进度条 */
@property (nonatomic, assign)CGFloat pictureProgress;

/** 图片View的frame */
@property (nonatomic, assign, readonly)CGRect pictureFrmae;


/** 音频View的frame */
@property (nonatomic, assign, readonly)CGRect voiceFrmae;


/** 视频View的frame */
@property (nonatomic, assign, readonly)CGRect videoFrmae;

@end
