//
//  TRTourViewController.m
//  TRHouse
//
//  Created by nankeyimeng on 16/10/10.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRTourViewController.h"
#import <NJKWebViewProgress.h>
#import "TRNoInternetConnectionView.h"

@interface TRTourViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic)  NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIProgressView *ProgressView;
- (IBAction)toStart:(UIBarButtonItem *)sender;

- (IBAction)toback:(UIBarButtonItem *)sender;
- (IBAction)RefreshAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goback;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ForWard;

@end

@implementation TRTourViewController



- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self refreshstate];
    
    [self WebViewWithProgressinit];
    
    [self UrlRequestand:self.Url];
    

}

#pragma mark ------------webView网络的请求-------------
//判断网络的类型
-(void)refreshstate{
    
    [TRHttpTool setReachabilityStatusChangeBlock:^(TRNetworking status) {
        if (status == TRNetworkingFailure) {
            
            [self webError];
        }
    }];
    
    
    
}

- (void)webError{
    TRNoInternetConnectionView *internet = [TRNoInternetConnectionView noInternetConnectionView];
    internet.frame = self.view.frame;
    [self.webView addSubview:internet];
    internet.reloadAgainBlock = ^{
        [self WebViewWithProgressinit];
    };
    
}

- (void)WebViewWithProgressinit{
    
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.delegate = self;
    
    
    self.progress = [[NJKWebViewProgress alloc]init];;
    self.webView.delegate = self.progress;
    __weak typeof (self) weakSelf = self;
    self.progress.progressBlock = ^(float progress){
        [weakSelf.ProgressView setProgress:progress animated:YES];
        weakSelf.ProgressView.hidden = (progress == 1.0);
    };
//    self.progress.progressDelegate = self;
    self.progress.webViewProxyDelegate = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self refreshstate];
    });
}
- (void)UrlRequestand:(NSString * )url{
    
    NSURL *Url = [NSURL URLWithString:url];
    NSURLRequest *requst = [NSURLRequest requestWithURL:Url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    [self.webView loadRequest:requst];
}




#pragma mark ----------NJKWebViewProgressDelegate---------

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    
    self.ProgressView.progress = progress;
}

#pragma mark -----------绑定按钮的实现方法---------------

- (IBAction)toStart:(UIBarButtonItem *)sender {
    [self.webView goForward];
    
}

- (IBAction)toback:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (IBAction)RefreshAction:(UIBarButtonItem *)sender {
    [self.webView reload];
}

#pragma mark------------UIWebViewDelegate------------
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.goback.enabled = webView.canGoBack;
    self.ForWard.enabled = webView.canGoForward;
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self webError];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
