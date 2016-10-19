//
//  TRInteractiveCommentCell.m
//  TRHouse
//
//  Created by wgf on 16/10/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRInteractiveCommentCell.h"
#import "TRInteractiveComment.h"

@interface TRInteractiveCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@end

@implementation TRInteractiveCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setComment:(TRInteractiveComment *)comment {
    _comment = comment;
    
    //设置头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:comment.icon] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置昵称
    self.userName.text = comment.userName;
    //设置内容
    self.contentLbl.text = comment.comments;
    
}

@end
