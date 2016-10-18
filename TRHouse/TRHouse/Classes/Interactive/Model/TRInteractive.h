//
//  TRInteractive.h
//  TRHouse
//
//  Created by wgf on 16/10/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRInteractive : NSObject

/** id */
@property (nonatomic, assign) NSInteger ID;

/** 用户名 */
@property (nonatomic, copy) NSString *userName;

/** 头像 */
@property (nonatomic, copy) NSString *icon;

/** 用户账号 */
@property (nonatomic, copy) NSString *userId;

/** 内容 */
@property (nonatomic, copy) NSString *content;

/** 创建时间 */
@property (nonatomic, copy) NSString *time;

/** 相片路径 */
@property (nonatomic, strong) NSArray *photos;


/** 点赞用户汇总 */
@property (nonatomic, strong) NSArray *praiseUser;

/** 评论的数量 */
@property (nonatomic, assign) NSInteger commentCount;

/** cell的行高 */
@property (nonatomic, assign) CGFloat rowHeight;


@end
