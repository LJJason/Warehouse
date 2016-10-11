//
//  GFRecommendTags.h
//  百思不得姐
//
//  Created by wgf on 16/5/7.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFRecommendTags : NSObject

/** 推荐标签图片的URL字符串 */
@property (nonatomic, copy) NSString *image_list;

/** 推荐标签昵称 */
@property (nonatomic, copy) NSString *theme_name;

/** 推荐标签的订阅量 */
@property (nonatomic, assign)NSInteger sub_number;


@end
