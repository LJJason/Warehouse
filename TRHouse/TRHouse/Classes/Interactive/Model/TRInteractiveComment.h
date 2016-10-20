//
//  TRInteractiveComment.h
//  TRHouse
//
//  Created by wgf on 16/10/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRInteractiveComment : NSObject

/** id */
@property (nonatomic, assign) NSInteger ID;

/** 账号 */
@property (nonatomic, copy) NSString *userId;

/** 评论内容 */
@property (nonatomic, copy) NSString *comments;

/** 头像路径 */
@property (nonatomic, copy) NSString *icon;

/** 昵称 */
@property (nonatomic, copy) NSString *userName;

@end
