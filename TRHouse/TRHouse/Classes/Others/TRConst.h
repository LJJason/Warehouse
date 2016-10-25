//
//  TRConst.h
//  TRMerchants
//
//  Created by wgf on 16/10/8.
//  Copyright © 2016年 wgf. All rights reserved.
//  常量包

#import <UIKit/UIKit.h>

/*** 获取七牛token的接口 */
UIKIT_EXTERN NSString * const TRGetTokenUrl;

//盐
UIKIT_EXTERN NSString * const salt;


/* ============================ Storyboard 相关============================*/
/*** 首页页的StoryboardName */
UIKIT_EXTERN NSString * const TRHomeStoryboardName;

/*** 互动页的StoryboardName */
UIKIT_EXTERN NSString * const TRInteractiveStoryboardName;

/*** 发现页的StoryboardName */
UIKIT_EXTERN NSString * const TRFoundStoryboardName;

/*** me页的StoryboardName */
UIKIT_EXTERN NSString * const TRMeStoryboardName;






/* ============================ 登录注册模块 相关============================*/

/*** 获取验证码的接口 */
UIKIT_EXTERN NSString * const TRGetVcCodeUrl;

/*** 注册的接口 */
UIKIT_EXTERN NSString * const TRRegistUrl;

/*** 登录的接口 */
UIKIT_EXTERN NSString * const TRLoginUrl;

/*** 查询用户是否存在的接口 */
UIKIT_EXTERN NSString * const TRGetUserUrl;

/*** 忘记密码的接口 */
UIKIT_EXTERN NSString * const TRForgetPwd;






/* ============================ 首页模块 相关============================*/
/*** 首页新品推荐的接口 */
UIKIT_EXTERN NSString * const TRGetNewRoomUrl;

/*** 首页轮播推荐的接口 */
UIKIT_EXTERN NSString * const TRGetRecommendedRoomUrl;

/*** 首页热门的接口 */
UIKIT_EXTERN NSString * const TRGetHotRoomUrl;

/*** 首页精选的接口 */
UIKIT_EXTERN NSString * const TRGetSelectRoomUrl;







/* ============================ 互动模块 相关============================*/
/*** 获取所有互动的接口 */
UIKIT_EXTERN NSString * const TRGetAllInteractiveUrl;

/*** 发互动的接口 */
UIKIT_EXTERN NSString * const TRComposeInteractiveUrl;
/**
 *  获取互动评论的接口
 */
UIKIT_EXTERN NSString * const TRGetAllInteractiveCommentsUrl;
/*** 发互动评论的接口 */
UIKIT_EXTERN NSString * const TRSendInteractiveCommentUrl;

/** 一拍即合接口 */
UIKIT_EXTERN NSString * const TRHitItOffUrl;








/* ============================ 发现模块 相关============================*/
/*** 旅游攻略的接口 */
UIKIT_EXTERN NSString * const TRTourUrl;
/*** 奇闻趣事多的接口 */
UIKIT_EXTERN NSString * const TRNewsUrl;
/*** 欢乐笑语汇的接口 */
UIKIT_EXTERN NSString * const TRHappyUrl;

/*** 点赞的接口 */
UIKIT_EXTERN NSString * const TRLikeUrl;

/*** 获取临居圈的数据的接口 */
UIKIT_EXTERN NSString * const TRGetAllPostsUrl;

/*** 发邻居圈的接口 */
UIKIT_EXTERN NSString * const TRFoundSentPostUrl;

/*** 发邻居圈评论的接口 */
UIKIT_EXTERN NSString * const TRCirleSendComment;


/*** 获取邻居圈评论的接口 */
UIKIT_EXTERN NSString * const TRGetCirleComment;



/* ============================ 我的模块 相关============================*/

/*** 获取我的帖子的数据的接口 */
UIKIT_EXTERN NSString * const TRGetMePostsUrl;

/*** 获取我的互动的数据的接口 */
UIKIT_EXTERN NSString * const TRGetMeHomeInteractive;

/*** 修改昵称的接口 */
UIKIT_EXTERN NSString * const TRChangeUserNameUrl;

/*** 修改头像的接口 */
UIKIT_EXTERN NSString * const TRChangeIconUrl;

/*** 修改密码的接口 */
UIKIT_EXTERN NSString * const TRChangeTheOldPwd;

/*** 意见反馈的接口 */
UIKIT_EXTERN NSString * const TRFeedbackPwd;

/*** 获取个人资料的接口 */
UIKIT_EXTERN NSString * const TRGetPersonalUrl;

/*** 获取别人发来的一拍即合请求的接口 */
UIKIT_EXTERN NSString * const TRGetMeInteractiveUrl;

/*** 获取一拍即合内容的接口 */
UIKIT_EXTERN NSString * const TRGetInteractiveUrl;






