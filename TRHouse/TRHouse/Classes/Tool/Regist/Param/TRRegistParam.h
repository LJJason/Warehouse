//
//  TRRegistParam.h
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//  注册的参数类

#import "TRGetVcCodeParam.h"

@interface TRRegistParam : TRGetVcCodeParam

/** 密码 */
@property (nonatomic, copy) NSString *pwd;

/** 验证码 */
@property (nonatomic, copy) NSString *verificationCode;

@end
