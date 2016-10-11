//
//  GFPiece.m
//  百思不得姐
//
//  Created by wgf on 16/5/10.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "GFPiece.h"
#import "GFPieceComment.h"
#import "GFUser.h"
#import "NSDate+GFExtension.h"

@implementation GFPiece
{
    CGFloat _cellHeight;
}

//把属性名和服务器返回的key相互对应
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"top_cmt" : @"GFPieceComment"};
}

- (NSString *)created_at {
 
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //帖子创建的时间
    NSDate *createTime = [fmt dateFromString:_created_at];
    
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
        return _created_at;
    }
    
    
}

- (CGFloat)cellHeight {
    
    if (!_cellHeight) {
        
        //GFLog(@"begin---\n%@\n%@\n%@\nend---", self.small_image, self.middle_image, self.large_image);
        
        //由于在计算高度的时候, 文字在最后的摆不下了强制被换行引起的问题, 这里的textLabel的宽度多减5个像素
        CGFloat textW = [UIScreen mainScreen].bounds.size.width - 2 * GFPieceCellMargin;
        //根据文字大小计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        _cellHeight = GFPieceTextY + textH + GFPieceCellMargin;
        
        if (self.type == GFPieceTypePicture) {//图片
            
            CGFloat pictureX = GFPieceCellMargin;
            CGFloat pictureY = textH + GFPieceTextY + GFPieceCellMargin;
            CGFloat pictureW = TRScreenW - 2 * GFPieceCellMargin;
            CGFloat pictureH = pictureW * self.height / self.width;
            
            if (pictureH >= GFPiecePictureMaxH) {//是大图
                pictureH = GFPiecePictureBreakH;//固定高度
                self.bigPicture = YES;
            }
            
            //赋值图片View的frame
            _pictureFrmae = (CGRect){{pictureX, pictureY},{pictureW, pictureH}};
            
            //cell的高度=图片控件的高度 + 间距
            _cellHeight += pictureH + GFPieceCellMargin;
            
        }else if (self.type == GFPieceTypeVoice){//声音
            CGFloat voiceX = GFPieceCellMargin;
            CGFloat voiceY = textH + GFPieceTextY + GFPieceCellMargin;
            CGFloat voiceW = TRScreenW - 2 * GFPieceCellMargin;
            CGFloat voiceH = voiceW * self.height / self.width;
            
            _voiceFrmae = (CGRect){{voiceX, voiceY}, {voiceW, voiceH}};
            
            _cellHeight += voiceH + GFPieceCellMargin;
        }else if (self.type == GFPieceTypeVideo){ //视频
            CGFloat videoX = GFPieceCellMargin;
            CGFloat videoY = textH + GFPieceTextY + GFPieceCellMargin;
            CGFloat videoW = TRScreenW - 2 * GFPieceCellMargin;
            CGFloat videoH = videoW * self.height / self.width;
            
            _videoFrmae = (CGRect){{videoX, videoY}, {videoW, videoH}};
            
            _cellHeight += videoH + GFPieceCellMargin;
            
        }
        
        //取最热评论的内容
        NSString *content = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
        if (self.top_cmt) {
            
            CGFloat ContentH = [content boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += ContentH + GFPieceCellMargin + GFTopCmtTitleH;
        }
        
        _cellHeight += GFPieceCellBottomBarH + GFPieceCellMargin;
        
    }
    
    return _cellHeight;
}




@end
