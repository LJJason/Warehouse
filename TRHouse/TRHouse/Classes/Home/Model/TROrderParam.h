//
//  TROrderParam.h
//  TRHouse
//
//  Created by wgf on 16/10/25.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TROrderParam : NSObject

/** 订单编号 */
@property (nonatomic, copy) NSString *orderNo;

/** 下单用户留下的姓名 */
@property (nonatomic, copy) NSString *userName;

/** 下单人留下的联系方式 */
@property (nonatomic, copy) NSString *contact;

/** 对应的商品id */
@property (nonatomic, assign) NSInteger roomId;

/** 用户账号 */
@property (nonatomic, copy) NSString *userId;

/** 价钱 */
@property (nonatomic, assign) NSInteger totalPrice;

@end
