
#import <UIKit/UIKit.h>

//13426545523   1234


/*** 获取七牛token的接口 */
NSString * const TRGetTokenUrl = @"http://yearwood.top/TRMerchants/gettoken";

//盐
NSString * const salt = @"dfgshdgajnvahheht[q4tu0q4!@#$%*&()(*&^%*(*&^%$%^&*(*&^%$#$%^&djgvkbklsdbfbalesbdgnvabgareugbairbgcnxcnsdgn'aergheorhgg;sdf>RTYUHJKJHGFDSEDRFTGHJKHGFDRRFTGYHJKNHBGFDFGHJIOKIUYTRE$W#$%^&*(IU*YT^R%E$W#ESDXCVBNJBBVGFDRFGHJK";

/*** 支付结果通知 */
NSString * const kTRPayResultNotification = @"alipayResult";


/* ============================ Storyboard 相关============================*/
/*** 首页页的StoryboardName */
NSString * const TRHomeStoryboardName = @"Home";

/*** 互动页的StoryboardName */
NSString * const TRInteractiveStoryboardName = @"Interactive";

/*** 发现页的StoryboardName */
NSString * const TRFoundStoryboardName = @"TRFound";

/*** me页的StoryboardName */
NSString * const TRMeStoryboardName = @"Me";






/* ============================ 登录注册模块 相关============================*/
/*** 获取验证码 */
NSString * const TRGetVcCodeUrl = @"http://yearwood.top/TRHouse/sendSms";

/*** 注册的接口 */
NSString * const TRRegistUrl = @"http://yearwood.top/TRHouse/regist";
/*** 登录的接口 */
NSString * const TRLoginUrl = @"http://yearwood.top/TRHouse/login";

/*** 忘记密码的接口 */
NSString * const TRForgetPwd = @"http://yearwood.top/TRHouse/changePwd";

/*** 查询用户是否存在的接口 */
NSString * const TRGetUserUrl = @"http://yearwood.top/TRHouse/getUser";






/* ============================ 首页 相关============================*/
/*** 首页新品推荐的接口 */
NSString * const TRGetNewRoomUrl = @"http://yearwood.top/TRHouse/getNewRoom";

/*** 首页轮播推荐的接口 */
NSString * const TRGetRecommendedRoomUrl = @"http://yearwood.top/TRHouse/getRecommendedRoom";

/*** 首页热门的接口 */
NSString * const TRGetHotRoomUrl = @"http://yearwood.top/TRHouse/getHotRoom";

/*** 首页精选的接口 */
NSString * const TRGetSelectRoomUrl = @"http://yearwood.top/TRHouse/getSelectRoom";

/*** 支付成功的接口 */
NSString * const TRPaySuccessUrl = @"http://yearwood.top/TRHouse/payOrder";






/* ============================ 互动模块 相关============================*/

/*** 获取所有互动的接口 */
NSString * const TRGetAllInteractiveUrl = @"http://yearwood.top/TRHouse/getAllInteractive";

/*** 发互动的接口 */
NSString * const TRComposeInteractiveUrl = @"http://yearwood.top/TRHouse/interactiveting";

/**
 *  获取互动评论的接口
 */
NSString * const TRGetAllInteractiveCommentsUrl = @"http://yearwood.top/TRHouse/getInteractiveComment";

/*** 发互动评论的接口 */
NSString * const TRSendInteractiveCommentUrl = @"http://yearwood.top/TRHouse/sendInteractiveComment";
/** 一拍即合接口 */
NSString * const TRHitItOffUrl = @"http://yearwood.top/TRHouse/hititoff";






/* ============================ 发现模块 相关============================*/
/*** 旅游攻略的接口 */
NSString * const TRTourUrl = @"http://guide.qyer.com/";
NSString * const TRNewsUrl = @"http://www.4908.cn/";
NSString * const TRHappyUrl =  @"http://www.gxdxw.cn/";

/*** 发邻居圈的接口 */
NSString * const TRFoundSentPostUrl = @"http://yearwood.top/TRHouse/postings";

/*** 点赞的接口 */
NSString * const TRLikeUrl = @"http://yearwood.top/TRHouse/like";

/*** 获取临居圈的数据的接口 */ //yearwood.top  192.168.61.79
NSString * const TRGetAllPostsUrl = @"http://yearwood.top/TRHouse/getAllPost";

/*** 发邻居圈评论的接口 */
NSString * const TRCirleSendComment = @"http://yearwood.top/TRHouse/sendComment";

/*** 获取邻居圈评论的接口 */
NSString * const TRGetCirleComment = @"http://yearwood.top/TRHouse/getComments";




/* ============================ 我的模块 相关============================*/

/*** 获取我的帖子的数据的接口 */
NSString * const TRGetMePostsUrl = @"http://yearwood.top/TRHouse/getMePosts";

/*** 获取我的互动的数据的接口 */
NSString * const TRGetMeHomeInteractive = @"http://yearwood.top/TRHouse/getMeHomeInteractive";

/*** 修改昵称的接口 */
NSString * const TRChangeUserNameUrl = @"http://yearwood.top/TRHouse/updateUserName";

/*** 修改头像的接口 */
NSString * const TRChangeIconUrl = @"http://yearwood.top/TRHouse/updateIcon";


/*** 修改密码的接口 */
NSString * const TRChangeTheOldPwd = @"http://yearwood.top/TRHouse/modifyThePwd";

/*** 意见反馈的接口 */
NSString * const TRFeedbackPwd = @"http://yearwood.top/TRHouse/feedback";


/*** 获取别人发来的一拍即合请求的接口 */
NSString * const TRGetMeInteractiveUrl = @"http://yearwood.top/TRHouse/getMeInteractive";

/*** 获取个人资料的接口 */
NSString * const TRGetPersonalUrl = @"http://yearwood.top/TRHouse/getPersonal";

/*** 获取一拍即合内容的接口 */
NSString * const TRGetInteractiveUrl = @"http://yearwood.top/TRHouse/getInteractive";




















