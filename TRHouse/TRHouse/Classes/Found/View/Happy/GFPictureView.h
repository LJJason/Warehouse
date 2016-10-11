

#import <UIKit/UIKit.h>
@class GFPiece;
@interface GFPictureView : UIView

+ (instancetype) pictureView;

/** 模型 */
@property (nonatomic, strong) GFPiece *piece;

@end
