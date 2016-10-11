//
//  GFPieceCell.h
//  百思不得姐
//
//  Created by wgf on 16/5/12.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GFPiece;
@interface GFPieceCell : UITableViewCell

+ (instancetype)cell;

/** 帖子模型 */
@property (nonatomic, strong) GFPiece *piece;
@end
