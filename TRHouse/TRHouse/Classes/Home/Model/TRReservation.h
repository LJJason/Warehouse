//
//  TRReservation.h
//  TRHouse
//
//  Created by wgf on 16/10/25.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TRRoom;

@interface TRReservation : NSObject

/** 开始时间 */
@property (nonatomic, copy) NSString *firstDateStr;

/** 结束时间 */
@property (nonatomic, copy) NSString *lastDateStr;

/** 房间模型 */
@property (nonatomic, strong) TRRoom *room;

/** 一共的天数 */
@property (nonatomic, assign) NSInteger days;

@end
