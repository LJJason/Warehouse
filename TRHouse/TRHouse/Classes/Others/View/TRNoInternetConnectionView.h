//
//  TRNoInternetConnectionView.h
//  TRMerchants
//
//  Created by wgf on 16/10/9.
//  Copyright © 2016年 wgf. All rights reserved.
//  当无网络连接时展示这个View

#import <UIKit/UIKit.h>

@interface TRNoInternetConnectionView : UIView

/**
 *  直接快速创建
 *
 *  @return TRNoInternetConnectionView
 */
+ (instancetype)noInternetConnectionView;

/** 重新加载按钮回调 */
@property (nonatomic, copy) void (^reloadAgainBlock)();

/** 是否显示重新加载按钮 */
@property (nonatomic, assign) BOOL hiddenBtn;

@end
