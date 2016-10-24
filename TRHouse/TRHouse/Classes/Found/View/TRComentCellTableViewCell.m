//
//  TRComentCellTableViewCell.m
//  TRHouse
//
//  Created by admin1 on 2016/10/24.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRComentCellTableViewCell.h"
#import "TRImageView.h"
#import "TRPost.h"
#import <HUPhotoBrowser.h>
@interface TRComentCellTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet TRImageView *imageVIews;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;

@end

@implementation TRComentCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
   
    
   
}
- (void)setPost:(TRPost *)post{

    _post  = post;


    //设置头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:post.icon] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置昵称
    self.userNameLbl.text = post.userName;
    //设置时间
    self.timeLbl.text = post.posttime;
    //设置内容
    self.contentLbl.text = post.postcontent;
    //设置配图
    if (post.postphotos.count > 0) {
        self.imageVIews.hidden = NO;
        self.imageVIews.photos = post.postphotos;
    }else {
    
        self.imageVIews.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_post.postphotos.count > 0) {
        self.imageHeight.constant = _post.imageHeight;
        self.imageWidth.constant  = _post.imageWidth;
        
    }else {
        self.imageHeight.constant = 0;
        self.imageWidth.constant  = 0;
    }
}


+ (instancetype)cell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


//- (void)setFrame:(CGRect)frame {
//    frame.origin.y += 10;
//    frame.size.height -= 10;
//    [super setFrame:frame];
//}
@end
