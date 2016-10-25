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
#import "TRAccount.h"
#import "TRAccountTool.h"
#import "TRLoginViewController.h"

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
    
    
   TRImageView *view = [[TRImageView alloc]init];
    view.clipsToBounds = YES;
    self.imageViews = view;
    [self.contentView addSubview:view];
    
    
    
}

- (void)setPosts:(TRPost *)posts{
    _posts = posts;
    
    self.imageViews.photos = posts.postphotos;

    self.postContent.text = posts.postcontent;
    self.userNamelbl.text = posts.userName;
    self.postTimelbl.text = posts.posttime;
    [self.praiseUserBtn setTitle:[NSString stringWithFormat:@"%zd",posts.praiseUser.count]forState:UIControlStateNormal];
    [self.commentCountBtn setTitle:[NSString stringWithFormat:@"%zd",posts.commentCount]forState:UIControlStateNormal];

    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:posts.icon]placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.iconImage.layer.cornerRadius = 17.5;
    self.iconImage.clipsToBounds = YES;

  
    NSString *users = [posts.praiseUser componentsJoinedByString:@","];
    TRAccount *account = [TRAccountTool account];
    
    if (account) {
        NSRange range = [users rangeOfString:account.uid];
        
        self.praiseUserBtn.enabled = range.length ? NO : YES;
    }
    
}

- (IBAction)likeClickAction:(UIButton *)sender forEvent:(UIEvent *)event {
    TRAccount *account = [TRAccountTool account];
    
    if (!account) {
        [self loginVc];
        return;
    }
    
    
    sender.enabled = NO;
    NSMutableDictionary *parament = [NSMutableDictionary dictionary];
    
    
    
    parament[@"uid"] = account.uid;
    parament[@"ID"] =  @(self.posts.ID);
    
    [TRHttpTool POST:TRLikeUrl parameters:parament success:^(id responseObject) {
        
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.posts.postphotos.count == 0 ) {
        
        self.imageViews.hidden = YES;
        self.imageViews.frame = CGRectMake(0, 0, 0, 0);
        
        
    }else{
        self.imageViews.hidden = NO;
        CGFloat margin = 10;
        CGFloat maximgY = self.posts.textMaxY+margin;
        self.imageViews.frame = CGRectMake(10, maximgY, self.posts.imageWidth, self.posts.imageHeight);
    }
    
    
    
}

+ (instancetype)cell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (IBAction)commentClickAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

/**
 *  跳转控制器
 */
- (void)loginVc {
    
    [Toast makeText:@"请先登录!"];
    
    TRLoginViewController *loginVc = [TRLoginViewController instantiateInitialViewControllerWithStoryboardName:@"LoginAndRegist"];
    loginVc.refreshDataBlock = ^ {
        
    };
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[2] presentViewController:loginVc animated:YES completion:nil];
    
}

@end
