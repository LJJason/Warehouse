
#import <UIKit/UIKit.h>
@class GFPiece;
@interface GFPieceCell : UITableViewCell

+ (instancetype)cell;

/** 帖子模型 */
@property (nonatomic, strong) GFPiece *piece;
@end
