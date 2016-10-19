
#import <UIKit/UIKit.h>

@class CZComposeToolBar;
@protocol CZComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(CZComposeToolBar *)toolBar didClickBtn:(NSInteger)index;

@end

@interface CZComposeToolBar : UIView

@property (nonatomic, weak) id<CZComposeToolBarDelegate> delegate;

@end
