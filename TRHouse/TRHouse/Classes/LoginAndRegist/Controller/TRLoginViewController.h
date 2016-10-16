//
//  TRLoginViewController.h
//  TRHouse
//
//  Created by wgf on 16/10/15.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRLoginViewController : UIViewController

/** 刷新数据 */
@property (nonatomic, copy) void (^refreshDataBlock)();

@end
