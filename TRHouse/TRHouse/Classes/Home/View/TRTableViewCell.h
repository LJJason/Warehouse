//
//  TRTableViewCell.h
//  TRHouse
//
//  Created by wgf on 16/10/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TRRoom;

@interface TRTableViewCell : UITableViewCell


/** 模型 */
@property (nonatomic, strong) TRRoom *room;

/**
 *  快速创建cell
 *
 *  @return cell
 */
+ (instancetype)cell;

@end
