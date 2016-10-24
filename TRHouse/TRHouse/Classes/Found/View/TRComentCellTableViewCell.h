//
//  TRComentCellTableViewCell.h
//  TRHouse
//
//  Created by admin1 on 2016/10/24.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TRPost;
@interface TRComentCellTableViewCell : UITableViewCell

/** 帖子模型 */
@property (nonatomic,strong) TRPost *post;

+ (instancetype)cell;

@end
