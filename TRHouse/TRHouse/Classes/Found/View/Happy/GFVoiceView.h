

#import <UIKit/UIKit.h>
@class GFPiece;

@interface GFVoiceView : UIView


+ (instancetype) voiceView;

/** 模型 */
@property (nonatomic, strong) GFPiece *piece;

@end
