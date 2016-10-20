//
//  TRPersonalHomeViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/17.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRPersonalHomeViewController.h"
#import "TRPersonal.h"

#import "TRInteractiveTableViewController.h"
#import "TRCircleTableViewController.h"

@interface TRPersonalHomeViewController ()<UIScrollViewDelegate>

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;

/** 底部的红色指示器View */
@property (nonatomic, weak)UIView *indicatorView;
/** 记录当前选中的按钮 */
@property (nonatomic, weak)UIButton *selectedButton;

/** 底部的内容View */
@property (nonatomic, weak)UIScrollView *contentView;

/** 标签栏View */
@property (nonatomic, weak)UIView *titlesView;

@end

@implementation TRPersonalHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条相关
    [self setupNav];
    //加载数据
    [self loadData];
    
    //初始化子控制器
    [self setupChildViewControllers];
    
    //初始化标签栏
    [self setupTitlesView];
    
    //初始化scrollView
    [self setupContentView];
    
}

/**
 *  设置导航条相关
 */
- (void)setupNav{
    self.navigationItem.title = @"个人主页";
}

/**
 *  加载数据
 */
- (void)loadData{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.personal.icon] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.userNameLbl.text = self.personal.userName;
}

/**
 *  初始化子控制器
 */
- (void)setupChildViewControllers {
    
    
    TRInteractiveTableViewController *interVc = [TRInteractiveTableViewController instantiateInitialViewControllerWithStoryboardName:TRInteractiveStoryboardName];
    interVc.title = @"互动";
    interVc.urlStr = TRGetMeHomeInteractive;
    [self addChildViewController:interVc];
    
    TRCircleTableViewController *postVc = [TRCircleTableViewController viewControllerWtithStoryboardName:TRFoundStoryboardName identifier:NSStringFromClass([TRCircleTableViewController class])];
    postVc.title = @"帖子";
    postVc.urlStr = TRGetMePostsUrl;
    [self addChildViewController:postVc];
    
}

/**
 *  初始化标签栏
 */
- (void) setupTitlesView{
    
    UIView *titlesView = [[UIView alloc] init];
    self.titlesView = titlesView;
    //设置背景色切设置透明度为0.7
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    titlesView.y = 224;
    titlesView.width = self.view.width;
    titlesView.height = GFTitlesViewH;
    
    [self.view addSubview:titlesView];
    
    //底部的红色指示器View
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    
    //标签栏里面的按钮
    //NSArray *array = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    
    NSInteger count = self.childViewControllers.count;
    
    CGFloat btnW = titlesView.width / count;
    CGFloat btnH = titlesView.height;
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = i;
        button.x = btnW * i;
        button.width = btnW;
        button.height = btnH;
        
        //从当前控制器的子控制器数组中取出控制器
        UIViewController *vc = self.childViewControllers[i];
        
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认选中第一个
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            //让按钮内部的label马上根据字体计算出它自己的大小
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    //把红色指示器的添加拿到最后, 确保titlesView的subViews里面前面的全部是UIButton
    [titlesView addSubview:indicatorView];
}


/**
 * 初始化scrollView
 */
- (void) setupContentView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    //    contentView.backgroundColor = [UIColor redColor];
    contentView.x = 0;
    contentView.y = 260;
    contentView.width = self.view.width;
    contentView.height = self.view.height - contentView.y;
    //设置分页
    contentView.pagingEnabled = YES;
    //设置代理
    contentView.delegate = self;
    contentView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    
    self.contentView = contentView;
    [self.view insertSubview:contentView atIndex:0];
    
    //默认显示第一个
    [self scrollViewDidEndScrollingAnimation:contentView];
}


- (void)titleClick:(UIButton *)button{
    
    self.selectedButton.enabled = YES;
    
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //滚动scrollView
    CGPoint offset = self.contentView.contentOffset;
    
    offset.x = self.contentView.width * button.tag;
    
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 * scrollView滚动结束调用此代理
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    //获取索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = self.contentView.height;
    [scrollView addSubview:vc.view];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    [self titleClick:self.titlesView.subviews[index]];
    
}

@end
