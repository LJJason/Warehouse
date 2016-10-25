//
//  TRCircleTableViewController.m
//  TRHouse
//
//  Created by admin1 on 2016/10/9.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRCircleTableViewController.h"
#import "TRPostTableViewCell.h"
#import "TRPost.h"
#import "TRAccount.h"
#import "TRAccountTool.h"
#import "TRLoginViewController.h"
#import "CZComposeViewController.h"
#import "TRFoundSendViewController.h"
#import "TRCircleCommentViewController.h"
#import <HUPhotoBrowser.h>
#import "TRPostTableViewCell.h"


@interface TRCircleTableViewController ()
/** 模型数组 */
@property (nonatomic,strong) NSMutableArray *posts;
/** 当前页码 */
@property (nonatomic,assign) NSInteger page;

/** 请求真实url */
@property (nonatomic, copy) NSString *urlString;

@end

@implementation TRCircleTableViewController
//懒加载
- (NSMutableArray *)posts{
    if (!_posts) {
        _posts = [NSMutableArray array];
    }
    return _posts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题
    self.title = @"临居圈";
    
    [self setupUrl];
    [self setupRefresh];
    
    UIButton *rightItem = [[UIButton alloc]init];
    rightItem.frame = CGRectMake(0, 0,40,40);
    [rightItem setTitle:@"发布" forState:UIControlStateNormal];
    [rightItem addTarget:self action:@selector(sendPost) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightItem];
    
    
    
}


/**
 *  url处理
 */
- (void)setupUrl{
    if (self.urlStr == nil) {
        self.urlString = TRGetAllPostsUrl;
    }else {
        self.urlString = self.urlStr;
    }
}


-(void)setupRefresh
{   self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTheData)];
    
    //开始刷新
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden = YES;
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRPostTableViewCell *cell = [TRPostTableViewCell cell];
    TRPost *post = self.posts[indexPath.row];
    
//    TRGLog(@"%@", post.postcontent);
    
    cell.posts = post;
    cell.likeBlock = ^(TRPostTableViewCell *cell, NSString *user) {
        NSIndexPath *selectIndex = [self.tableView indexPathForCell:cell];
        
        TRPost *selectPost = self.posts[selectIndex.row];
        [selectPost.praiseUser addObject:user];
        [self.tableView reloadRowsAtIndexPaths:@[selectIndex] withRowAnimation:UITableViewRowAnimationNone];
        
        
    };
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TRPost *post = self.posts[indexPath.row];
    
    return post.cellRowHeight;
    
}

- (void)loadMoreData{
    
    NSInteger page = self.page + 1;
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"page"]  = @(page);
    
    if (self.urlStr) {
        TRAccount *account = [TRAccountTool account];
        para[@"uid"] = account.uid;
    }

    
    [TRHttpTool POST:self.urlString parameters:para success:^(id responseObject) {
        [self.posts addObjectsFromArray:[TRPost mj_objectArrayWithKeyValuesArray:responseObject[@"posts"]]];
        [self.tableView reloadData];
        
        self.page = page;
        
        NSInteger maxCount = [responseObject [@"maxCount"]integerValue];
        
        if (self.posts.count >= maxCount) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        
        
        
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)loadTheData{
    
    NSMutableDictionary *param = nil;
    
    if (self.urlStr) {
        param = [NSMutableDictionary dictionary];
        TRAccount *account = [TRAccountTool account];
        param[@"uid"] = account.uid;
    }
    
    [TRHttpTool GET:self.urlString parameters:param success:^(id responseObject) {
        //         TRGLog(@"%@",responseObject);
        self.posts = [TRPost mj_objectArrayWithKeyValuesArray:responseObject[@"posts"]];
        //设置页码
        self.page = 1;
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_footer.hidden = NO;
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_footer.hidden = NO;
        [Toast makeText:@"网络错误"];
        TRLog(@"Fail");
    }];

    
}

- (void)sendPost{
    
    if ([TRAccountTool loginState]) {
        TRFoundSendViewController *compVc = [[TRFoundSendViewController alloc] init];
        compVc.composeInteractiveSuccessBlock = ^{
            [self.tableView.mj_header beginRefreshing];
        };
        
        [self.navigationController pushViewController:compVc animated:YES];
    }else{
        //没有登录
        [self loginVc];
    }

    
    
}

- (void)loginVc {
    
    [Toast makeText:@"请先登录!"];
    
    TRLoginViewController *loginVc = [TRLoginViewController instantiateInitialViewControllerWithStoryboardName:@"LoginAndRegist"];
    loginVc.refreshDataBlock = ^ {
        
    };
    [self presentViewController:loginVc animated:YES completion:nil];
}

/* 当点击cell扩大该视图 **/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TRCircleCommentViewController *commentVc = [TRCircleCommentViewController viewControllerWtithStoryboardName:TRFoundStoryboardName identifier:NSStringFromClass([TRCircleCommentViewController class])];
    
    commentVc.post = self.posts[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
