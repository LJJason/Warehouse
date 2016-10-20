//
//  TRUploadTool.h
//  TRMerchants
//
//  Created by wgf on 16/10/8.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRUploadTool : NSObject
/**
 *  上传图片
 *
 *  @param images     所有的图片
 *  @param success    成功回调(参数是上传到文件服务器的文件路径)
 */
+ (void)uploadMoreImage:(NSArray *)images success:(void (^)(NSArray *imagePath))success;

@end
