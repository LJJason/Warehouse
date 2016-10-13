

#import <UIKit/UIKit.h>
@class GFPiece;

@interface GFVideoView : UIView


+ (instancetype) videoView;

/** 模型 */
@property (nonatomic, strong) GFPiece *piece;

@end
