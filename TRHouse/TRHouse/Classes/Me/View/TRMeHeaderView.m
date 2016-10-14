//
//  TRMeHeaderView.m
//  TRHouse
//
//  Created by wgf on 16/10/13.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRMeHeaderView.h"
#import "TRLoginViewController.h"

@implementation TRMeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)meHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}
- (IBAction)loginOrMe {
    
    TRLoginViewController *loginVc = [TRLoginViewController instantiateInitialViewControllerWithStoryboardName:@"LoginAndRegist"];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginVc animated:YES completion:nil];
    
}

@end
