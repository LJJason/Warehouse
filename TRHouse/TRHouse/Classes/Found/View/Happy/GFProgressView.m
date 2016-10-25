

#import "GFProgressView.h"

@implementation GFProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.progressLabel.textColor = [UIColor whiteColor];
    
    //裁剪的圆角的像素
    self.roundedCorners = 2;
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%d%%", (int)(progress * 100)];
    //将text中出现的-替换成空的
    text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    
    self.progressLabel.text = text;
}

@end
