
#import "CZComposeViewController.h"
#import "CZTextView.h"
#import "CZComposeToolBar.h"
#import "CZComposePhotosView.h"
#import "TRProgressTool.h"
#import "AlbumNavigationController.h"
#import "TRUploadTool.h"
#import "TRComposeParam.h"
#import "TRAccount.h"
#import "TRAccountTool.h"



@interface CZComposeViewController ()<UITextViewDelegate,CZComposeToolBarDelegate, AlbumNavigationControllerDelegate>
@property (nonatomic, weak) CZTextView *textView;
@property (nonatomic, weak) CZComposeToolBar *toolBar;
@property (nonatomic, weak) CZComposePhotosView *photosView;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation CZComposeViewController

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航条
    [self setUpNavgationBar];
    
    // 添加textView
    [self setUpTextView];
    
    // 添加工具条
    [self setUpToolBar];
    
    // 监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 添加相册视图
    [self setUpPhotosView];
    
}
// 添加相册视图
- (void)setUpPhotosView
{
    CZComposePhotosView *photosView = [[CZComposePhotosView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height - 70)];
    _photosView = photosView;
    [_textView addSubview:photosView];
}

#pragma mark - 键盘的Frame改变的时候调用
- (void)keyboardFrameChange:(NSNotification *)note
{
    
    // 获取键盘弹出的动画时间
    CGFloat durtion = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (frame.origin.y == self.view.height) { // 没有弹出键盘
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform =  CGAffineTransformIdentity;
        }];
    }else{ // 弹出键盘
        // 工具条往上移动258
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
   
}

- (void)setUpToolBar
{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    CZComposeToolBar *toolBar = [[CZComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    _toolBar = toolBar;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
}

#pragma mark - 点击工具条按钮的时候调用
- (void)composeToolBar:(CZComposeToolBar *)toolBar didClickBtn:(NSInteger)index
{
    
    if (index == 0) { // 点击相册
        
        if (self.images.count < 9) {
            AlbumNavigationController *albnav = [[AlbumNavigationController alloc] initWithMaxImagesCount:9 delegate:self];
            albnav.navigationBar.barTintColor = TRColor(0, 220, 255, 1.0);
            [self presentViewController:albnav animated:YES completion:nil];
        }else{
            [Toast makeText:@"最多能添加9张图片"];
        }
        
    }
}

#pragma mark - 选择图片完成的时候调用
- (void)albumNavigationController:(AlbumNavigationController *)navigation didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets{
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < photos.count; i++) {
        UIImage *temImage = photos[i];
        //压缩图片
        NSData *data = UIImageJPEGRepresentation(temImage, 0.1);
        [imageArray addObject:[UIImage imageWithData:data]];
    }
    
    [self.images addObjectsFromArray:imageArray];
    
    for (UIImage *image in imageArray) {
        _photosView.image = image;
    }
}

#pragma mark - 添加textView
- (void)setUpTextView
{
    CZTextView *textView = [[CZTextView alloc] initWithFrame:self.view.bounds];
    _textView = textView;
    // 设置占位符
    textView.placeHolder = @"分享互动";
    textView.font = [UIFont systemFontOfSize:18];
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
        _rightItem.enabled = YES;
        CGSize size = [_textView.text boundingRectWithSize:CGSizeMake(TRScreenW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil].size;
        
        if (size.height + 50 > _photosView.y) {
            _photosView.y = size.height + 50;
        }
        
    }else{
        _textView.hidePlaceHolder = NO;
        _rightItem.enabled = NO;
        _photosView.y = 70;
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

- (void)setUpNavgationBar
{
    self.title = @"发互动";
    
    // right
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    
    // 监听按钮点击
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    _rightItem = rightItem;
}

// 互动
- (void)compose
{
    [self.view endEditing:YES];
    //有图片
    if (self.images.count > 0) {
        [self sendImage];
    }else {
        //没图片
        [self saveDataWith:nil];
    }
    
}

- (void)sendImage{
    [TRProgressTool showWithMessage:@"正在提交..."];
    //上房间照片
    [TRUploadTool uploadMoreImage:self.images success:^(NSArray *imagePath) {
        
        if (imagePath.count < self.images.count) {
            
            [TRProgressTool dismiss];
            [Toast makeText:@"提交失败!!请检查网络连接"];
            
        }else {
            //存储认证信息
            [self saveDataWith:imagePath];
        }
    }];
}


- (void)saveDataWith:(NSArray *)imagePath{
    
    if (_textView.text.length == 0) {
        _textView.text = @"分享照片";
    }
    
    //创建参数实例
    TRComposeParam *parma = [[TRComposeParam alloc] init];
    //获取账号信息
    TRAccount *account = [TRAccountTool account];
    
    parma.uid = account.uid;
    
    parma.content = _textView.text;
    
    if (self.images.count > 0) {
        //图片路径
        NSString *pathStr = [imagePath componentsJoinedByString:@","];
        parma.photos = pathStr;
    }
    
    //存储认证信息
    [TRHttpTool POST:TRComposeInteractiveUrl parameters:parma.mj_keyValues success:^(id responseObject) {
        [TRProgressTool dismiss];
        
        NSInteger state = [responseObject[@"state"] integerValue];
        
        if (state == 1) {
            if (self.composeInteractiveSuccessBlock) {
                self.composeInteractiveSuccessBlock();
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else {
            [Toast makeText:@"提交失败!!请检查网络连接!"];
        }
        
    } failure:^(NSError *error) {
        [TRProgressTool dismiss];
        [Toast makeText:@"提交失败!!请检查网络连接!"];
    }];
}



@end
