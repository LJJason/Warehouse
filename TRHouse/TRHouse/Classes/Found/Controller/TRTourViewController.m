//
//  TRTourViewController.m
//  TRHouse
//
//  Created by nankeyimeng on 16/10/10.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRTourViewController.h"

@interface TRTourViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation TRTourViewController



- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.title = @"旅游攻略";
    
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.delegate = self;
    
    
   
    NSURL *Url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *requst = [NSURLRequest requestWithURL:Url];
    [self.webView loadRequest:requst];
    
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请求不成功请检查您的网络" preferredStyle:UIAlertControllerStyleActionSheet];
////    UIAlertAction *alertac = [UIAlertAction al
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    

    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
