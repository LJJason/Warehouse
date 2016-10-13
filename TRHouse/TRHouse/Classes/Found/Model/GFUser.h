

#import <Foundation/Foundation.h>

@interface GFUser : NSObject

/** 用户昵称 */
@property (nonatomic, copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

/** 用户性别 */
@property (nonatomic, copy) NSString *sex;


@end
