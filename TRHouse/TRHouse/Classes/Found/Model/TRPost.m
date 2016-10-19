//
//  TRPost.m
//  TRHouse
//
//  Created by admin1 on 2016/10/13.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRPost.h"
#import "NSDate+GFExtension.h"

@implementation TRPost

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" : @"id"};
}

- (NSString *)posttime{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //帖子创建的时间
    NSDate *createTime = [fmt dateFromString:_posttime];
    
    if (createTime.isThisYear) {//是今年
        if (createTime.isToday) {//今天
            
            NSDateComponents *cmps = [[NSDate date] deltaFrom:createTime];
            if (cmps.hour >= 1) {//几小时前
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            }else if (cmps.minute >= 1){//几分钟前
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            }else {
                return @"刚刚";
            }
            
        }else if(createTime.isYesterday){//昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createTime];
        }else{//一天前
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createTime];
        }
        
    }else{//不是今年
        //不是今年直接显示服务器返回的时间
        return _posttime;
    }
    

    
    
}
//- (void)setPostphotos:(NSArray *)postphotos{
//    
//    CGFloat imgWH = (TRScreenW -40)/3;
//    
//    _postphotos = postphotos;
//    if (!postphotos) {
//        self.imageHeight = 0;
//        return;
//    }else if (postphotos.count >= 9){
//        
//        self.imageHeight = TRScreenW+imgWH;
//        
//    }else if (postphotos.count < 9 && postphotos.count >6){
//         self.imageHeight = TRScreenW;
//    }else if (postphotos.count < 7 && postphotos.count >3){
//        self.imageHeight = TRScreenW - imgWH;
//    }else if (postphotos.count < 4 && postphotos.count >0)
//    {
//        self.imageHeight = TRScreenW - (2 * imgWH);
//    }else if(postphotos.count == 0){
//        
//        self.imageHeight = 0;
//    }
//    
//    
//}

- (CGFloat)cellRowHeight{
   
    
    CGSize textSize = [self.postcontent boundingRectWithSize:CGSizeMake(TRScreenW-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
    CGFloat rowHeight = textSize.height+122;
    
    return rowHeight;
}
@end
