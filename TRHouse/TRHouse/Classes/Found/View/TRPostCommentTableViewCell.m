//
//  TRPostCommentTableViewCell.m
//  TRHouse
//
//  Created by nankeyimeng on 16/10/23.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRPostCommentTableViewCell.h"
#import "TRPostComment.h"

@interface TRPostCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *namelbl;
@property (weak, nonatomic) IBOutlet UILabel *contentlbl;

@end

@implementation TRPostCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComment:(TRPostComment *)comment {
    _comment = comment;
    
    //设置头像
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:comment.icon] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置昵称
    self.namelbl.text = comment.userName;
    //设置内容
    self.contentlbl.text = comment.comments;
    
}



@end
