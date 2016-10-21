//
//  TRChangeasswordTableViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/22.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRChangeasswordTableViewController.h"
#import "Utilities.h"
#import "TRAccountTool.h"
#import "TRAccount.h"
#import "NSString+Hash.h"
#import "TRProgressTool.h"

@interface TRChangeasswordTableViewController ()
/**
 *  旧密码文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *oldPwdTextField;
/**
 *  新密码文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *theNewPwdTextField;
/**
 *  再次输入密码文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *againPwdTextField;

@end

@implementation TRChangeasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
}

/**
 *  提交
 */
- (IBAction)commitBtnClick {
    
    [self.view endEditing:YES];
    
    if (!(self.oldPwdTextField.text.length > 0 &&
          self.theNewPwdTextField.text.length > 0 &&
          self.againPwdTextField.text.length > 0)) {
        [Utilities popUpAlertViewWithMsg:@"请将信息填写完整!" andTitle:nil];
        return;
    }
    
    if (![self.theNewPwdTextField.text isEqualToString:self.againPwdTextField.text]) {
        [Utilities popUpAlertViewWithMsg:@"两次输入的密码不一致!" andTitle:nil];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    TRAccount *account = [TRAccountTool account];
    param[@"uid"] = account.uid;
    param[@"oldPwd"] = [self.oldPwdTextField.text hmacSHA512StringWithKey:salt];
    param[@"theNewPwd"] = [self.theNewPwdTextField.text hmacSHA512StringWithKey:salt];
    
    [TRProgressTool showWithMessage:@"正在修改..."];
    
    [TRHttpTool POST:TRChangeTheOldPwd parameters:param success:^(id responseObject) {
        
        NSInteger state = [responseObject[@"state"] integerValue];
        
        if (state == 1) {
            //退出登录
            [TRAccountTool saveLoginState:NO];
            //清除账号信息
            [TRAccountTool saveAccount:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [TRProgressTool dismiss];
                [Toast makeText:@"修改成功, 请重新登录!"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }else if (state == 2){
            [TRProgressTool dismiss];
            [Toast makeText:@"原密码错误!"];
        }else if (state == 3){
            [TRProgressTool dismiss];
            [Toast makeText:@"新密码不能和原密码一样哦!"];
        }else {
            [TRProgressTool dismiss];
            [Toast makeText:@"修改失败, 请检查网络连接!"];
        }
        
    } failure:^(NSError *error) {
        TRLog(@"%@", error);
        [TRProgressTool dismiss];
        [Toast makeText:@"修改失败, 请检查网络连接!"];
    }];
}


@end
