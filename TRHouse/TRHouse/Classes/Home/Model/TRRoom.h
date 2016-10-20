//
//  TRRoom.h
//  TRHouse
//
//  Created by wgf on 16/10/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRRoom : NSObject

/** id */
@property (nonatomic, assign) NSInteger ID;

/** 价格 */
@property (nonatomic, assign) NSInteger price;

/** 地址 */
@property (nonatomic, copy) NSString *address;

/** 描述 */
@property (nonatomic, copy) NSString *describes;

/** 配图 */
@property (nonatomic, strong) NSArray *photos;

/** 配置 */
@property (nonatomic, strong) NSArray *configuration;

/** 收藏的账号汇总 */
@property (nonatomic, strong) NSArray *collections;

/** 商家的联系方式 */
@property (nonatomic, copy) NSString *phoneNum;

/** 销量 */
@property (nonatomic, assign) NSInteger sales;

@end
