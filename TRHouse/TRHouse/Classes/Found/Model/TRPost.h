//
//  TRPost.h
//  TRHouse
//
//  Created by admin1 on 2016/10/13.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRPost : NSObject
/** 评论数量 */
@property (nonatomic,assign) NSInteger commentCount;
/** 发帖子用户的头像 */
@property (nonatomic,copy) NSString *icon;
/** 帖子id */
@property (nonatomic,assign) NSInteger ID;
/** 帖子内容 */
@property (nonatomic,copy) NSString *postcontent;
/** 帖子配图 */
@property (nonatomic,strong) NSArray *postphotos;
/** 帖子创建时间 */
@property (nonatomic,copy) NSString *posttime;
/** 点赞的用户 */
@property (nonatomic,strong) NSArray *praiseUser;
/** 发帖用户id(手机号码) */
@property (nonatomic,copy) NSString *userid;
/** 发帖用户昵称 */
@property (nonatomic,copy) NSString *userName;



@end
