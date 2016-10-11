//
//  GFSeeBigPictureViewController.m
//  百思不得姐
//
//  Created by wgf on 16/5/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "GFSeeBigPictureViewController.h"
#import "GFPiece.h"
#import "GFProgressView.h"

@interface GFSeeBigPictureViewController ()
@property (weak, nonatomic) IBOutlet GFProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/** 图片控件 */
@property (nonatomic, weak)UIImageView *imageView;
@end

@implementation GFSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    //允许与用户交互
    imageView.userInteractionEnabled = YES;
    //添加监听
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    
    CGFloat pictureW = TRScreenW;
    CGFloat pictureH = pictureW * self.piece.height / self.piece.width;
    
    if (pictureH > TRScreenH) {//图片宽度大于屏幕宽度
        
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
        
    } else{//小于
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        imageView.centerY = TRScreenH * 0.5;
    }
    
    [self.progressView setProgress:self.piece.pictureProgress animated:YES];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.piece.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //图片下载完毕隐藏
        self.progressView.hidden = YES;
    }];
    
    
    
    
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePicture {
    
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"正在下载,请稍后!"];
        return;
    }
    //把图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
        
    }
}

@end
