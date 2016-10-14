//
//  TRLoginViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/15.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRLoginViewController.h"
#import "TRNavigationController.h"

@interface TRLoginViewController ()

@end

@implementation TRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registClick {
    TRNavigationController *nav = [TRNavigationController viewControllerWtithStoryboardName:@"LoginAndRegist" identifier:@"TRNavigationController"];
    
    [self presentViewController:nav animated:NO completion:nil];
    
    
}




@end
