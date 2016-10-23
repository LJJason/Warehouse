//
//  TRSelectDateViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/23.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRSelectDateViewController.h"
#import "CalendarHomeViewController.h"

@interface TRSelectDateViewController ()
{
    
    CalendarHomeViewController *chvc;
    
    UIView * mainView;
    
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation TRSelectDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"入住/离店日期";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login_close_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.dataArray=[[NSMutableArray alloc] init];
    
    chvc = [[CalendarHomeViewController alloc]init];
    chvc.view.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:chvc.view];
    
    [chvc setHotelToDay:60 ToDateforString:nil];
    
    
    [self mainViewClass:0];
    
    __weak typeof(self) weakSelf = self;
    
    chvc.calendarblock = ^(CalendarDayModel *model){
        
        if(model.style==CellDayTypeClick)
        {
            [weakSelf.dataArray addObject:model.toString];
            
            NSSet *set = [NSSet setWithArray:weakSelf.dataArray];
            weakSelf.dataArray=[[set allObjects] mutableCopy];
            
            [weakSelf.dataArray sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
                return [obj1 compare:obj2];
            }];
            
        }
        else
        {
            [weakSelf.dataArray removeObject:model.toString];
            
        }
        
        [weakSelf mainViewClass:weakSelf.dataArray.count];
        
    };
    
}

-(void)mainViewClass:(NSInteger)num
{
    
    [mainView removeFromSuperview];
    
    mainView=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50,self.view.frame.size.width,50)];
    [self.view addSubview:mainView];
    mainView.backgroundColor = TRColor(0, 220, 255, 1.0);
    
    
    UILabel * lable =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    lable.font=[UIFont systemFontOfSize:14.0f];
    lable.textColor=[UIColor whiteColor];
    lable.textAlignment=NSTextAlignmentCenter;
    [mainView addSubview:lable];
    
    
    
    if(num==0)
    {
        lable.text=@"请选择入住时间";
    }
    if(num==1)
    {
        lable.text=@"请选择离店时间";
        
    }
    if(num==2)
    {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSDate* date1 = [formatter dateFromString:[self.dataArray objectAtIndex:0]];
        NSDate* date2 = [formatter dateFromString:[self.dataArray objectAtIndex:1]];
        
        [formatter setDateFormat:@"MM月dd"];
        NSString *dateStr1 = [formatter stringFromDate:date1];
        NSString *dateStr2 = [formatter stringFromDate:date2];
    
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [gregorian components:NSCalendarUnitDay fromDate:date1 toDate:date2  options:0];
        
        NSInteger days = [comps day];
        
        
        lable.text=[NSString stringWithFormat:@"%@ 入住 - %@离店 共%zd晚",dateStr1,dateStr2,days];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (self.didSelectDateBlock) {
                self.didSelectDateBlock(dateStr1, dateStr2, days);
            }
            [self cancel];
        });
        
    }
    
    
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
