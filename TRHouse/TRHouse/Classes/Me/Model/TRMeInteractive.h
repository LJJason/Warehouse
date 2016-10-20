//
//  TRMeInteractive.h
//  TRHouse
//
//  Created by wgf on 16/10/18.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRMeInteractive : NSObject

/** userId */
@property (nonatomic, copy) NSString *userId;

/** 用户昵称 */
@property (nonatomic, copy) NSString *userName;

/** 用户头像 */
@property (nonatomic, copy) NSString *icon;

/** 互动id */
@property (nonatomic, assign) NSInteger interactiveId;

/** 创建时间 */
@property (nonatomic, copy) NSString *time;

@end
