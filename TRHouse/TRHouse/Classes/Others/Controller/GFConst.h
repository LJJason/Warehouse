
#import <UIKit/UIKit.h>

/**
 帖子的类型
 */
typedef enum  {
    GFPieceTypeAll = 1,      //全部
    GFPieceTypePicture = 10, //图片
    GFPieceTypeWord = 29,    //段子
    GFPieceTypeVoice = 31,   //声音
    GFPieceTypeVideo = 41    //视频
} GFPieceType;


/** 顶部工具条的高度 */
UIKIT_EXTERN CGFloat const GFTitlesViewH;

/** 顶部工具条的Y值 */
UIKIT_EXTERN CGFloat const GFTitlesViewY;


/** 帖子cell中文本内容的Y值 */
UIKIT_EXTERN CGFloat const GFPieceTextY;

/** 帖子cell中底部工具条的高度 */
UIKIT_EXTERN CGFloat const GFPieceCellBottomBarH;


/** 统一间隔 */
UIKIT_EXTERN CGFloat const GFPieceCellMargin;


/** 图片帖子的图片的最大的高度 */
UIKIT_EXTERN CGFloat const GFPiecePictureMaxH;

/** 图片帖子的图片超过最大的高度时使用的固定高度 */
UIKIT_EXTERN CGFloat const GFPiecePictureBreakH;

/** 用户模型中 用户的性别 */
UIKIT_EXTERN NSString * const GFUserSexMale;
UIKIT_EXTERN NSString * const GFUserSexFeMale;
/** 最热评论标题的高度 */
UIKIT_EXTERN CGFloat const GFTopCmtTitleH;

/** tabBar选中时发出的通知名称 */
UIKIT_EXTERN NSString * const GFTabBarDidSelectedNotification;


