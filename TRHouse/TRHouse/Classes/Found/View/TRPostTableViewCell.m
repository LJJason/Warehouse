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

@property (weak, nonatomic) IBOutlet UIButton *commentCountBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *postCellrowHeight;
@property (weak, nonatomic) IBOutlet UIView *imageContent;


@end

@implementation TRPostTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    CGFloat margin = 10;
    
    CGFloat imgW = (TRScreenW - (margin * 4) ) / 3;
    CGFloat imgH = imgW;
    
    NSInteger imageCount ;
    
    if (self.posts.postphotos.count <= 9) {
        imageCount = self.posts.postphotos.count;
    }
//    else if (self.posts.postphotos.count > 9){
//        imageCount = 9;
//    }

    
    
    for (int i = 0; i < imageCount; i++) {
       
    CGFloat ImgX = (i%3)*(imgW+margin);
    CGFloat ImgY = (i/3)*(imgH+margin);
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(ImgX, ImgY, imgW, imgH)];
        imageV.backgroundColor = [UIColor redColor];
        [_imageContent addSubview:imageV];
        
        
    }
    
    
    
}


- (void)setPosts:(TRPost *)posts{
    _posts = posts;
    
    self.postContent.text = posts.postcontent;
    self.userNamelbl.text = posts.userName;
    self.postTimelbl.text = posts.posttime;
    [self.praiseUserBtn setTitle:[NSString stringWithFormat:@"%zd",posts.praiseUser.count]forState:UIControlStateNormal];
    [self.commentCountBtn setTitle:[NSString stringWithFormat:@"%zd",posts.commentCount]forState:UIControlStateNormal];
//    self.iconImage.image = [UIImage imageNamed:posts.icon];
//    [[SDWebImageDownloader sharedDownloader] setValue:@"iPhone" forHTTPHeaderField:@"User-Agent"];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:posts.icon]];
//    TRGLog(@"%@",posts.icon);
    TRLog(@"%@",self.posts.praiseUser);
    NSString *users = [posts.praiseUser componentsJoinedByString:@","];
    NSRange range = [users rangeOfString:@"13426545523"];
    
    TRLog(@"%@",users);
    
    self.praiseUserBtn.enabled = range.length ? NO : YES;
    
    
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
- (IBAction)commentClickAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
