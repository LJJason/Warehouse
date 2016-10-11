//
//  GFCommentCell.h
//  百思不得姐
//
//  Created by wgf on 16/6/8.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GFPieceComment;

@interface GFCommentCell : UITableViewCell

/** 评论模型 */
@property (nonatomic, strong) GFPieceComment *comment;

@end
