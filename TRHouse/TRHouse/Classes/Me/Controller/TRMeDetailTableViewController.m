//
//  TRMeDetailTableViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/18.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRMeDetailTableViewController.h"
#import "TRMeInteractive.h"

@interface TRMeDetailTableViewController ()
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
/**
 *  互动内容
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
/**
 *  联系方式
 */
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;
/**
 *  同意按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
/**
 *  拒绝按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *refusedBtn;

@end

@implementation TRMeDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.agreeBtn.layer.cornerRadius = 5;
    self.agreeBtn.layer.borderWidth = 1.0;
    self.agreeBtn.layer.borderColor = [TRColor(0, 220, 255, 1.0) CGColor];
    
    self.refusedBtn.layer.cornerRadius = 5;
    self.refusedBtn.layer.borderWidth = 1.0;
    self.refusedBtn.layer.borderColor = [[UIColor redColor] CGColor];
    
    //设置头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.meInter.icon] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置昵称
    self.userNameLbl.text = self.meInter.userName;
    //设置时间
    self.timeLbl.text = self.meInter.time;
    
    
    
    [TRHttpTool GET:TRGetInteractiveUrl parameters:@{@"interactiveId" : @(self.meInter.interactiveId)} success:^(id responseObject) {
        
        self.contentLbl.text = responseObject[@"content"];
        
    } failure:^(NSError *error) {
        self.contentLbl.text = @"加载失败!";
    }];
}
/**
 *  同意按钮点击
 */
- (IBAction)agreeBtnClick {
}
/**
 *  拒绝按钮点击
 */
- (IBAction)refusedBtnClick {
}

@end
