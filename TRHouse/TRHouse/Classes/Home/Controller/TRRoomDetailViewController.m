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
#import "TRSeeMorePhotoViewController.h"
#import "TRDetailInformationViewController.h"
#import "TRNoInternetConnectionView.h"
#import "TRLoginViewController.h"
#import "TRAccount.h"
#import "TRAccountTool.h"
#import "TRReservation.h"
#import "TRSubmitViewController.h"

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

/**
 *  显示图片个数的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *photoCountBtn;

@property (weak, nonatomic) IBOutlet UIView *configView;

/** 起始时间 */
@property (nonatomic, copy) NSString *firstDateStr;

/** 结束时间 */
@property (nonatomic, copy) NSString *lastDateStr;

@end

@implementation TRRoomDetailViewController

/**
 *  懒加载地理编码器
 */
- (CLGeocoder *)geocoder {
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeMorePhotos:)];
    //允许与用户交互
    self.photoView.userInteractionEnabled = YES;
    [self.photoView addGestureRecognizer:tap];
    [self setupData];
    //可提供的服务
    [self loadConfigImage];
}


/**
 *  设置可提供服务视图
 */
- (void)loadConfigImage{
    
    CGFloat margin = 20;
    CGFloat y = 6.0;
    CGFloat w = 50;
    CGFloat h = 65;
    
    for (NSInteger i = 0; i < 3; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.x = i * (margin + w) + margin;
        imageView.y = y;
        imageView.width = w;
        imageView.height = h;
        imageView.image = [UIImage imageNamed:self.room.configuration[i]];
        [self.configView addSubview:imageView];
    }
    
}


/**
 *  设置导航条相关
 */
- (void)setupNav {
    self.navigationItem.title = @"商品详情";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"返回";
    self.navigationItem.backBarButtonItem = item;
}

/**
 *  展示无网络连接页面
 */
- (void)showErrorView {
    
    TRNoInternetConnectionView *noInterNet = [TRNoInternetConnectionView noInternetConnectionView];
    noInterNet.frame = self.view.frame;
    noInterNet.hiddenBtn = YES;
    
    [self.view addSubview:noInterNet];
    
}

- (void)setupData{
    
    if (!self.room) {
        //没东西就显示无网络页面
        [self showErrorView];
        return;
    }

    //设置入住天数
    self.days = 1;
    //设置图片的个数
    [self.photoCountBtn setTitle:[NSString stringWithFormat:@"%zd", self.room.photos.count] forState:UIControlStateNormal];
    
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
    //获取当前的日期
    NSDate *date = [NSDate date];
    NSString *toDayStr = [formatter stringFromDate:date];
    //转换明天的日期
    NSString *tomorrowStr = [formatter stringFromDate:[date dateByAddingTimeInterval:(24*3600)]];
    self.firstDateStr = toDayStr;
    self.lastDateStr = tomorrowStr;
    
    [self.stayInDateBtn setTitle:[NSString stringWithFormat:@"%@ 入住 - %@ 离店 共%zd晚", toDayStr, tomorrowStr, self.days] forState:UIControlStateNormal];

}

/**
 *  预定按钮
 */
- (IBAction)reservationBtnClick {
    
    if (![TRAccountTool loginState]) {
        //跳转登录界面
        [self loginVc];
    }else {
        //创建预定模型
        TRReservation *reser = [[TRReservation alloc] init];
        reser.firstDateStr = self.firstDateStr;
        reser.lastDateStr = self.lastDateStr;
        reser.room = self.room;
        reser.days = self.days;
        
        TRSubmitViewController *subVc = [TRSubmitViewController viewControllerWtithStoryboardName:TRHomeStoryboardName identifier:NSStringFromClass([TRSubmitViewController class])];
        subVc.reser = reser;
        [self.navigationController pushViewController:subVc animated:YES];
        
    }
    
}

/**
 *  跳转控制器
 */
- (void)loginVc {
    
    TRLoginViewController *loginVc = [TRLoginViewController instantiateInitialViewControllerWithStoryboardName:@"LoginAndRegist"];
    [self presentViewController:loginVc animated:YES completion:nil];
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
    
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否打开地图进行导航?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        //3,获得结束位置的地标
        [self.geocoder geocodeAddressString:self.room.address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            CLPlacemark * endPlacemark = [placemarks firstObject];
            //4,获得地标后开始导航
            [self startNavigationWithStartPlacemark:self.placemark endPlacemark:endPlacemark];
        }];
    }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertControl animated:YES completion:nil];
    
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
        self.firstDateStr = firstDateStr;
        self.lastDateStr = lastDateStr;
        [self.stayInDateBtn setTitle:[NSString stringWithFormat:@"%@ 入住 - %@ 离店 共%zd晚", firstDateStr, lastDateStr, self.days] forState:UIControlStateNormal];
    };
    
    TRNavigationController *nav = [[TRNavigationController alloc] initWithRootViewController:selectDateVc];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}

//顶部图片的点击
- (void)seeMorePhotos:(UITapGestureRecognizer *)tap{
    
    if (tap.state == UIGestureRecognizerStateEnded) {
        TRSeeMorePhotoViewController *seePhotoVc = [TRSeeMorePhotoViewController viewControllerWtithStoryboardName:TRHomeStoryboardName identifier:NSStringFromClass([TRSeeMorePhotoViewController class])];
        seePhotoVc.photosUrl = self.room.photos;
        
        [self.navigationController pushViewController:seePhotoVc animated:YES];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    id destinationViewController = segue.destinationViewController;
    
    if ([destinationViewController isKindOfClass:[TRDetailInformationViewController class]]) {
        
        TRDetailInformationViewController *detailVc = destinationViewController;
        detailVc.room = self.room;
    }
    
}

@end
