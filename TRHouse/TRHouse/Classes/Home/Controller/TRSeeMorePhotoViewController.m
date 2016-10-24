//
//  TRSeeMorePhotoViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/24.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRSeeMorePhotoViewController.h"
#import "TRPhotoCell.h"

@interface TRSeeMorePhotoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** UICollectionView */
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation TRSeeMorePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"房间相册";
    //初始化UICollectionView
    [self initView];
}

static NSString * const TRPhotoCellId = @"TRPhotoCellId";

/**
 *  初始化UICollectionView
 */
- (void)initView{
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.itemSize = CGSizeMake((TRScreenW - 20 ) / 2, 100);
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    flowLayout.minimumLineSpacing = 10;
//    
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, TRScreenW, TRScreenH) collectionViewLayout:flowLayout];
//    collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
//    collectionView.delegate = self;
//    collectionView.dataSource = self;
////    collectionView.showsHorizontalScrollIndicator = NO;
////    collectionView.pagingEnabled = YES;
//    collectionView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:collectionView];
//    
//    _collectionView=collectionView;
    //注册
    //[_collectionView registerClass:[TRPhotoCell class] forCellWithReuseIdentifier:TRPhotoCellId];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TRPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TRPhotoCellId forIndexPath:indexPath];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.photosUrl[0]] placeholderImage:[UIImage imageNamed:@"default_bg"]];
    
    
    return cell;
}

@end
