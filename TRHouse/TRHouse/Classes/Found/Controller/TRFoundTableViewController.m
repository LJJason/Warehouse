//
//  TRFoundTableViewController.m
//  TRHouse
//
//  Created by wgf on 16/9/19.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRFoundTableViewController.h"
#import "TRTourViewController.h"

@interface TRFoundTableViewController ()<UITableViewDataSource,UITableViewDelegate>
- (IBAction)HotActivityAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)LookActivityAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (strong,nonatomic)TRTourViewController *vc;

@end

@implementation TRFoundTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"发现";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
    
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.vc = segue.destinationViewController;

    
    if ([segue.identifier isEqualToString:@"Tour"]) {
        
        self.vc.Url = TRTourUrl;
        self.vc.title = @"旅游攻略";

    }else if([segue.identifier isEqualToString:@"News"]){
        
        self.vc.Url = TRNewsUrl;
        self.vc.title = @"奇闻趣事多";
    }else if ([segue.identifier isEqualToString:@"Happy"]){
        
        self.vc.Url = TRHappyUrl;
        self.vc.title = @"欢乐笑语汇";
        
    }
    
}


- (IBAction)HotActivityAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)LookActivityAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)LJcircleAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
