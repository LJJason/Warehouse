//
//  GFCommentHeaderView.h
//  百思不得姐
//
//  Created by wgf on 16/6/7.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFCommentHeaderView : UITableViewHeaderFooterView

/** 标题文字 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
