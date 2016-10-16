//
//  TRLoginViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/15.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRLoginViewController.h"
#import "TRNavigationController.h"
#import "TRRegistViewController.h"

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
    
    
    [self pushToNextViewController:nav];
    
    
}

- (void)pushToNextViewController:(UIViewController *)nav {
    
    TRRegistViewController *vc = nav.childViewControllers[0];
    vc.cancelBlock = ^ {
        
        if (self.childViewControllers.count > 0) {
            [self setValue:nil forKey:@"childViewControllers"];
        }
    };
    vc.annimation = ^ {
        self.view.x = 0;
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:nav.view];
    [self addChildViewController:nav];
    nav.view.frame = CGRectMake(TRScreenW, 0, TRScreenW, TRScreenH);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.x = -TRScreenW + 300;
        nav.view.x = 0;
    }];
}



@end
