

#import "GFPieceCell.h"
#import "GFPiece.h"
#import "GFPictureView.h"
#import "GFVoiceView.h"
#import "GFVideoView.h"
#import "GFPieceComment.h"
#import "GFUser.h"
#import "UIImageView+GFExtension.h"
@interface GFPieceCell ()

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/**
 *  顶
 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/**
 *  踩
 */
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/**
 *  转发
 */
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
/**
 *  评论
 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

/**
 *  新浪加v
 */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVImageView;

/**
 *  评论内容的父控件
 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

/**
 *  评论内容
 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;


/**
 *  帖子文本内容
 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;

/** 图片View */
@property (nonatomic, weak)GFPictureView *pictureView;
/** 音频View */
@property (nonatomic, weak)GFVoiceView *voiceView;
/** 视频View */
@property (nonatomic, weak)GFVideoView *videoView;

@end

@implementation GFPieceCell

+ (instancetype)cell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

/**
 *  图片控件懒加载
 */
- (GFPictureView *)pictureView {
    if (_pictureView == nil) {
        GFPictureView *pictureView = [GFPictureView pictureView];
        //这里weak是弱指针所以要先把pictureView加到父控件中保住命
        
        [self.contentView addSubview:pictureView];
        
        _pictureView = pictureView;
    }
    return _pictureView;
}

/**
 *  音频控件懒加载
 */
- (GFVoiceView *)voiceView {
    if (_voiceView == nil) {
        GFVoiceView *voiceView = [GFVoiceView voiceView];
        //这里weak是弱指针所以要先把voiceView加到父控件中保住命
        
        [self.contentView addSubview:voiceView];
        
        _voiceView = voiceView;
    }
    return _voiceView;
}

/**
 *  视频控件懒加载
 */
- (GFVideoView *)videoView {
    if (_videoView == nil) {
        GFVideoView *videoView = [GFVideoView videoView];
        //这里weak是弱指针所以要先把voiceView加到父控件中保住命
        
        [self.contentView addSubview:videoView];
        
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //设置cell的背景图片
    UIImageView *bgView = [[UIImageView alloc] init];
    
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    
    self.backgroundView = bgView;
    
}

- (void)setPiece:(GFPiece *)piece {

    _piece = piece;
    
    //self.text_label.lineBreakMode = UILineBreakModeWordWrap;
    //设置新浪加v
    self.sinaVImageView.hidden = !piece.isSina_v;
    
    //设置头像
    [self.profileImageView setHaderWithUrl:piece.profile_image];
    
    //设置昵称
    self.nameLabel.text = piece.name;
    
    //设置时间label
    self.timeLabel.text = piece.created_at;
    
    //设置帖子内容
    self.text_label.text = piece.text;

    //设置顶的数量
    [self setupButtonTitle:self.dingBtn count:piece.ding placeHolder:@"顶"];
    [self setupButtonTitle:self.caiBtn count:piece.cai placeHolder:@"踩"];
    [self setupButtonTitle:self.repostBtn count:piece.repost placeHolder:@"转发"];
    [self setupButtonTitle:self.commentBtn count:piece.comment placeHolder:@"评论"];
    
    if (piece.type == GFPieceTypePicture) {//是图片
        self.pictureView.hidden = NO;
        self.pictureView.piece = piece;
        self.pictureView.frame = piece.pictureFrmae;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (piece.type == GFPieceTypeVoice){//音频
        self.voiceView.hidden = NO;
        self.voiceView.piece = piece;
        self.voiceView.frame = piece.voiceFrmae;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }
    else if (piece.type == GFPieceTypeVideo){//视频
        self.videoView.hidden = NO;
        self.videoView.piece = piece;
        self.videoView.frame = piece.videoFrmae;
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }else {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    
    if (piece.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", piece.top_cmt.user.username, piece.top_cmt.content];
    }else {
        self.topCmtView.hidden = YES;
    }
    
}

- (void) setupButtonTitle:(UIButton *)button count:(NSInteger)count placeHolder:(NSString *)placeHolder{

    
    if (count > 10000) {
        placeHolder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    }else if (count > 0) {
        placeHolder = [NSString stringWithFormat:@"%zd", count];
    }
    
    [button setTitle:placeHolder forState:UIControlStateNormal];
}



- (void)setFrame:(CGRect)frame {
    
    //frame.origin.x = GFPieceCellMargin;
    //frame.size.width -= 2  * GFPieceCellMargin;
    
//    frame.size.height -= GFPieceCellMargin;
    frame.size.height = self.piece.cellHeight - GFPieceCellMargin;
    frame.origin.y += GFPieceCellMargin;
    
    [super setFrame:frame];
    
}

- (IBAction)more {

    UIAlertController *alert = [[UIAlertController alloc]init];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
}



@end
