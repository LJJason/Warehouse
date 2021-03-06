//
//  TRPersonalSettingTableViewController.m
//  TRHouse
//
//  Created by wgf on 16/10/20.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRPersonalSettingTableViewController.h"
#import "TRPersonal.h"
#import "TRChangeUserNameViewController.h"
#import "TRGetPersonalParam.h"
#import "TRAccountTool.h"
#import "TRAccount.h"
#import "Utilities.h"
#import <AVFoundation/AVFoundation.h>
#import "TRUploadTool.h"
#import "TRProgressTool.h"

@interface TRPersonalSettingTableViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *userName;

/** 个人模型 */
@property (nonatomic, strong) TRPersonal *personal;


/** 头像 */
@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation TRPersonalSettingTableViewController

- (NSMutableArray *)images {
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
}

- (void)setupNav{
    self.navigationItem.title = @"修改个人资料";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"返回";
    self.navigationItem.backBarButtonItem = item;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //获取头像数据
    [self loadIconAndUserName];
    
}

- (void)loadIconAndUserName {
    TRGetPersonalParam *param = [[TRGetPersonalParam alloc] init];
    TRAccount *account = [TRAccountTool account];
    param.uid = account.uid;
    
    [TRHttpTool GET:TRGetPersonalUrl parameters:param.mj_keyValues success:^(id responseObject) {
        self.personal = [TRPersonal mj_objectWithKeyValues:responseObject];
        
        [self setupIconAndUserName];
    } failure:^(NSError *error) {
        
        [Toast makeText:@"请检查网络连接!!"];
        
    }];
}

- (void)setupIconAndUserName{
    //设置头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.personal.icon] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置昵称
    self.userName.text = self.personal.userName;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    id destinationViewController = segue.destinationViewController;
    if ([destinationViewController isKindOfClass:[TRChangeUserNameViewController class]]) {
        TRChangeUserNameViewController *userNameVc = destinationViewController;
        userNameVc.userName = self.personal.userName;
    }
    
}

- (IBAction)changeIcon {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"从相册选择照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相册
        [self setupImagePickControllerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        BOOL isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (!isCameraSupport) {
            [Utilities popUpAlertViewWithMsg:@"相机不可用" andTitle:nil];
            return;
        }
        //相机
        [self setupImagePickControllerWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setupImagePickControllerWithType:(UIImagePickerControllerSourceType)sourceType{
    
    
//    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
//    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
//        [Utilities popUpAlertViewWithMsg:@"应用相机权限受限,请在设置中启用" andTitle:nil];
//        return;
//    }
    
    
    UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
    imagepicker.navigationBar.barTintColor = TRColor(0, 220, 255, 1.0);
    imagepicker.sourceType = sourceType;
    
    
    imagepicker.allowsEditing = YES;
    //设置拍照时的下方的工具栏是否显示，如果需要自定义拍摄界面，则可把该工具栏隐藏
    //    imagepicker.showsCameraControls  = YES;
    
    imagepicker.delegate = self;
    
    [self presentViewController:imagepicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    //获取图片裁剪的图
    UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.images addObject:edit];
    [self changeIconImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeIconImage
{
    
    [TRProgressTool showWithMessage:@"正在提交..."];
    //上房间照片
    [TRUploadTool uploadMoreImage:self.images success:^(NSArray *imagePath) {
        
        if (imagePath.count < self.images.count) {
            
            [TRProgressTool dismiss];
            [Toast makeText:@"提交失败!!请检查网络连接"];
            
        }else {
            //存储头像信息
            [self saveDataWith:imagePath];
        }
    }];
}

- (void)saveDataWith:(NSArray *)imagePath{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    TRAccount *account = [TRAccountTool account];
    param[@"uid"] = account.uid;
    param[@"icon"] = [imagePath componentsJoinedByString:@","];
    
    //存储信息
    [TRHttpTool POST:TRChangeIconUrl parameters:param success:^(id responseObject) {
        [TRProgressTool dismiss];
        
        NSInteger state = [responseObject[@"state"] integerValue];
        
        if (state == 1) {
            [Toast makeText:@"修改成功!"];
            [self loadIconAndUserName];
        }else {
            [Toast makeText:@"提交失败!!请检查网络连接!"];
        }
        
    } failure:^(NSError *error) {
        [TRProgressTool dismiss];
        [Toast makeText:@"提交失败!!请检查网络连接!"];
    }];
}

@end
