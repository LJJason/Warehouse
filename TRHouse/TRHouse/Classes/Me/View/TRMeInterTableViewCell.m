//
//  TRMeInterTableViewCell.m
//  TRHouse
//
//  Created by wgf on 16/10/18.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRMeInterTableViewCell.h"
#import "TRMeInteractive.h"

@interface TRMeInterTableViewCell ()
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

@end


@implementation TRMeInterTableViewCell

- (void)setMeInter:(TRMeInteractive *)meInter {
    _meInter = meInter;
    //设置头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:meInter.icon] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    //设置昵称
    self.userNameLbl.text = meInter.userName;
    //设置时间
    self.timeLbl.text = meInter.time;
    
}

@end
