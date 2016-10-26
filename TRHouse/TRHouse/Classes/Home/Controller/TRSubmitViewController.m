//
//  TRSubmitViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/25.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRSubmitViewController.h"
#import "TRReservation.h"
#import "TRRoom.h"
#import "TROrderParam.h"
#import "TRAccount.h"
#import "TRAccountTool.h"
#import "GBAlipayManager.h"
#import "TRProgressTool.h"
#import "TRAccount.h"
#import "TRAccountTool.h"
#import "Utilities.h"


#define TROrderUrl @"http://localhost:8080/TRHouse/order"

@interface TRSubmitViewController ()
/**
 *  商家给房间取得名字
 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/**
 *  选择的日期和天数
 */
@property (weak, nonatomic) IBOutlet UILabel *dateStr;
/**
 *  下单用户留下的姓名
 */
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
/**
 *  下单用户留下的
 */
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;
/**
 *  总价label
 */
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLbl;

/** 总价 */
@property (nonatomic, assign) NSInteger totalPrice;

/** 订单号 */
@property (nonatomic, copy) NSString *orderNo;

@end

@implementation TRSubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kTRPayResultNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"%@", note.userInfo);
        if ([note.userInfo[@"resultStatus"] isEqualToString:@"9000"]) {
            TRLog(@"支付成功");
            //支付成功处理订单
            [self paySuccess];
            
        }else {
            [Toast makeText:@"支付失败!"];
        }
    }];
    
}
/**
 *  支付成功
 */
- (void)paySuccess {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    TRAccount *account = [TRAccountTool account];
    
    param[@"uid"] = account.uid;
    param[@"state"] = @"10001";
    param[@"orderNo"] = self.orderNo;
    self.orderNo = nil;
    
    [TRProgressTool showWithMessage:@"正在处理订单..."];
    [TRHttpTool POST:TRPaySuccessUrl parameters:param success:^(id responseObject) {
        
        NSInteger stste = [responseObject[@"state"] integerValue];
        [TRProgressTool dismiss];
        if (stste) {
            [Toast makeText:@"支付成功!"];
        }else {
            [Toast makeText:@"支付成功, 处理订单失败, 请联系客服并提供订单号!"];
        }
        
    } failure:^(NSError *error) {
        [TRProgressTool dismiss];
        [Toast makeText:@"支付成功, 处理订单失败, 请联系客服并提供订单号!"];
    }];

}

/**
 *  初始化ui
 */
- (void)setupUI{
    //设置名字
    self.name.text = self.reser.room.describes;
    
    //时间
    self.dateStr.text = [NSString stringWithFormat:@"%@入住, %@离店 共%zd晚", self.reser.firstDateStr, self.reser.lastDateStr, self.reser.days];
    //计算总价
    self.totalPrice = self.reser.room.price * self.reser.days;
    self.totalPriceLbl.text = [NSString stringWithFormat:@"%zd", self.totalPrice];
}

/**
 *  发起支付
 */
- (IBAction)pay {
    
    
    if (!(self.userNameTextField.text.length > 0) && !(self.contactTextField.text.length > 0)) {
        [Utilities popUpAlertViewWithMsg:@"请将信息填写完整" andTitle:@"温馨提示"];
        return;
    }
    
    //生成15位随机订单号
    
    NSString *orderNo = [GBAlipayManager generateTradeNO];
    self.orderNo = orderNo;
    TRAccount *account = [TRAccountTool account];
    
    TROrderParam *param = [[TROrderParam alloc] init];
    param.orderNo = orderNo;
    param.userName = self.userNameTextField.text;
    param.contact = self.contactTextField.text;
    param.userId = account.uid;
    param.totalPrice = self.totalPrice;
    param.roomId = self.reser.room.ID;
    
    [TRProgressTool showWithMessage:@"正在加载..."];
    
    [TRHttpTool POST:TROrderUrl parameters:param.mj_keyValues success:^(id responseObject) {
        [TRProgressTool dismiss];
        
        NSInteger state = [responseObject[@"state"] integerValue];
        
        if (state) {
            //订单生成成功
            //开始支付
            [self paymentOrder:param];
        }else {
            [Toast makeText:@"订单提交失败, 请重新提交"];
        }
        
    } failure:^(NSError *error) {
        [Toast makeText:@"订单提交失败, 请检查网络连接!"];
    }];
    
}

/**
 *  开始支付
 */
- (void)paymentOrder:(TROrderParam *)param{
    
    [GBAlipayManager alipayWithProductName:self.reser.room.describes amount:@"0.01" tradeNO:param.orderNo notifyURL:@"JSHAlipay2016" productDescription:@"预定房间" itBPay:@"30"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
