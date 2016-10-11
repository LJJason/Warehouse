//
//  GFVideoView.m
//  百思不得姐
//
//  Created by wgf on 16/5/29.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "GFVideoView.h"
#import "GFPiece.h"
#import "GFSeeBigPictureViewController.h"

@interface GFVideoView ()

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  播放量
 */
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
/**
 *  播放时间
 */
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;


@end


@implementation GFVideoView

+ (instancetype)videoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    //禁止自动拉伸autoresizing
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //允许图片与用户交互
    self.imageView.userInteractionEnabled = YES;
    //禁止底部的点击查看大图按钮以用户交互
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigPicture)]];
    
}

- (void)showBigPicture{
    
    GFSeeBigPictureViewController *seeBigPictureVc = [[GFSeeBigPictureViewController alloc] init];
    seeBigPictureVc.piece = self.piece;
    //因为UIView没有presentViewController方法
    //所以拿到窗口的根控制器在presentViewController
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigPictureVc animated:YES completion:nil];
    
}

- (void)setPiece:(GFPiece *)piece{
    
    _piece = piece;
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:piece.large_image]];
    
    //设置播放量
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", piece.playcount];
    
    //设置播放时长
    
    NSInteger videoTime = piece.videotime / 60;
    piece.videotime = piece.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", videoTime, piece.videotime];
}

@end
