//
//  TRComposeParam.h
//  TRHouse
//
//  Created by wgf on 16/10/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRComposeParam : NSObject

/** 用户唯一标识符 */
@property (nonatomic, copy) NSString *uid;
/** 内容 */
@property (nonatomic, copy) NSString *content;

/** 图片路径 */
@property (nonatomic, copy) NSString *photos;

@end
