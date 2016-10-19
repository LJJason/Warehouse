//
//  TRUploadTool.m
//  TRMerchants
//
//  Created by wgf on 16/10/8.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRUploadTool.h"
#import <QiniuSDK.h>
#import "TRHttpTool.h"
//获取token的公钥
#define publicKey @"muxijinnian"

@implementation TRUploadTool

static NSString *_token;
static NSInteger _index;
static NSArray *_images;
static NSMutableArray *_imagePath;

+ (void)uploadMoreImage:(NSArray *)images success:(void (^)(NSArray *imagePath))success{
    _index = 0;
    _images = images;
    _imagePath = [NSMutableArray array];
    
    [self uploadMoreImageWithIndex:_index success:success];
    
}

+ (void)uploadMoreImageWithIndex:(NSInteger)index success:(void (^)(NSArray *imagePath))success{
    
    [self uploadImageToQNFilePath:[self getImagePath:_images[index]] success:success];
    
}

+ (void)uploadImageToQNFilePath:(NSString *)filePath success:(void (^)(NSArray *imagePath))success{
    
    if (_token == nil) {
        
        [TRHttpTool POST:TRGetTokenUrl parameters:@{@"publicKey" : publicKey} success:^(id responseObject) {
            _token = responseObject[@"token"];
            
            [self upLoadFileWithToken:_token filePath:filePath success:success];
            
        } failure:^(NSError *error) {
            TRLog(@"%@", error);
        }];
        
        
    }else {
        [self upLoadFileWithToken:_token filePath:filePath success:success];
    }
    
}


+ (void)upLoadFileWithToken:(NSString *)token filePath:(NSString *)filePath success:(void (^)(NSArray *imagePath))success{
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        TRLog(@"percent == %.2f", percent);
    }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
    [upManager putFile:filePath key:nil token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        //NSLog(@"info ===== %@", info);
        TRLog(@"resp ===== %@", resp);
        [_imagePath addObject:[NSString stringWithFormat:@"http://ruimedia.com.cn/%@", resp[@"key"]]];
        
        if (_imagePath.count < _images.count) {
            _index++;
            [self uploadMoreImageWithIndex:_index success:success];
        }else {
            
            if (_imagePath.count > 0) {
                if (success) {
                    success(_imagePath);
                }

            }
        }
        
    } option:uploadOption];
}

//照片获取本地路径转换
+ (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}

@end
