//
//  TRCircleTableViewController.h
//  TRHouse
//
//  Created by admin1 on 2016/10/9.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TRPost;
@interface TRCircleTableViewController : UITableViewController

/** url */
@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, strong) TRPost *post;

@end
