//
//  TRDetailInformationViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/24.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRDetailInformationViewController.h"
#import "TRRoom.h"

@interface TRDetailInformationViewController ()
/**
 *  店家给房间取得名字
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
/**
 *  可住最大人数label
 */
@property (weak, nonatomic) IBOutlet UILabel *largestPeopleCountLbl;

/** 电话号码 */
@property (nonatomic, copy) NSString *phoneNum;

/**
 *  可提供的服务
 */
@property (weak, nonatomic) IBOutlet UIView *configView;

@end

@implementation TRDetailInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"房间介绍";
    
    self.nameLbl.text = self.room.describes;
    self.largestPeopleCountLbl.text = [NSString stringWithFormat:@"%zd 人", self.room.largestPeopleCount];
    
    self.phoneNum = self.room.phoneNum;
    //设置可提供服务
    [self loadConfigImage];
}

/**
 *  设置可提供服务视图
 */
- (void)loadConfigImage{
    
    CGFloat margin = 20;
    CGFloat y = 7.5;
    CGFloat w = 50;
    CGFloat h = 65;
    
    for (NSInteger i = 0; i < self.room.configuration.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.x = i * (margin + w) + margin;
        imageView.y = y;
        imageView.width = w;
        imageView.height = h;
        imageView.image = [UIImage imageNamed:self.room.configuration[i]];
        [self.configView addSubview:imageView];
    }
    
}

- (IBAction)phoneBtnClick {
    
    if (!self.phoneNum) {
        [Toast makeText:@"请检查网络连接!"];
        return;
    }
    
    
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:self.phoneNum style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //判断是否可以打电话
        [self determineWhetherCanCall];
    }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertControl animated:YES completion:nil];
    
}

/**
 *  判断是否是模拟器, 是否可以打电话
 */
- (void)determineWhetherCanCall{
    
    
#if TARGET_IPHONE_SIMULATOR//模拟器
    
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你的设备无法拨打电话" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertControl animated:YES completion:nil];
    
    
#elif TARGET_OS_IPHONE//真机
    
    //打电话的方法
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString: [NSString stringWithFormat:@"tel:%@", self.phoneNum]];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    
    //记得添加到view上
    [self.view addSubview:callWebview];
    
#endif
    
    
}

@end
