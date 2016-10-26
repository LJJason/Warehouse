//
//  TRAccount.h
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRAccount : NSObject

/** 用户唯一标识符 */
@property (nonatomic, copy) NSString *uid;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
