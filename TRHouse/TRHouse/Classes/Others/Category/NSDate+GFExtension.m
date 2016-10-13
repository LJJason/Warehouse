

#import "NSDate+GFExtension.h"

@implementation NSDate (GFExtension)


-(NSDateComponents *)deltaFrom:(NSDate *)from{
    
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //比较时间
    return [calendar components:unit fromDate:from toDate:self options:0];
    
}

- (BOOL)isThisYear {
    
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    //当前时间的年份
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    //调用该方法的时间对象对应的时间的年份
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
    
}

//- (BOOL)isToday{
//    
//    //日历
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//    
//    //当前时间的Components
//    NSDateComponents *nowComps = [calendar components:unit fromDate:[NSDate date]];
//    
//    //调用该方法的时间对象对应的Components, 里面包含时间的年月日
//    NSDateComponents *selfComps = [calendar components:unit fromDate:self];
//    
//    return nowComps.year == selfComps.year
//    && nowComps.month == selfComps.month
//    && nowComps.day == selfComps.day;
//    
//}

- (BOOL)isToday {
    
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //把当前时间的转化成2015-09-08类似的字符串
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
    
}

- (BOOL)isYesterday {
    
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //把当前时间的转化成2015-09-08类似的字符串,再把那个字符串转化成时间, 作用:裁掉后面的时间, 只保留日期
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    //当前时间和调用该方法的时间对象对应的时间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;//那么就是昨天

}


@end
