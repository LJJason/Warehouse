//
//  TRFeedbackView.m
//  TRHouse
//
//  Created by wgf on 16/10/22.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRFeedbackView.h"

@implementation TRFeedbackView

+ (instancetype)feedbackView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

@end
