//
//  TRPostTableViewCell.h
//  TRHouse
//
//  Created by admin1 on 2016/10/13.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TRPost;
@interface TRPostTableViewCell : UITableViewCell

@property (nonatomic,strong) TRPost *posts;


/** 点赞按钮回调 */
@property (nonatomic,copy) void (^likeBlock)(TRPostTableViewCell *cell, NSString *user);


@end
