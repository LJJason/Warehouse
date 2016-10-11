//
//  GFCommentHeaderView.m
//  百思不得姐
//
//  Created by wgf on 16/6/7.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "GFCommentHeaderView.h"

@interface GFCommentHeaderView ()

/** label */
@property (nonatomic, weak)UILabel *label;

@end

@implementation GFCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"header";
    
    GFCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (header == nil) {
        header = [[GFCommentHeaderView alloc]initWithReuseIdentifier:ID];
    }
    
    return header;
}

- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        //设置背景色
        self.contentView.backgroundColor = GFGlobalBg;
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        label.x = GFPieceCellMargin;
        label.width = 200;
        //设置label的高度随父控件一起拉伸
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    
    self.label.text = title;
}

@end
