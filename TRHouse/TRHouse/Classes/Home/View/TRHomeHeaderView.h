//
//  TRHomeHeaderView.h
//  TRHouse
//
//  Created by wgf on 16/10/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TRHomeHeaderView : UIView

/** 模型数组 */
@property (nonatomic, strong) NSArray *rooms;

/** 地标 */
@property (nonatomic, strong) CLPlacemark *placemark;

@end
