//
//  TRAccountParam.h
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//  用户登录参数

#import <Foundation/Foundation.h>

@interface TRAccountParam : NSObject

/** 用户账号 */
@property (nonatomic, copy) NSString *phoneNum;

/** 用户密码 */
@property (nonatomic, copy) NSString *pwd;

@end
