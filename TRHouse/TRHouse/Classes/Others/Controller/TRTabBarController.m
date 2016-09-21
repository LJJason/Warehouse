//
//  TRTabBarController.m
//  TRHouse
//
//  Created by wgf on 16/9/17.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRTabBarController.h"
#import "TRHomeTableViewController.h"
#import "TRInteractiveTableViewController.h"
#import "TRFoundTableViewController.h"
#import "TRMeTableViewController.h"
#import "TRNavigationController.h"

@interface TRTabBarController ()

@end

@implementation TRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setUpChildViewController];
    
    UITabBar * tabBar = [UITabBar appearance];
    tabBar.tintColor = TRColor(0, 220, 255, 1.0);
    tabBar.barTintColor = [UIColor whiteColor];
//    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_Home"];
    
}

- (void)setUpChildViewController{
    
    //首页
    [self addChildViewController:[[TRHomeTableViewController alloc] init] withTitle:@"生活" withImageName:@"tabbar_Home"];
    //互动
    [self addChildViewController:[[TRInteractiveTableViewController alloc] init] withTitle:@"互动" withImageName:@"tabbar_inter"];
    //发现
    [self addChildViewController:[[TRFoundTableViewController alloc] init] withTitle:@"发现" withImageName:@"tabbar_found"];
    //我
    [self addChildViewController:[[TRMeTableViewController alloc] init] withTitle:@"我" withImageName:@"tabbar_me"];
    
}


- (void)addChildViewController:(UIViewController *)childController withTitle:(NSString *)title withImageName:(NSString *)imageName{
    
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.title = title;
//    childController.view.backgroundColor = [UIColor whiteColor];
    TRNavigationController *nav = [[TRNavigationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
    
}


@end
