
#import "CZComposeToolBar.h"

@implementation CZComposeToolBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        // 添加所有子控件
        [self setUpAllChildView];
        
    }
    return self;
}

#pragma mark - 添加所有子控件
- (void)setUpAllChildView
{
    // 相册
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
//    // 提及
//    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
//    // 话题
//    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
//    // 表情
//    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
//    // 键盘]
//    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
}

- (void)setUpButtonWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.tag = self.subviews.count;
 
    [self addSubview:btn];
}

- (void)btnClick:(UIButton *)button
{
    
    // 点击工具条的时候
    
    if ([_delegate respondsToSelector:@selector(composeToolBar:didClickBtn:)]) {
        [_delegate composeToolBar:self didClickBtn:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i = 0 ; i < count; i++) {
        UIButton *btn = self.subviews[i];
        x = i * w;
        btn.frame = CGRectMake(20, y, w, h);
    }
    
}

@end
