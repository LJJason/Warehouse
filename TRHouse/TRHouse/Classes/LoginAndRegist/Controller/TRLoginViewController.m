//
//  TRLoginViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/15.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRLoginViewController.h"
#import "TRNavigationController.h"
#import "TRRegistViewController.h"
#import "TRProgressTool.h"
#import "TRAccountTool.h"
#import "TRUser.h"
#import "Utilities.h"
#import "TRForgetPwdTableViewController.h"

@interface TRLoginViewController ()

/**
 *  手机号
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
/**
 *  密码
 */
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;


@end

@implementation TRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TRUser *user = [TRAccountTool user];
    self.phoneNumTextField.text = user.userName;
}

/**
 *  登录
 */
- (IBAction)login {
    NSString *userName = self.phoneNumTextField.text;
    NSString *pwd = self.pwdTextField.text;
    
    if (userName.length > 0 && pwd.length > 0) {
        [TRProgressTool showWithMessage:@"登录中..."];
        [TRAccountTool loginWithPhoneNum:userName pwd:pwd success:^(TRLoginState state) {
            
            [TRProgressTool dismiss];
            switch (state) {
                case TRLoginStateOK:
                {
                    TRUser *user = [[TRUser alloc] init];
                    user.userName = self.phoneNumTextField.text;
                    [TRAccountTool saveUser:user];
                    [self dismissViewControllerAnimated:YES completion:^{
                        if (self.refreshDataBlock) {
                            self.refreshDataBlock();
                        }
                    }];
                }
                    break;
                case TRLoginStateAccountNotExist:
                    
                    [Toast makeText:@"用户不存在!!"];
                    
                    break;
                    
                default:
                    [Toast makeText:@"用户名或密码输入错误!!"];
                    
                    break;
            }
            
        } failure:^(NSError *error) {
            TRLog(@"%@", error);
            [TRProgressTool dismiss];
            [Toast makeText:@"登录失败, 请检查网络连接!!"];
        }];
    }else {
        [Utilities popUpAlertViewWithMsg:@"请输入账号或密码" andTitle:nil];
    }
    
    
    
}



/**
 *  返回
 */
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  注册新用户
 */
- (IBAction)registClick {
    TRNavigationController *nav = [TRNavigationController viewControllerWtithStoryboardName:@"LoginAndRegist" identifier:@"TRNavigationController"];
    
    
    [self pushToNextViewController:nav];
    
    
}

- (IBAction)forgetPwdBtnClick {
    TRNavigationController *nav = [TRNavigationController viewControllerWtithStoryboardName:@"LoginAndRegist" identifier:@"UINavigationController"];

    [self pushForGetViewController:nav];
    
}

- (void)pushForGetViewController:(UIViewController *)nav {
    
    TRForgetPwdTableViewController *vc = nav.childViewControllers[0];
    vc.cancelBlock = ^ {
        
        if (self.childViewControllers.count > 0) {
            [self setValue:nil forKey:@"childViewControllers"];
        }
    };
    vc.annimation = ^ {
        self.view.x = 0;
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:nav.view];
    [self addChildViewController:nav];
    nav.view.frame = CGRectMake(TRScreenW, 0, TRScreenW, TRScreenH);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.x = -TRScreenW + 300;
        nav.view.x = 0;
    }];
}


- (void)pushToNextViewController:(UIViewController *)nav {
    
    TRRegistViewController *vc = nav.childViewControllers[0];
    vc.cancelBlock = ^ {
        
        if (self.childViewControllers.count > 0) {
            [self setValue:nil forKey:@"childViewControllers"];
        }
    };
    vc.annimation = ^ {
        self.view.x = 0;
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:nav.view];
    [self addChildViewController:nav];
    nav.view.frame = CGRectMake(TRScreenW, 0, TRScreenW, TRScreenH);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.x = -TRScreenW + 300;
        nav.view.x = 0;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
