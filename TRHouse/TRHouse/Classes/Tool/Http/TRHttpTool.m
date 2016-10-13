//
//  TRHttpTool.m
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRHttpTool.h"

@implementation TRHttpTool

+ (void)GET:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [TRHttpTool GET:urlStr parameters:parameters progress:nil success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [TRHttpTool POST:urlStr parameters:parameters progress:nil success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)GET:(NSString *)urlStr parameters:(id)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    [manger GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)urlStr parameters:(id)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    [manger POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)setReachabilityStatusChangeBlock:(void (^)(TRNetworking))statusChangeBlock{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        
        if (statusChangeBlock) {
            if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
                statusChangeBlock(TRNetworkingOK);
            }else{
                statusChangeBlock(TRNetworkingFailure);
            }
        }
        
    }];
    // 3.开始监控
    [mgr startMonitoring];
}

@end
