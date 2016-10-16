//
//  TRRegistViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/15.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRRegistViewController.h"
#import "TRRegistTool.h"
#import "TRRegistParam.h"
#import "TRGetVcCodeParam.h"
#import "Utilities.h"
#import "TRProgressTool.h"

@interface TRRegistViewController ()

/**
 *  手机号文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
/**
 *  验证码文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *vcCodeTextField;
/**
 *  获取验证码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *getvcCodeBtn;
/**
 *  密码文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
/**
 *  再次输入密码文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *againPwdTextField;

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

/** 倒计时索引 */
@property (nonatomic, assign) NSInteger index;

@end

@implementation TRRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.index = 60;
    
}

- (IBAction)getVcCodeBtnClick {
    
    TRGetVcCodeParam *param = [[TRGetVcCodeParam alloc] init];
    if (self.phoneNumTextField.text.length <= 0) {
        [Utilities popUpAlertViewWithMsg:@"请输入手机号" andTitle:nil];
        return;
    }
    
    param.phoneNum = self.phoneNumTextField.text;
    
    [TRRegistTool getVcCodeWithParam:param success:^(TRGetVcCodeState state) {
        
        switch (state) {
            case TRGetVcCodeStateOK:
                [Toast makeText:@"发送成功!"];
                [self showCountDown];
                break;
            case TRGetVcCodeStateInvalidFormat:
                [Toast makeText:@"手机号格式错误!"];
                break;
                
            case TRGetVcCodeStateTooOften:
                [Toast makeText:@"手机号使用太频繁!"];
                break;
            case TRGetVcCodeStateShielding:
                [Toast makeText:@"手机号使用太频繁,被屏蔽数日!"];
                break;
                
            default:
                [Toast makeText:@"未知错误!!"];
                break;
        }
        
        
    } failure:^(NSError *error) {
        [Toast makeText:@"请检查网络连接!"];
    }];
}

/**
 *  开始计时
 */
- (void)showCountDown{
    self.index = 60;
    self.getvcCodeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.getvcCodeBtn setTitle:@"60秒后重新获取" forState:UIControlStateDisabled];
    self.getvcCodeBtn.enabled = NO;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    self.timer = timer;
    
}

/**
 *  倒计时
 */
- (void)countdown {
    self.index--;
    if (self.index >= 0) {
        NSString *title = [NSString stringWithFormat:@"%zd秒后重新获取", self.index];
        [self.getvcCodeBtn setTitle:title forState:UIControlStateDisabled];
        //        [self.vcCodeButton setBackgroundColor:[UIColor lightGrayColor]];
    }else {
        //停止定时器
        [self.timer invalidate];
        self.timer = nil;
        self.getvcCodeBtn.enabled = YES;
        self.getvcCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    
    
}

/**
 *  提交
 */
- (IBAction)commitBtnClick {
    
    [self.view endEditing:YES];
    
    if (!(self.phoneNumTextField.text.length > 0 &&
          self.pwdTextField.text.length > 0 &&
          self.againPwdTextField.text.length > 0 &&
          self.vcCodeTextField.text.length > 0)) {
        [Utilities popUpAlertViewWithMsg:@"请将信息填写完整!" andTitle:nil];
        return;
    }
    
    if (![self.pwdTextField.text isEqualToString:self.againPwdTextField.text]) {
        [Utilities popUpAlertViewWithMsg:@"两次输入的密码不一致!" andTitle:nil];
        return;
    }
    
    TRRegistParam *param = [[TRRegistParam alloc] init];
    param.phoneNum = self.phoneNumTextField.text;
    param.pwd = self.pwdTextField.text;
    param.verificationCode = self.vcCodeTextField.text;
    [TRProgressTool showWithMessage:@"注册中..."];
    [TRRegistTool registWithParam:param success:^(TRRegistState state) {
        [TRProgressTool dismiss];
        switch (state) {
            case TRRegistStateOK:
                [Toast makeText:@"注册成功, 请登录!!"];
                [self cancel];
                break;
            case TRRegistStateUserExist:
                [Toast makeText:@"用户已存在!!"];
                break;
                
            default:
                [Toast makeText:@"验证码错误!!"];
                break;
        }
        
    } failure:^(NSError *error) {
        [Toast makeText:@"请检查网络连接!!"];
    }];

}








/**
 *  取消  返回上一页
 */
- (IBAction)cancel {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.navigationController.view.frame = CGRectMake(TRScreenW + 20, 0, TRScreenW, TRScreenH);
        self.annimation();
        [self.view endEditing:YES];
    } completion:^(BOOL finished) {
        
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }];
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
