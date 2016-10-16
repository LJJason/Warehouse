//
//  TRRegistTool.m
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRRegistTool.h"
#import "TRHttpTool.h"
#import "TRGetVcCodeParam.h"
#import "TRRegistParam.h"

////获取验证码的url
//#define TRGetVcCodeUrl   @"http://yearwood.top/TRMerchants/sendmessage"
////注册的接口
//#define TRRegistUrl      @"http://yearwood.top/TRMerchants/regist"

@implementation TRRegistTool

+ (void)getVcCodeWithParam:(TRGetVcCodeParam *)param success:(void (^)(TRGetVcCodeState))success failure:(void (^)(NSError *))failure {
    [TRHttpTool POST:TRGetVcCodeUrl parameters:param.mj_keyValues success:^(id responseObject) {
        
        NSString *ret = responseObject[@"ret"];
        
        TRGetVcCodeState state = TRGetVcCodeStateUnknownMistake;
        
        if ([ret isEqualToString:@"100"]) {
            //验证码发送成功
            state = TRGetVcCodeStateOK;
        }else if ([ret isEqualToString:@"102"]){
            //手机号格式不正确
            state = TRGetVcCodeStateInvalidFormat;
        }else if ([ret isEqualToString:@"108"]){
            //手机号发送太频繁
            state = TRGetVcCodeStateTooOften;
        }else if ([ret isEqualToString:@"110"]){
            //手机号发送短信太频繁, 被系统屏蔽数日
            state = TRGetVcCodeStateShielding;
        }else {
            //未知错误
            state = TRGetVcCodeStateUnknownMistake;
        }
        
        if (success) {
            success(state);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)registWithParam:(TRRegistParam *)param success:(void (^)(TRRegistState))success failure:(void (^)(NSError *))failure {
    [TRHttpTool POST:TRRegistUrl parameters:param.mj_keyValues success:^(id responseObject) {
        
        NSString *ret = [responseObject[@"state"] stringValue];
        
        TRRegistState state = TRRegistStateVcCodeMistake;
        
        if ([ret isEqualToString:@"20000"]) {
            state = TRRegistStateUserExist;
        }else if ([ret isEqualToString:@"20001"]){
            state = TRRegistStateOK;
        }else if ([ret isEqualToString:@"20002"]){
            state = TRRegistStateVcCodeMistake;
        }
        
        if (success) {
            success(state);
        }
        
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
