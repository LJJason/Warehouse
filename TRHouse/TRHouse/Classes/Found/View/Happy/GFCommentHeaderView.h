

#import <UIKit/UIKit.h>

@interface GFCommentHeaderView : UITableViewHeaderFooterView

/** 标题文字 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
