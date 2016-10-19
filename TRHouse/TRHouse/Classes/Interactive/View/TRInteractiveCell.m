//
//  TRInteractiveCell.m
//  TRHouse
//
//  Created by wgf on 16/10/18.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRInteractiveCell.h"
#import "TRInteractive.h"

@interface TRInteractiveCell ()
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
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
/**
 *  配图
 */
@property (weak, nonatomic) IBOutlet UIImageView *photoVIew;
/**
 *  配图高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoLauout;
/**
 *  显示有几张配图的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *photoCountBtn;

@end

@implementation TRInteractiveCell

- (void)setInter:(TRInteractive *)inter {
    _inter  = inter;
    //设置头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:inter.icon] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置昵称
    self.userNameLbl.text = inter.userName;
    //设置时间
    self.timeLbl.text = inter.time;
    //设置内容
    self.contentLbl.text = inter.content;
    //设置配图
    if (inter.photos.count > 0) {
        [self.photoVIew sd_setImageWithURL:[NSURL URLWithString:inter.photos[0]] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
        self.photoCountBtn.hidden = NO;
        //设置图片个数
        [self.photoCountBtn setTitle:[NSString stringWithFormat:@"%zd", inter.photos.count] forState:UIControlStateNormal];
    }else {
        self.photoCountBtn.hidden = YES;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.inter.photos.count > 0) {
        self.photoLauout.constant = 200.0;
    }else {
        self.photoLauout.constant = 200.0;
    }
}

- (void)setFrame:(CGRect)frame {
    frame.origin.y += 10;
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
