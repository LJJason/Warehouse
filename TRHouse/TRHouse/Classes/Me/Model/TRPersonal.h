//
//  TRPersonal.h
//  TRHouse
//
//  Created by wgf on 16/10/17.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRPersonal : NSObject

/** icon */
@property (nonatomic, copy) NSString *icon;

/** 用户名 */
@property (nonatomic, copy) NSString *userName;

/** 互动的条数 */
@property (nonatomic, assign) NSInteger count;

@end
