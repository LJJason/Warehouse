

#import "UIBarButtonItem+GFExtension.h"

@implementation UIBarButtonItem (GFExtension)

+ (instancetype)itemWithImage:(NSString *)image hlImage:(NSString *)hlImage target:(id)target action:(SEL)action {
    //设置导航栏左侧的按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hlImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}

@end
