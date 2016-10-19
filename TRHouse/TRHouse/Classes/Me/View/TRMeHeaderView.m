//
//  TRMeHeaderView.m
//  TRHouse
//
//  Created by wgf on 16/10/13.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRMeHeaderView.h"

#import "TRAccountTool.h"
#import "TRPersonal.h"
#import "TRPersonalHomeViewController.h"
#import "TRMeInteractiveTableViewController.h"

@interface TRMeHeaderView ()

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
/**
 *  互动按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *interactiveBtn;

@end


@implementation TRMeHeaderView

- (void)setPersonal:(TRPersonal *)personal {
    _personal = personal;
    
    //设置头像
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:personal.icon] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置用户昵称
    self.userNameLbl.text = personal.userName;
    
    //设置互动
    [self.interactiveBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%zd", personal.count]] forState:UIControlStateNormal];
    TRLog(@"%zd", personal.count);
}

+ (instancetype)meHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (IBAction)loginOrMe {
    
    if ([TRAccountTool loginState]) {
        TRPersonalHomeViewController *homeVc = [TRPersonalHomeViewController viewControllerWtithStoryboardName:TRMeStoryboardName identifier:NSStringFromClass([TRPersonalHomeViewController class])];
        
        homeVc.personal = self.personal;
        
        [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[3] pushViewController:homeVc animated:YES];
        
    }else {//没有登录
        if (self.loginBlock) {
            self.loginBlock();
        }
    }
    
}


- (IBAction)interactiveBtnClick {
    
    if ([TRAccountTool loginState]) {
        TRMeInteractiveTableViewController *inter = [TRMeInteractiveTableViewController viewControllerWtithStoryboardName:TRMeStoryboardName identifier:NSStringFromClass([TRMeInteractiveTableViewController class])];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[3] pushViewController:inter animated:YES];
        
    }else {//没有登录
        if (self.loginBlock) {
            self.loginBlock();
        }
    }
    
}


@end
