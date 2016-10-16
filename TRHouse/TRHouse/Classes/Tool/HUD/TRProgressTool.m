//
//  TRProgressTool.m
//  TRMerchants
//
//  Created by wgf on 16/10/7.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRProgressTool.h"
#import <SVProgressHUD.h>

@implementation TRProgressTool

+ (void)showWithMessage:(NSString *)message {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:message];
    
    
}

+ (void)dismiss {
    [SVProgressHUD dismiss];
}

@end
