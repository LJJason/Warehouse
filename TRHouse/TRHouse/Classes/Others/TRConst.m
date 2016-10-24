
#import <UIKit/UIKit.h>

//13426545523   1234


/*** 获取七牛token的接口 */
NSString * const TRGetTokenUrl = @"http://yearwood.top/TRMerchants/gettoken";

//盐
NSString * const salt = @"dfgshdgajnvahheht[q4tu0q4!@#$%*&()(*&^%*(*&^%$%^&*(*&^%$#$%^&djgvkbklsdbfbalesbdgnvabgareugbairbgcnxcnsdgn'aergheorhgg;sdf>RTYUHJKJHGFDSEDRFTGHJKHGFDRRFTGYHJKNHBGFDFGHJIOKIUYTRE$W#$%^&*(IU*YT^R%E$W#ESDXCVBNJBBVGFDRFGHJK";


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
NSString * const TRRegistUrl = @"http://localhost:8080/TRHouse/regist";
/*** 登录的接口 */
NSString * const TRLoginUrl = @"http://localhost:8080/TRHouse/login";

/*** 忘记密码的接口 */
NSString * const TRForgetPwd = @"http://localhost:8080/TRHouse/changePwd";

/*** 查询用户是否存在的接口 */
NSString * const TRGetUserUrl = @"http://localhost:8080/TRHouse/getUser";






/* ============================ 首页 相关============================*/
/*** 首页新品推荐的接口 */
NSString * const TRGetNewRoomUrl = @"http://localhost:8080/TRHouse/getNewRoom";

/*** 首页轮播推荐的接口 */
NSString * const TRGetRecommendedRoomUrl = @"http://localhost:8080/TRHouse/getRecommendedRoom";

/*** 首页热门的接口 */
NSString * const TRGetHotRoomUrl = @"http://localhost:8080/TRHouse/getHotRoom";

/*** 首页精选的接口 */
NSString * const TRGetSelectRoomUrl = @"http://localhost:8080/TRHouse/getSelectRoom";







/* ============================ 互动模块 相关============================*/

/*** 获取所有互动的接口 */
NSString * const TRGetAllInteractiveUrl = @"http://localhost:8080/TRHouse/getAllInteractive";

/*** 发互动的接口 */
NSString * const TRComposeInteractiveUrl = @"http://localhost:8080/TRHouse/interactiveting";

/**
 *  获取互动评论的接口
 */
NSString * const TRGetAllInteractiveCommentsUrl = @"http://localhost:8080/TRHouse/getInteractiveComment";

/*** 发互动评论的接口 */
NSString * const TRSendInteractiveCommentUrl = @"http://localhost:8080/TRHouse/sendInteractiveComment";






/* ============================ 发现模块 相关============================*/
/*** 旅游攻略的接口 */
NSString * const TRTourUrl = @"https://lvyou.baidu.com/notes/";
NSString * const TRNewsUrl = @"http://www.4908.cn/";
NSString * const TRHappyUrl =  @"http://www.gxdxw.cn/";

/*** 发邻居圈的接口 */
NSString * const TRFoundSentPostUrl = @"http://localhost:8080/TRHouse/postings";

/*** 点赞的接口 */
NSString * const TRLikeUrl = @"http://localhost:8080/TRHouse/like";

/*** 获取临居圈的数据的接口 */ //localhost:8080  192.168.61.79
NSString * const TRGetAllPostsUrl = @"http://localhost:8080/TRHouse/getAllPost";








/* ============================ 我的模块 相关============================*/

/*** 获取我的帖子的数据的接口 */
NSString * const TRGetMePostsUrl = @"http://localhost:8080/TRHouse/getMePosts";

/*** 获取我的互动的数据的接口 */
NSString * const TRGetMeHomeInteractive = @"http://localhost:8080/TRHouse/getMeHomeInteractive";

/*** 修改昵称的接口 */
NSString * const TRChangeUserNameUrl = @"http://localhost:8080/TRHouse/updateUserName";

/*** 修改头像的接口 */
NSString * const TRChangeIconUrl = @"http://localhost:8080/TRHouse/updateIcon";


/*** 修改密码的接口 */
NSString * const TRChangeTheOldPwd = @"http://localhost:8080/TRHouse/modifyThePwd";

/*** 意见反馈的接口 */
NSString * const TRFeedbackPwd = @"http://localhost:8080/TRHouse/feedback";


/*** 获取别人发来的一拍即合请求的接口 */
NSString * const TRGetMeInteractiveUrl = @"http://localhost:8080/TRHouse/getMeInteractive";

/*** 获取个人资料的接口 */
NSString * const TRGetPersonalUrl = @"http://localhost:8080/TRHouse/getPersonal";

/*** 获取一拍即合内容的接口 */
NSString * const TRGetInteractiveUrl = @"http://localhost:8080/TRHouse/getInteractive";




















