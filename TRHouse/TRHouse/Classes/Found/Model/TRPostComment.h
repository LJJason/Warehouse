//
//  TRPostComment.h
//  TRHouse
//
//  Created by nankeyimeng on 16/10/23.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRPostComment : NSObject
/** id */
@property(nonatomic,assign) NSInteger ID;

/** 账号 */
@property(nonatomic,copy) NSString *userId;

/** 评论内容 */
@property(nonatomic,strong) NSString *comments;

/** 头像路径 */
@property(nonatomic,strong) NSString *icon;

/** 昵称 */
@property(nonatomic,strong) NSString *userName;
@end
