//
//  TRSelectCityViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/23.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRSelectCityViewController.h"
#import "BAddressPickerController.h"

@interface TRSelectCityViewController ()<BAddressPickerDelegate,BAddressPickerDataSource>

@end

@implementation TRSelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择城市";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login_close_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];

    BAddressPickerController *addressPickerController = [[BAddressPickerController alloc] initWithFrame:CGRectMake(0, 0, TRScreenW, TRScreenH)];
    addressPickerController.dataSource = self;
    addressPickerController.delegate = self;
    
    [self addChildViewController:addressPickerController];
    [self.view addSubview:addressPickerController.view];
}

- (void)viewWillAppear:(BOOL)animated{
    
    // Called when the view is about to made visible. Default does nothing
    [super viewWillAppear:animated];
    
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - BAddressController Delegate
- (NSArray*)arrayOfHotCitiesInAddressPicker:(BAddressPickerController *)addressPicker{
    return @[@"北京",@"上海",@"深圳",@"杭州",@"广州",@"武汉",@"天津",@"重庆",@"成都",@"苏州"];
}


- (void)addressPicker:(BAddressPickerController *)addressPicker didSelectedCity:(NSString *)city{
    
    if (self.didSelectCityBlock) {
        self.didSelectCityBlock(city);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)beginSearch:(UISearchBar *)searchBar{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    self.navigationController.navigationBar.y = -44;
    
}

- (void)endSearch:(UISearchBar *)searchBar{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


@end
