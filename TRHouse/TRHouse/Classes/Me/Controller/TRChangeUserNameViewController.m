//
//  TRChangeUserNameViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/20.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRChangeUserNameViewController.h"
#import "Utilities.h"
#import "TRAccount.h"
#import "TRAccountTool.h"

@interface TRChangeUserNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@end

@implementation TRChangeUserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改昵称";
    self.userNameTextField.text = self.userName;
        
}

- (IBAction)commitBtnClick {
    
    [self.view endEditing:YES];
    
    if (self.userNameTextField.text.length <= 0) {
        [Utilities popUpAlertViewWithMsg:@"内容不能为空哦!" andTitle:nil];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    TRAccount *account = [TRAccountTool account];
    param [@"uid"] = account.uid;
    param[@"userName"] = self.userNameTextField.text;
    
    
    [TRHttpTool POST:TRChangeUserNameUrl parameters:param success:^(id responseObject) {
        NSInteger state = [responseObject[@"state"] integerValue];
        NSString *title = @"";
        
        if (state == 1) {
            title = @"修改成功";
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            title = @"修改失败, 请检查网络连接!";
        }
        
        [Toast makeText:title];
    } failure:^(NSError *error) {
        [Toast makeText:@"请检查网络连接!"];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
