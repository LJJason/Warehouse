//
//  GFUser.h
//  百思不得姐
//
//  Created by wgf on 16/5/30.
//  Copyright © 2016年 wgf. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

@interface GFUser : NSObject

/** 用户昵称 */
@property (nonatomic, copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

/** 用户性别 */
@property (nonatomic, copy) NSString *sex;


@end
