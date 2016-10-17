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
    
}

+ (instancetype)meHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (IBAction)loginOrMe {
    
    if ([TRAccountTool account]) {
        
    }else {//没有登录
        if (self.loginBlock) {
            self.loginBlock();
        }
    }
    
}

@end
