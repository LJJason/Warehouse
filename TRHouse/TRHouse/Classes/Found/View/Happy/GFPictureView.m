//
//  GFPictureView.m
//  百思不得姐
//
//  Created by wgf on 16/5/16.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "GFPictureView.h"
#import "GFPiece.h"
#import "GFProgressView.h"
#import "GFSeeBigPictureViewController.h"


@interface GFPictureView ()

/**
 *  gif标识
 */
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

/**
 *  查看大图按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/**
 *  进度条
 */
@property (weak, nonatomic) IBOutlet GFProgressView *progressView;

@end



@implementation GFPictureView


+ (instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    //禁止自动拉伸autoresizing
    self.autoresizingMask = UIViewAutoresizingNone;

    //允许图片与用户交互
    self.pictureImageView.userInteractionEnabled = YES;
    //禁止底部的点击查看大图按钮以用户交互
    self.seeBigButton.userInteractionEnabled = NO;
    [self.pictureImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigPicture)]];
    
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

    //立马设置上次保存的下载进度
    [self.progressView setProgress:piece.pictureProgress animated:NO];
    //设置图片
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:piece.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        //注意:这里SDWebImage使用的是异步下载图片, 至ios9以后, 所以下面的更新UI要必须要在主线程进行
        piece.pictureProgress = 1.0 * receivedSize / expectedSize;
        //GFLog(@"%f", piece.pictureProgress);
        
        [self.progressView setProgress:piece.pictureProgress animated:NO];
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //下载完毕隐藏
        self.progressView.hidden = YES;
        //如果不是大图直接return
        if (!piece.isBigPicture) return;
        
        CGFloat width = piece.pictureFrmae.size.width;
        
        CGFloat height = width * image.size.height / image.size.width;
        
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(piece.pictureFrmae.size, YES, 0.0);
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        
        //从图形上下文中获取图片
        self.pictureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        //结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    //设置是否隐藏gif标识
    self.gifImageView.hidden = !piece.is_gif;
    
    //设置是否隐藏点击查看大图
//    if (piece.isBigPicture) {
//        self.seeBigButton.hidden = NO;
//        //设置图片的显示模式
//        //self.pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
//        
//    }else {
//        self.seeBigButton.hidden = YES;
//    }
    
    self.seeBigButton.hidden = !piece.isBigPicture;
    
}

@end
