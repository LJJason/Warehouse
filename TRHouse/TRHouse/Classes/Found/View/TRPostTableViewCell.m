//
//  TRPostTableViewCell.m
//  TRHouse
//
//  Created by admin1 on 2016/10/13.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRPostTableViewCell.h"
#import "TRPost.h"
@interface TRPostTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *postContent;
@property (weak, nonatomic) IBOutlet UILabel *userNamelbl;
@property (weak, nonatomic) IBOutlet UILabel *postTimelbl;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIButton *praiseUserBtn;
- (IBAction)likeClickAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIButton *commentCountBtn;
- (IBAction)commentClickAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation TRPostTableViewCell


- (void)setPosts:(TRPost *)posts{
    _posts = posts;
    
    self.postContent.text = posts.postcontent;
    self.userNamelbl.text = posts.userName;
    [self.praiseUserBtn setTitle:[NSString stringWithFormat:@"%zd",posts.praiseUser.count]forState:UIControlStateNormal];
    [self.commentCountBtn setTitle:[NSString stringWithFormat:@"%zd",posts.commentCount]forState:UIControlStateNormal];
//    self.iconImage.image = [UIImage imageNamed:posts.icon];
//    [[SDWebImageDownloader sharedDownloader] setValue:@"iPhone" forHTTPHeaderField:@"User-Agent"];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:posts.icon]];
    TRGLog(@"%@",posts.icon);
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)likeClickAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
    sender.enabled = NO;
    
    if (!sender.enabled) {
        

    }
    
    
}
- (IBAction)commentClickAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
