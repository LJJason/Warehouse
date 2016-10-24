//
//  TRHotAndSelectTableViewController.h
//  TRHouse
//
//  Created by wgf on 16/10/20.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TRHotAndSelectTableViewController : UITableViewController

/** 请求url */
@property (nonatomic, copy) NSString *urlStr;

/** 标题 */
@property (nonatomic, copy) NSString *navTitle;

/** 地标 */
@property (nonatomic, strong) CLPlacemark *placemark;

@end
