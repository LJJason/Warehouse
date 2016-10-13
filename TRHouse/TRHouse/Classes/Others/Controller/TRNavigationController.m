//
//  TRNavigationController.m
//  TRHouse
//
//  Created by wgf on 16/9/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRNavigationController.h"

@interface TRNavigationController ()

@end

@implementation TRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = TRColor(0, 220, 255, 1.0);
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [navBar setTintColor:[UIColor whiteColor]];
    
}

//重写pushViewController拦截导航栏的一些东西
- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
