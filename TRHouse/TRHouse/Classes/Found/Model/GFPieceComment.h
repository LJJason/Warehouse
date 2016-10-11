

#import <Foundation/Foundation.h>

@class GFUser;

@interface GFPieceComment : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;

/** 评论内容 */
@property (nonatomic, copy) NSString *content;
/** 点赞数 */
@property (nonatomic, assign)NSInteger like_count;
/** 用户模型 */
@property (nonatomic, strong) GFUser *user;

/** 音频评论的url */
@property (nonatomic, copy) NSString *voiceuri;

/** 音频 */
@property (nonatomic, assign) NSInteger voicetime;

@end
