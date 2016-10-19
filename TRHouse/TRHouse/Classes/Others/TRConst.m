
#import <UIKit/UIKit.h>

/*** 旅游攻略的接口 */
NSString * const TRTourUrl = @"https://lvyou.baidu.com/notes/";
NSString * const TRNewsUrl = @"http://www.4908.cn/";
NSString * const TRHappyUrl =  @"http://www.gxdxw.cn/";

/*** 获取验证码 */
NSString * const TRGetVcCodeUrl = @"http://yearwood.top/TRHouse/sendSms";

/*** 注册的接口 */
NSString * const TRRegistUrl = @"http://localhost:8080/TRHouse/regist";
/*** 登录的接口 */
NSString * const TRLoginUrl = @"http://yearwood.top/TRHouse/login";

/*** 登录的接口 */
NSString * const TRGetPersonalUrl = @"http://localhost:8080/TRHouse/getPersonal";

/*** 获取别人发来的一拍即合请求的接口 */
NSString * const TRGetMeInteractiveUrl = @"http://localhost:8080/TRHouse/getMeInteractive";


/*** 获取一拍即合内容的接口 */
NSString * const TRGetInteractiveUrl = @"http://localhost:8080/TRHouse/getInteractive";

/*** 获取所有互动的接口 */
NSString * const TRGetAllInteractiveUrl = @"http://localhost:8080/TRHouse/getAllInteractive";

/*** 获取所有互动的接口 */
NSString * const TRComposeInteractiveUrl = @"http://localhost:8080/TRHouse/interactiveting";

/*** 获取七牛token的接口 */
NSString * const TRGetTokenUrl = @"http://yearwood.top/TRMerchants/gettoken";



