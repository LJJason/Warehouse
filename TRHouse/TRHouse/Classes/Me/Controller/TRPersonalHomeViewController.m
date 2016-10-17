//
//  TRPersonalHomeViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/17.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRPersonalHomeViewController.h"
#import "TRPersonal.h"

@interface TRPersonalHomeViewController ()

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;


@end

@implementation TRPersonalHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.personal.icon] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.userNameLbl.text = self.personal.userName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
