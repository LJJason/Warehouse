//
//  TRRegistViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/15.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRRegistViewController.h"

@interface TRRegistViewController ()

@end

@implementation TRRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.navigationController.view.frame = CGRectMake(TRScreenW + 20, 0, TRScreenW, TRScreenH);
        self.annimation();
        [self.view endEditing:YES];
    } completion:^(BOOL finished) {
        
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }];
    
    
}


@end
