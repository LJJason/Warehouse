//
//  TRRoomDetailViewController.h
//  TRHouse
//
//  Created by wgf on 16/10/23.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class TRRoom;

@interface TRRoomDetailViewController : UIViewController


/** 模型 */
@property (nonatomic, strong) TRRoom *room;


/** 地标 */
@property (nonatomic, strong) CLPlacemark *placemark;

@end
