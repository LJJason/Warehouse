//
//  TRTableViewCell.m
//  TRHouse
//
//  Created by wgf on 16/10/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRTableViewCell.h"
#import "TRRoom.h"

@interface TRTableViewCell ()
/**
 *  图片控件
 */
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
/**
 *  描述
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
/**
 *  评价
 */
@property (weak, nonatomic) IBOutlet UILabel *evaluationLbl;
/**
 *  销量
 */
@property (weak, nonatomic) IBOutlet UILabel *salesLbl;
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@end

@implementation TRTableViewCell

+ (instancetype)cell{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)setRoom:(TRRoom *)room {
    _room = room;
    
    //设置图片
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:[room.photos firstObject]] placeholderImage:[UIImage imageNamed:@"default_bg"]];
    //设置描述
    self.nameLbl.text = room.describes;
    //设置消费数量
    self.salesLbl.text = [NSString stringWithFormat:@"%zd人消费", room.sales];
    //设置地址
    self.addressLbl.text = room.address;
    //设置价格
    self.priceLbl.text = [NSString stringWithFormat:@"%zd", room.price];
    
    //设置评价
    if (room.praise.length > 0) {
        self.evaluationLbl.textColor = TRColor(255, 153, 51, 1.0);
        self.evaluationLbl.text = room.praise;
    }else {
        self.evaluationLbl.textColor = TRColor(171, 171, 171, 1.0);
        self.evaluationLbl.text = @"暂无评分";
    }
}

@end
