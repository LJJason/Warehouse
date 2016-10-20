//
//  TRInteractiveCell.h
//  TRHouse
//
//  Created by wgf on 16/10/18.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TRInteractive;

@interface TRInteractiveCell : UITableViewCell


/** 互动模型 */
@property (nonatomic, strong) TRInteractive *inter;

+ (instancetype)cell;

@end
