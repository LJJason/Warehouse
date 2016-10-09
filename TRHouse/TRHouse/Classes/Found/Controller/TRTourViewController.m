//
//  TRTourViewController.m
//  TRHouse
//
//  Created by nankeyimeng on 16/10/10.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRTourViewController.h"
#import <NJKWebViewProgress.h>

@interface TRTourViewController ()<UIWebViewDelegate>
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
   
    
  
    
    [self WebViewWithProgressinit];
    
    [self UrlRequestand:self.Url];
    

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
    self.progress.progressDelegate = self;
    self.progress.webViewProxyDelegate = self;
    
}
- (void)UrlRequestand:(NSString * )url{
    
    NSURL *Url = [NSURL URLWithString:url];
    NSURLRequest *requst = [NSURLRequest requestWithURL:Url];
    [self.webView loadRequest:requst];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.goback.enabled = webView.canGoBack;
    self.ForWard.enabled = webView.canGoForward;
    
}
    
    




- (IBAction)toStart:(UIBarButtonItem *)sender {
    [self.webView goForward];
    
}

- (IBAction)toback:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (IBAction)RefreshAction:(UIBarButtonItem *)sender {
    [self.webView reload];
}
@end
