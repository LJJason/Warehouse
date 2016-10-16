//
//  TRGetVcCodeParam.h
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//  获取验证码请求的参数类

#import <Foundation/Foundation.h>

@interface TRGetVcCodeParam : NSObject

/** 账号(手机号) */
@property (nonatomic, copy) NSString *phoneNum;

@end
