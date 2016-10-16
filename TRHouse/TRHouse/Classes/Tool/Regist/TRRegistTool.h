//
//  TRRegistTool.h
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TRGetVcCodeParam, TRRegistParam;

/**
    注册状态
 */
typedef enum {
    TRRegistStateUserExist       = 20000,//用户已存在
    TRRegistStateOK              = 20001,//注册成功
    TRRegistStateVcCodeMistake   = 20002 //验证码错误
}TRRegistState;

/**
    获取验证码状态
 */
typedef enum {
    TRGetVcCodeStateOK                          = 100,//发送成功
    TRGetVcCodeStateInvalidFormat               = 102,//手机格式错误
    TRGetVcCodeStateTooOften                    = 108, //手机号发送太频繁
    TRGetVcCodeStateShielding                   = 110,  //手机号连续发送太频繁,手机号被屏蔽数日
    TRGetVcCodeStateUnknownMistake                      //未知错误
}TRGetVcCodeState;

@interface TRRegistTool : NSObject

/**
 *  获取验证码
 *
 *  @param param   验证码参数模型
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getVcCodeWithParam:(TRGetVcCodeParam *)param
                   success:(void(^)(TRGetVcCodeState state))success
                   failure:(void(^)(NSError *error))failure;

/**
 *  注册
 *
 *  @param param   注册参数模型
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)registWithParam:(TRRegistParam *)param
                success:(void(^)(TRRegistState state))success
                failure:(void(^)(NSError *error))failure;


@end
