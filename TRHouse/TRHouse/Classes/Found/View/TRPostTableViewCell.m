//
//  TRPostTableViewCell.m
//  TRHouse
//
//  Created by admin1 on 2016/10/13.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRPostTableViewCell.h"
#import "TRPost.h"
#import "TRImageView.h"

@interface TRPostTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *postContent;
@property (weak, nonatomic) IBOutlet UILabel *userNamelbl;
@property (weak, nonatomic) IBOutlet UILabel *postTimelbl;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIButton *praiseUserBtn;

@property (weak, nonatomic) IBOutlet UIButton *commentCountBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *postCellrowHeight;
@property (nonatomic,strong)TRImageView *imageViews;



@end

@implementation TRPostTableViewCell


- (void)awakeFromNib{
    [super awakeFromNib];
    
    
//   TRImageView *view = [[TRImageView alloc]init];
//    self.imageViews = view;
//    [self.contentView addSubview:view];
//    view.backgroundColor = [UIColor redColor];
}

- (void)setPosts:(TRPost *)posts{
    _posts = posts;
    
    

    self.postContent.text = posts.postcontent;
    self.userNamelbl.text = posts.userName;
    self.postTimelbl.text = posts.posttime;
    [self.praiseUserBtn setTitle:[NSString stringWithFormat:@"%zd",posts.praiseUser.count]forState:UIControlStateNormal];
    [self.commentCountBtn setTitle:[NSString stringWithFormat:@"%zd",posts.commentCount]forState:UIControlStateNormal];

    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:posts.icon]placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

  
    NSString *users = [posts.praiseUser componentsJoinedByString:@","];
    NSRange range = [users rangeOfString:@"13426545523"];
    
    self.praiseUserBtn.enabled = range.length ? NO : YES;
    
    if (posts.postphotos.count == 0 ) {
        
        self.imageViews.hidden = YES;
    }else{
        self.imageViews.hidden = NO;
    }
    
}

- (IBAction)likeClickAction:(UIButton *)sender forEvent:(UIEvent *)event {
    sender.enabled = NO;
    NSMutableDictionary *parament = [NSMutableDictionary dictionary];
    parament[@"uid"] = @"13426545523";
    parament[@"ID"] =  @(self.posts.ID);
    
    [TRHttpTool POST:@"http://192.168.61.79:8080/TRHouse/like" parameters:parament success:^(id responseObject) {
        
        NSInteger state = [responseObject[@"state"] integerValue];
        if (state) {
            
            if (self.likeBlock) {
                self.likeBlock(self, parament[@"uid"]);
            }
            
        }else{
            
            sender.enabled = YES;
            [Toast makeText:@"点赞失败"];

            
        }
        
        
        
    } failure:^(NSError *error) {
        sender.enabled = YES;
        [Toast makeText:@"请检查网络连接"];
        
    }];
    
    
    
    
    
    if (!sender.enabled) {
        

    }
    
    
}

//- (void)layoutSubviews
//{
//    CGFloat margin = 10;
//    CGFloat maximgY = CGRectGetMaxY(self.postTimelbl.frame);
//    self.imageViews.frame = CGRectMake(10, maximgY, TRScreenW - 2 * margin, self.posts.imageHeight);
//    
//}

- (IBAction)commentClickAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
