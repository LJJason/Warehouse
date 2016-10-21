//
//  TRFeedbackViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/22.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRFeedbackViewController.h"
#import "CZTextView.h"
#import "Utilities.h"
#import "TRAccount.h"
#import "TRAccountTool.h"
#import "TRProgressTool.h"

@interface TRFeedbackViewController ()<UITextViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) CZTextView *textView;

@end

@implementation TRFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    [self setUpTextView];
}

#pragma mark - 添加textView
- (void)setUpTextView
{
    CZTextView *textView = [[CZTextView alloc] initWithFrame:CGRectMake(0, 64, TRScreenW, 200)];
    _textView = textView;
    // 设置占位符
    textView.placeHolder = @"请输入您在使用过程中遇到的问题或您宝贵的建议";
    textView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textView];
    
    // 默认允许垂直方向拖拽
    textView.alwaysBounceVertical = YES;
    
    // 监听文本框的输入
    /**
     *  Observer:谁需要监听通知
     *  name：监听的通知的名称
     *  object：监听谁发送的通知，nil:表示谁发送我都监听
     *
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
    // 监听拖拽
    _textView.delegate = self;
}

#pragma mark - 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - 文字改变的时候调用
- (void)textChange
{
    // 判断下textView有木有内容
    if (_textView.text.length) { // 有内容
        _textView.hidePlaceHolder = YES;
    
    }else if ([_textView.text isEqualToString:@""] || _textView.text.length <= 0){
        _textView.hidePlaceHolder = NO;
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_textView becomeFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  提交
 */
- (IBAction)commitBtnClick {
    
    [self.view endEditing:YES];
    
    if (self.textView.text.length <= 0) {
        [Utilities popUpAlertViewWithMsg:@"请输入内容哦" andTitle:nil];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    TRAccount *account = [TRAccountTool account];
    param[@"uid"] = account.uid;
    param[@"feedback"] = self.textView.text;
    [TRProgressTool showWithMessage:@"正在提交!"];
    [TRHttpTool POST:TRFeedbackPwd parameters:param success:^(id responseObject) {
        NSInteger state = [responseObject[@"state"] integerValue];
        NSString *message = @"";
        [TRProgressTool dismiss];
        if (state == 1) {
            self.textView.text = nil;
            message = @"提交成功, 我们会尽快完善!";
        }else {
            message = @"提交失败, 请重新提交!";
        }
        [Toast makeText:message];
        
    } failure:^(NSError *error) {
        [TRProgressTool dismiss];
        [Toast makeText:@"提交失败, 请检查网络连接!"];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
