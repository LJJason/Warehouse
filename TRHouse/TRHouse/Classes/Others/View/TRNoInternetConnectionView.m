//
//  TRNoInternetConnectionView.m
//  TRMerchants
//
//  Created by wgf on 16/10/9.
//  Copyright © 2016年 wgf. All rights reserved.
//  

#import "TRNoInternetConnectionView.h"

@implementation TRNoInternetConnectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)noInternetConnectionView {
    return [[[NSBundle mainBundle] loadNibNamed:@"TRNoInternetConnectionView" owner:nil options:nil] firstObject];
}


- (IBAction)reloadAgain {
    
    if (self.reloadAgainBlock) {
        self.reloadAgainBlock();
    }
    
    [self removeFromSuperview];
}


@end
