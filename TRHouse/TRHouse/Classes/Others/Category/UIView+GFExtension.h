
#import <UIKit/UIKit.h>

@interface UIView (GFExtension)

@property (nonatomic, assign)CGSize size;

@property (nonatomic, assign)CGFloat width;

@property (nonatomic, assign)CGFloat height;

@property (nonatomic, assign)CGFloat x;

@property (nonatomic, assign)CGFloat y;

@property (nonatomic, assign)CGFloat centerX;

@property (nonatomic, assign)CGFloat centerY;

/** 判断两个控件是否有交集 */
- (BOOL)isShowingOnKeyWindow;

@end
