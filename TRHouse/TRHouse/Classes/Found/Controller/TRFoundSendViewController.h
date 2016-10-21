//
//  TRFoundSendViewController.h
//  TRHouse
//
//  Created by nankeyimeng on 16/10/21.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRFoundSendViewController : UIViewController
/** 发送成功回调 */
@property (nonatomic, copy) void (^composeInteractiveSuccessBlock)();

@end
