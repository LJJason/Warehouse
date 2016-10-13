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



@interface TRCircleTableViewController ()
/** 模型数组 */
@property (nonatomic,strong) NSMutableArray *posts;


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
    
    self.tableView.rowHeight = 400;
    
    
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    
    [TRHttpTool GET:@"http://yearwood.top/TRHouse/getAllPost" parameters:nil success:^(id responseObject) {
         TRGLog(@"%@",responseObject);
        self.posts = [TRPost mj_objectArrayWithKeyValuesArray:responseObject[@"posts"]];
        
        [self.tableView reloadData];
        
       
    } failure:^(NSError *error) {
        
        TRGLog(@"Fail");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell"];
    TRPost *post = self.posts[indexPath.row];
    
    TRGLog(@"%@", post.postcontent);
    
    cell.posts = post;
    
    return cell;
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
