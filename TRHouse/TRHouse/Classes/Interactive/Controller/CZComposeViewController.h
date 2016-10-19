
#import <UIKit/UIKit.h>

@interface CZComposeViewController : UIViewController

/** 发送成功回调 */
@property (nonatomic, copy) void (^composeInteractiveSuccessBlock)();

@end
