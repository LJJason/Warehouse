//
//  TRSubmitViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/25.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRSubmitViewController.h"
#import "TRReservation.h"
#import "TRRoom.h"


@interface TRSubmitViewController ()
/**
 *  商家给房间取得名字
 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/**
 *  选择的日期和天数
 */
@property (weak, nonatomic) IBOutlet UILabel *dateStr;
/**
 *  下单用户留下的姓名
 */
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
/**
 *  下单用户留下的
 */
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;
/**
 *  总价label
 */
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLbl;

/** 总价 */
@property (nonatomic, assign) NSInteger totalPrice;

@end

@implementation TRSubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

/**
 *  初始化ui
 */
- (void)setupUI{
    //设置名字
    self.name.text = self.reser.room.describes;
    
    //时间
    self.dateStr.text = [NSString stringWithFormat:@"%@入住, %@离店 共%zd晚", self.reser.firstDateStr, self.reser.lastDateStr, self.reser.days];
    //计算总价
    self.totalPrice = self.reser.room.price * self.reser.days;
    self.totalPriceLbl.text = [NSString stringWithFormat:@"%zd", self.totalPrice];
}

/**
 *  发起支付
 */
- (IBAction)pay {
    
#warning 接着做
}


@end
