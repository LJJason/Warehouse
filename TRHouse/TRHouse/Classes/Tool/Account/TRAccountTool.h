//
//  TRAccountTool.h
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//  专门处理账号业务

#import <Foundation/Foundation.h>

typedef enum {
    TRLoginStatePwdMistake      = 0,//密码错误
    TRLoginStateOK              = 1,//登录成功
    TRLoginStateAccountNotExist = 2 //用户不存在
}TRLoginState;

@class TRAccount, TRUser;


@interface TRAccountTool : NSObject

/**
 *  归档用户账号
 *
 *  @param account 用户模型
 */
+ (void)saveAccount:(TRAccount *)account;

/**
 *  读取用户
 *
 *  @return 用户模型
 */
+ (TRAccount *)account;

/**
 *  用户登录
 *
 *  @param phoneNum 账号
 *  @param pwd      密码
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+ (void)loginWithPhoneNum:(NSString *)phoneNum pwd:(NSString *)pwd success:(void(^)(TRLoginState state))success failure:(void(^)(NSError *error))failure;

/**
 *  存储用户账号
 *
 *  @param user 用户账号模型
 */
+ (void)saveUser:(TRUser *)user;
/**
 *  读取用户
 *
 *  @return 用户模型
 */
+ (TRUser *)user;

@end
