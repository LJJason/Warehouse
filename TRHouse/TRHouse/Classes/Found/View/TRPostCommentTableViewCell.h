//
//  TRPostCommentTableViewCell.h
//  TRHouse
//
//  Created by nankeyimeng on 16/10/23.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TRPostComment;
@interface TRPostCommentTableViewCell : UITableViewCell

/** 邻居圈评论模型 */
@property(nonatomic,strong) TRPostComment *comment;


@end
