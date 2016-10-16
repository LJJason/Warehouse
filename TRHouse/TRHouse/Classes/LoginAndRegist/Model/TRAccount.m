//
//  TRAccount.m
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRAccount.h"

#define TRUidKey @"uid"

@implementation TRAccount
//一句话搞定归档接档
MJExtensionCodingImplementation

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    
    TRAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
    
}


////解档
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        _uid = [aDecoder decodeObjectForKey:TRUidKey];
//    }
//    
//    return self;
//}
//
////归档
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:_uid forKey:TRUidKey];
//}

@end
