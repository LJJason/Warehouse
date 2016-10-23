//
//  TRRoomDetailViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/23.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRRoomDetailViewController.h"
#import "TRRoom.h"
#import "TRSelectDateViewController.h"
#import "TRNavigationController.h"

@interface TRRoomDetailViewController ()
/**
 *  顶部图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
/**
 *  好评lbl
 */
@property (weak, nonatomic) IBOutlet UILabel *praiseLbl;
/**
 *  名称lbl
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
/**
 *  入住日期按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *stayInDateBtn;
/**
 *  价钱lbl
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

/**
 *  地址按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

/** 入住天数 */
@property (nonatomic, assign) NSInteger days;

@end

@implementation TRRoomDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"商品详情";
    [self setupData];
}

- (void)setupData{
    //设置入住天数
    self.days = 1;
    //设置图片
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:[self.room.photos firstObject]] placeholderImage:[UIImage imageNamed:@"default_bg"]];
    //设置好评lbl
    if (self.room.praise.length > 0) {
        self.praiseLbl.textColor = TRColor(255, 153, 51, 1.0);
        self.praiseLbl.text = self.room.praise;
    }
    //设置名称
    self.nameLbl.text = self.room.describes;
    //价钱
    self.priceLbl.text = [NSString stringWithFormat:@"%zd", self.room.price];
    //设置地址
    [self.addressBtn setTitle:self.room.address forState:UIControlStateNormal];
    //入住日期
    //获取今天的日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM月dd";
    
    NSDate *date = [NSDate date];
    NSString *toDayStr = [formatter stringFromDate:date];
    NSString *tomorrowStr = [formatter stringFromDate:[date dateByAddingTimeInterval:(24*3600)]];
    
    [self.stayInDateBtn setTitle:[NSString stringWithFormat:@"%@ 入住 - %@ 离店 共%zd晚", toDayStr, tomorrowStr, self.days] forState:UIControlStateNormal];
    
    
}

/**
 *  预定按钮
 */
- (IBAction)reservationBtnClick {
}

/**
 *  地址按钮
 */
- (IBAction)addressBtnClick {
    
    
    
}

/**
 *  日期选择
 */
- (IBAction)selectDateClick {
    
    TRSelectDateViewController *selectDateVc = [[TRSelectDateViewController alloc] init];
    
    selectDateVc.didSelectDateBlock = ^(NSString *firstDateStr, NSString *lastDateStr, NSInteger count) {
        self.days = count;
        [self.stayInDateBtn setTitle:[NSString stringWithFormat:@"%@ 入住 - %@ 离店 共%zd晚", firstDateStr, lastDateStr, self.days] forState:UIControlStateNormal];
    };
    
    TRNavigationController *nav = [[TRNavigationController alloc] initWithRootViewController:selectDateVc];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}


@end
