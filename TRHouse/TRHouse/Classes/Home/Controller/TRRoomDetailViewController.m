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
#import <MapKit/MapKit.h>

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
/**
 *  地理编码器
 */
@property(nonatomic ,strong)CLGeocoder *geocoder;

@end

@implementation TRRoomDetailViewController

- (CLGeocoder *)geocoder {
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

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
    
    if (self.placemark == nil) {
        //
        [Toast makeText:@"返回上一页等待定位完成"];
        return;
    }
    
    //3,获得结束位置的地标
    [self.geocoder geocodeAddressString:self.room.address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark * endPlacemark = [placemarks firstObject];
        //4,获得地标后开始导航
        [self startNavigationWithStartPlacemark:self.placemark endPlacemark:endPlacemark];
    }];
    
    
}

/**
 *  利用地标位置开始设置导航
 *
 *  @param startPlacemark 开始位置的地标
 *  @param endPlacemark   结束位置的地标
 */
-(void)startNavigationWithStartPlacemark:(CLPlacemark *)startPlacemark endPlacemark:(CLPlacemark*)endPlacemark
{
    //0,创建起点
    MKPlacemark * startMKPlacemark = [[MKPlacemark alloc]initWithPlacemark:startPlacemark];
    //0,创建终点
    MKPlacemark * endMKPlacemark = [[MKPlacemark alloc]initWithPlacemark:endPlacemark];
    
    //1,设置起点位置
    MKMapItem * startItem = [[MKMapItem alloc]initWithPlacemark:startMKPlacemark];
    //2,设置终点位置
    MKMapItem * endItem = [[MKMapItem alloc]initWithPlacemark:endMKPlacemark];
    //3,起点,终点数组
    NSArray * items = @[ startItem ,endItem];
    
    //4,设置地图的附加参数,是个字典
    NSMutableDictionary * dictM = [NSMutableDictionary dictionary];
    //导航模式(驾车,步行)
    dictM[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
    //地图显示的模式
    dictM[MKLaunchOptionsMapTypeKey] = MKMapTypeStandard;
    
    
    //只要调用MKMapItem的open方法,就可以调用系统自带地图的导航
    //Items:告诉系统地图从哪到哪
    //launchOptions:启动地图APP参数(导航的模式/是否需要先交通状况/地图的模式/..)
    
    [MKMapItem openMapsWithItems:items launchOptions:dictM];
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
