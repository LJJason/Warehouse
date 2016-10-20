//
//  TRHeaderCell.m
//  TRHouse
//
//  Created by wgf on 16/10/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRHeaderCell.h"
#import "TRRoom.h"
#import "TRTableViewCell.h"

@interface TRHeaderCell ()
@property (weak , nonatomic)  UILabel *label;
@property (weak , nonatomic)  UIImageView *imageView;
/** cell */
@property (nonatomic, weak) TRTableViewCell *cell;
@end

@implementation TRHeaderCell

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
//        UIImageView *img = [[UIImageView alloc] init];
//        [self.contentView addSubview:img];
//        self.imageView = img;
//        
//        UILabel *lab = [[UILabel alloc] init];
//        [self.contentView addSubview:lab];
//        self.label = lab;
        TRTableViewCell *cell = [TRTableViewCell cell];
        self.cell = cell;
        [self.contentView addSubview:cell];
        
    }
    
    return self;
}


-(void)setRoom:(TRRoom *)room
{
    _room=room;
    
    [self settingData];
    [self settingFrame];
}

#pragma mark 给子控件赋值
-(void) settingData{
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[_room.photos firstObject]] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
//    self.label.text = _room.describes;
    self.cell.room = _room;
}

#pragma mark 设置子控件的frame
-(void) settingFrame{
//    CGFloat screenWidth = self.contentView.frame.size.width;
//    self.imageView.frame = CGRectMake(0, 0, screenWidth, 200);
//    self.label.frame = CGRectMake(0, 0, screenWidth, 200);
//    self.label.font = [UIFont systemFontOfSize:30];
//    self.label.textAlignment = NSTextAlignmentCenter;
    self.cell.frame = CGRectMake(0, 0, TRScreenW, 130);
}

@end
