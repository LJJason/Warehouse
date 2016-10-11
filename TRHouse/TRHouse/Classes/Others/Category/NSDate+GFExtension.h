
#import <Foundation/Foundation.h>

@interface NSDate (GFExtension)

/**
*  比较from和self之间的差值
*
*  @param from 需要比较的那个时间
*
*  @return 两个时间的差值
*/
- (NSDateComponents *) deltaFrom:(NSDate *)from;

/**
 *  是否是今年
 *
 *  @return 是 : YES 否 : NO
 */
- (BOOL)isThisYear;

/**
 *  是否是今天
 *
 *  @return 是 : YES 否 : NO
 */
- (BOOL)isToday;

/**
 *  是否是昨天
 *
 *  @return 是 : YES 否 : NO
 */
- (BOOL)isYesterday;


@end
