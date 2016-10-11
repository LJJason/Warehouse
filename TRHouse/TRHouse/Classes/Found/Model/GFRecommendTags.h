
#import <Foundation/Foundation.h>

@interface GFRecommendTags : NSObject

/** 推荐标签图片的URL字符串 */
@property (nonatomic, copy) NSString *image_list;

/** 推荐标签昵称 */
@property (nonatomic, copy) NSString *theme_name;

/** 推荐标签的订阅量 */
@property (nonatomic, assign)NSInteger sub_number;


@end
