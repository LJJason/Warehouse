//
//  TRHttpTool.h
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//  专门负责网络请求的工具类

#import <AFNetworking.h>

typedef enum {
    TRNetworkingOK,                 //网络正常
    TRNetworkingFailure             //无网络
}TRNetworking;


@interface TRHttpTool : NSObject

/**
 *  get请求
 *
 *  @param urlStr     请求url
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GET:(NSString *)urlStr
            parameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;

/**
 *  post请求
 *
 *  @param urlStr     请求url
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)urlStr
            parameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;


/**
 *  带progress的GET请求
 *
 *  @param urlStr           请求url
 *  @param parameters       请求参数
 *  @param progress         progress回调
 *  @param success          成功回调
 *  @param failure          失败回调
 */
+ (void)GET:(NSString *)urlStr
            parameters:(id)parameters
            progress:(void (^)(NSProgress * downloadProgress))progress
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;

/**
 *  带progress的POST请求
 *
 *  @param urlStr           请求url
 *  @param parameters       请求参数
 *  @param progress         progress回调
 *  @param success          成功回调
 *  @param failure          失败回调
 */
+ (void)POST:(NSString *)urlStr
  parameters:(id)parameters
    progress:(void (^)(NSProgress * downloadProgress))progress
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;


/**
 *  检测网络状态
 *
 *  @param statusChangeBlock 网络状态发生改变时回调
 */
+ (void)setReachabilityStatusChangeBlock:(void (^)(TRNetworking status))statusChangeBlock;


@end
