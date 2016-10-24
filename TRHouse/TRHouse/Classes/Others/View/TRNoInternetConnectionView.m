//
//  TRNoInternetConnectionView.m
//  TRMerchants
//
//  Created by wgf on 16/10/9.
//  Copyright © 2016年 wgf. All rights reserved.
//  

#import "TRNoInternetConnectionView.h"

@interface TRNoInternetConnectionView ()

@property (weak, nonatomic) IBOutlet UIButton *againBtn;


@end


@implementation TRNoInternetConnectionView


+ (instancetype)noInternetConnectionView {

    return [[[NSBundle mainBundle] loadNibNamed:@"TRNoInternetConnectionView" owner:nil options:nil] firstObject];
}


- (IBAction)reloadAgain {
    
    if (self.reloadAgainBlock) {
        self.reloadAgainBlock();
    }
    
    [self removeFromSuperview];
}

- (void)setHiddenBtn:(BOOL)hiddenBtn {
    _hiddenBtn = hiddenBtn;
    self.againBtn.hidden = hiddenBtn;
}

@end
