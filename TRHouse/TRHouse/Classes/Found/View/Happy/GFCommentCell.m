

#import "GFCommentCell.h"
#import "GFPieceComment.h"
#import "GFUser.h"
#import "UIImageView+GFExtension.h"

@interface GFCommentCell ()

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 *  性别
 */
@property (weak, nonatomic) IBOutlet UIImageView *sexView;

/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/**
 *  点赞数
 */
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
/**
 *  评论内容
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation GFCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //设置cell的背景图
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    
    self.backgroundView = bgView;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComment:(GFPieceComment *)comment {
    _comment = comment;
    
    //设置头像
    [self.iconView setHaderWithUrl:comment.user.profile_image];
    //设置性别
    self.sexView.image = [comment.user.sex isEqualToString:GFUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    
    //设置昵称
    self.nameLabel.text = comment.user.username;
    
    //点赞数
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    //设置评论内容
    self.contentLabel.text = comment.content;
    
    //设置音频的时长
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    }else {
        self.voiceButton.hidden = YES;
    }
    
}
- (void)setFrame:(CGRect)frame {
    
//    frame.origin.x = GFPieceCellMargin;
//    frame.size.width -= 2 * GFPieceCellMargin;
    
    [super setFrame:frame];
}

@end
