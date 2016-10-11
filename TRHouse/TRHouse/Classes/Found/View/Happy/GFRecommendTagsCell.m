//
//  GFRecommendTagsCell.m
//  百思不得姐
//
//  Created by wgf on 16/5/7.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "GFRecommendTagsCell.h"
#import "GFRecommendTags.h"
#import "UIImageView+GFExtension.h"

@interface GFRecommendTagsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;


@end


@implementation GFRecommendTagsCell

- (void)setRecommendTags:(GFRecommendTags *)recommendTags {
    
    _recommendTags = recommendTags;
    
    //设置图片
    [self.imageListImageView setHaderWithUrl:recommendTags.image_list];
    //设置昵称
    self.themeNameLabel.text = recommendTags.theme_name;
    
    NSString *subNumber = nil;
    
    if (recommendTags.sub_number > 10000) {
        subNumber = [NSString stringWithFormat:@"%.1f万人已订阅", recommendTags.sub_number / 10000.0];
    }else {
        subNumber = [NSString stringWithFormat:@"%zd人已订阅", recommendTags.sub_number];
    }
    //设置订阅量
    self.subNumberLabel.text = subNumber;
    
}


- (void) setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    
    frame.size.width -= 2 * frame.origin.x;
    
    frame.size.height -= 1;
    
    [super setFrame:frame];
   
}


@end
