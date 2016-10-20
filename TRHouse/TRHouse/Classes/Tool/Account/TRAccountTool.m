//
//  TRAccountTool.m
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRAccountTool.h"
#import "TRAccountParam.h"
#import "TRAccount.h"
#import "NSString+Hash.h"

#define TRAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]
#define TRUserFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"user.data"]

#define TRLoginStateKey @"TRLoginState"



@implementation TRAccountTool

+ (void)loginWithPhoneNum:(NSString *)phoneNum pwd:(NSString *)pwd success:(void (^)(TRLoginState))success failure:(void (^)(NSError *))failure {
    TRAccountParam *param = [[TRAccountParam alloc] init];
    param.phoneNum = phoneNum;
    //加密
    param.pwd = [pwd hmacSHA512StringWithKey:salt];
    
    [TRHttpTool POST:TRLoginUrl parameters:param.mj_keyValues success:^(id responseObject) {
        
        NSString *uid = responseObject[@"uid"];
        if ([uid isEqualToString:phoneNum]) {
            [TRAccountTool saveAccount:[TRAccount accountWithDict:responseObject]];
            //登录成功
            [TRAccountTool saveLoginState:YES];
            if (success) {
                success(TRLoginStateOK);
            }
            
        }else if ([uid isEqualToString:@"0"]) {
            
            if (success) {
                success(TRLoginStatePwdMistake);
            }
            
        }else {
            if (success) {
                success(TRLoginStateAccountNotExist);
            }
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
}

+ (void)saveAccount:(TRAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:TRAccountFileName];
}

//在类方法无法使用成员变量, 使用静态变量代替
static TRAccount *_account;

+ (TRAccount *)account {
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:TRAccountFileName];
    }
    
    
    return _account;
}

+ (void)saveUser:(TRUser *)user {
    [NSKeyedArchiver archiveRootObject:user toFile:TRUserFileName];
}

static TRUser *_user;

+ (TRUser *)user {
    if (_user == nil) {
        _user = [NSKeyedUnarchiver unarchiveObjectWithFile:TRUserFileName];
    }
    return _user;
}


+ (BOOL)loginState {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    return [userDefaultes boolForKey:TRLoginStateKey];
}

+ (void)saveLoginState:(BOOL)state {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    [userDefaultes setBool:state forKey:TRLoginStateKey];
    //同步
    [userDefaultes synchronize];
    
}
@end
