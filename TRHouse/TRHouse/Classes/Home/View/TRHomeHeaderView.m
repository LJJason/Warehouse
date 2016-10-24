//
//  TRHomeHeaderView.m
//  TRHouse
//
//  Created by wgf on 16/10/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRHomeHeaderView.h"
#import "TRHeaderCell.h"
#import "TRRoom.h"
#import "TRHotAndSelectTableViewController.h"
#import "TRRoomDetailViewController.h"

#define TRMaxSections 100

@interface TRHomeHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UIPageControl *pageControl;
@property (nonatomic , strong) NSTimer *timer;

/** 轮播的个数 */
@property (nonatomic, assign) NSInteger count;

/** 自身高度 */
@property (nonatomic, assign) CGFloat currentHeight;
@end

@implementation TRHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initView];
    }
    return self;
}


- (NSInteger)count{
    if (self.rooms.count == 0) {
        return 5;
    }else{
        return self.rooms.count;
    }
}

static NSString * const TRcellId = @"TRcellId";

- (void)initView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(TRScreenW, 130);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, TRScreenW, 130) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:collectionView];
    
    _collectionView=collectionView;
    
    [self.collectionView registerClass:[TRHeaderCell class] forCellWithReuseIdentifier:TRcellId];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:TRMaxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.bounds = CGRectMake(0, 0, 150, 40);
    pageControl.center = CGPointMake(TRScreenW*0.3, 110);
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = TRColor(0, 220, 255, 1.0);
    pageControl.enabled = NO;
    pageControl.numberOfPages = self.count;
    
    [self addSubview:pageControl];
    
    _pageControl=pageControl;
    
    
    [self addTimer];
    
    //精选
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setBackgroundImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(didClickSelectBtn) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.x = 5;
    selectBtn.y = CGRectGetMaxY(collectionView.frame) + 5;
    selectBtn.width = (TRScreenW - 15) / 2;
    selectBtn.height = selectBtn.width / 2.45;
    [self addSubview:selectBtn];
    
    UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [hotBtn setBackgroundImage:[UIImage imageNamed:@"hot"] forState:UIControlStateNormal];
    [hotBtn addTarget:self action:@selector(didClickHotBtn) forControlEvents:UIControlEventTouchUpInside];
    hotBtn.x = CGRectGetMaxX(selectBtn.frame) + 5;
    hotBtn.y = CGRectGetMaxY(collectionView.frame) + 5;
    hotBtn.width = (TRScreenW - 15) / 2;
    hotBtn.height = hotBtn.width / 2.45;
    [self addSubview:hotBtn];
    self.currentHeight = CGRectGetMaxY(hotBtn.frame) + 5;
}

#pragma mark 添加定时器
-(void) addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer ;
    
}

#pragma mark 删除定时器
-(void) removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void) nextpage{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:TRMaxSections/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item +1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem==self.count) {
        nextItem=0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return TRMaxSections;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TRHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TRcellId forIndexPath:indexPath];
    if(!cell){
        cell = [[TRHeaderCell alloc] init];
    }
    cell.room =self.rooms[indexPath.item];
    return cell;
}


/**
 *  选中
 *
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TRRoomDetailViewController *detailVc = [TRRoomDetailViewController viewControllerWtithStoryboardName:TRHomeStoryboardName identifier:NSStringFromClass([TRRoomDetailViewController class])];
    detailVc.room = self.rooms[indexPath.row];
    detailVc.placemark = self.placemark;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0] pushViewController:detailVc animated:YES];

}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

#pragma mark 当用户停止的时候调用
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
    
}

#pragma mark 设置页码
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.count;
    self.pageControl.currentPage =page;
}

- (void)setRooms:(NSArray *)rooms {
    _rooms = rooms;
    
    [self.collectionView reloadData];
}

- (void)setFrame:(CGRect)frame {
    frame.size.height = self.currentHeight;
    [super setFrame:frame];
}

/**
 *  点击精选按钮
 */
- (void)didClickSelectBtn{
    [self hotAndSelect:TRGetSelectRoomUrl title:@"精选"];
}

/**
 *  点击热门按钮
 */
- (void)didClickHotBtn{
    [self hotAndSelect:TRGetHotRoomUrl title:@"热门"];
}

- (void)hotAndSelect:(NSString *)urlStr title:(NSString *)title {
    TRHotAndSelectTableViewController *selectVc = [[TRHotAndSelectTableViewController alloc] init];
    selectVc.urlStr = urlStr;
    selectVc.navTitle = title;
    selectVc.placemark = self.placemark;
    [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0] pushViewController:selectVc animated:YES];
}

@end
