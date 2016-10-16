//
//  TRMeHeaderView.h
//  TRHouse
//
//  Created by wgf on 16/10/13.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRMeHeaderView : UIView

+ (instancetype)meHeaderView;

/** 登录 */
@property (nonatomic, copy) void (^loginBlock)();

@end
