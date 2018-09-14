//
//  BaseViewController.m
//  WuFanBao
//
//  Created by blinroom on 16/1/29.
//  Copyright © 2016年 blinroom. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import "Reachability.h"
#import "LoginViewController.h"
#import "CustomNavigationController.h"
//#import <AlipaySDK/AlipaySDK.h>

@interface BaseViewController ()<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate,TDAlertViewDelegate>


{
    UITableViewStyle _style;
    
    
    userLoginCompletionBlock completionBlock;
}

@property (nonatomic, strong) Reachability *conn;

@end

@implementation BaseViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
  }


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
  
    //监听网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkState) name:kReachabilityChangedNotification object:nil];
    
    
    self.conn = [Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(hideKeyboard)];
    
    
    gestureRecognizer.cancelsTouchesInView = NO;
}


#pragma -mark 监听网络状态

- (void)checkNetworkState
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        NSLog(@"有wifi");
        [SVProgressHUD showInfoWithStatus:@"有wife"];

    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        NSLog(@"使用手机自带网络进行上网");
        
        [SVProgressHUD showInfoWithStatus:@"使用手机自带网络进行上网"];
    
    } else { // 没有网络
        
        [SVProgressHUD showInfoWithStatus:@"网络状态异常,请检查网络!"];
    }
}

//- (void)presentLoginViewControllerWithAnimated:(BOOL)flag
//                                    completion:(userLoginCompletionBlock)completion {
//    
//    completionBlock = completion;
//    
//    loginViewController *viewController = [[loginViewController alloc] init];
//    viewController.delegate = self;
//    viewController.modalTransitionStyle =UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:viewController animated:YES completion:nil];
//    
//}
//
////提示登录框
//
//- (void)showLoginAlert:(NSString *)msg {
//    
//    UIAlertController*alertController=[UIAlertController alertControllerWithTitle:NSLocalizedString(msg, @"") message:nil preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *oklAction=[UIAlertAction actionWithTitle:NSLocalizedString(@"去登录", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self presentLoginViewControllerWithAnimated:YES completion:^(id obj, NSError *error) {
//            
//        }];
//    }];
//    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", @"") style:UIAlertActionStyleCancel handler:nil];
//    [alertController addAction:oklAction];
//    [alertController addAction:cancleAction];
//    [self presentViewController:alertController animated:YES completion:nil];
//    
//}
//

//错误弹框

- (void)showErrorAlertWithMsg:(NSString *)msg {
    UIAlertController*alertController=[UIAlertController alertControllerWithTitle:NSLocalizedString(msg, @"") message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", @"") style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancleAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark UserLoginViewControllerDelegate
- (void)didCompletedUserLoginViewController:(UIViewController *)picker withResult:(id)data withError:(NSError *)error {
    
    if (completionBlock) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loginSuccess"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[data objectForKey:@"im_password"] forKey:@"im_password"];
        [[NSUserDefaults standardUserDefaults] setObject:[data objectForKey:@"user_id"] forKey:@"user_id"];
        [[NSUserDefaults standardUserDefaults] setObject:[data objectForKey:@"user_type"] forKey:@"user_type"];
        [[NSUserDefaults standardUserDefaults] setObject:[data objectForKey:@"phone_num"] forKey:@"phone_num"];
        
        [self exampleLoginWithUserID:[data objectForKey:@"phone_num"] password:[data objectForKey:@"im_password"] successBlock:^{
            
        } failedBlock:^(NSError *error) {
            //        [SVProgressHUD showInfoWithStatus:[error localizedDescription]];
        }];
        
        completionBlock(data, error);
    }
    
    
    
    //    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didCanceledUserLoginViewController:(UIViewController *)picker {
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loginSuccess"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"im_password"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
    //    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma -mark 登录 IM
- (void)exampleLoginWithUserID:(NSString *)aUserID password:(NSString *)aPassword successBlock:(void(^)())aSuccessBlock failedBlock:(void (^)(NSError *))aFailedBlock
{
    aSuccessBlock = [aSuccessBlock copy];
    aFailedBlock = [aFailedBlock copy];
    
}


//自适应高度/宽度


- (CGRect)getRectWithString:(NSString*)str withFont:(UIFont *)font withWidth:(CGFloat)width withHeight:(CGFloat)height {
    CGSize size =CGSizeMake(width,height);
    
    CGRect rect = [str boundingRectWithSize:size
                                    options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{NSFontAttributeName:font}
                                    context:nil];
    return rect;
}
/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}



//如果图片本身是2进制的NSData形式，那么可以判断第一个字节得出类型：
- (NSString *)typeForImageData:(NSData *)data {
    
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    
    
    switch (c) {
            
        case 0xFF:
            
            return @"jpeg";
            
        case 0x89:
            
            return @"png";
            
        case 0x47:
            
            return @"gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"tiff";
            
    }
    
    return nil;
    
}
- (id)initWithStyle:(UITableViewStyle)style {
    
    self = [super init];
    if (self) {
        _style = style;
        //_refreshHeaderViewEnabled = YES;
        //_loadMoreFooterViewEnabled = YES;
    }
    return self;
}

- (id)init {
    
    self = [super init];
    if (self) {
        //_refreshHeaderViewEnabled = YES;
        //_loadMoreFooterViewEnabled = YES;
    }
    return self;
}
//四舍五入法
- (NSInteger)rounding:(float)point {
    
    //评价需要四舍五入
    NSInteger rating = (point * 10);
    if (rating % 10 >= 5) {
        rating = rating / 10 + 1;
    } else {
        rating = point;
    }
    return rating;
}

- (NSInteger)gbk_strlen:(NSString *)text {
    
    //计算汉字的数量，然后再原有字符串长度基础上再加上汉字的数量即可
    int chinese = 0;
    for(int i = 0; i < [text length]; i++) {
        int a = [text characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fff)
            chinese++;
    }
    NSInteger length = [text length] + chinese;
    return length;
}

//判断字符串内是否仅仅包含汉字，如果是，则返回数组包含匹配的内容，不是则返回空数组
- (BOOL)textIncludeHanziOnly:(NSString *)text {
    
    if (!text) return NO;
    
    NSString *hanziOnly = @"^[\u4e00-\u9fa5]+$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:hanziOnly
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:text
                                                             options:0
                                                               range:NSMakeRange(0, [text length])];
        if (firstMatch) {
            //根据正则表达式，完全匹配成功，结果用数组返回
            return YES;
        }
    }
    return NO;
}

//判断是否是纯数字
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

#pragma UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    selectedTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    selectedTextField = nil;
}

//支付宝支付
//- (void)alipayForOrderWithOrderId:(NSString *)orderSn
//                 withSignedString:(NSString *)signedString
//                   withNotify_url:(NSString *)notify_url
//                 withProductTitle:(NSString *)productTitle
//                 withProductsName:(NSString *)productsName
//                  withOrderString:(NSString *)orderString
//                withProductsPrice:(float)productsPrice {
//    //
//    //商户的唯一的parnter和seller。
//    //本demo将parnter和seller信息存于（.plist）中
//    //签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
//    //
//    NSString *partner = PARTNER;
//    NSString *seller = SELLER;
//    
//    //partner和seller获取失败,提示
//    if ([partner length] == 0 || [seller length] == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"缺少partner或者seller。"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    
//    //生成订单信息及签名
//    //将商品信息赋予AlixPayOrder的成员变量
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.sellerID = seller;
//    order.outTradeNO = orderSn; //订单ID（由商家自行制定）
//    order.subject = productsName; //商品标题
//    order.body = productTitle; //商品描述
//    order.totalFee = [NSString stringWithFormat:@"%.2f", productsPrice]; //商品价格
//    order.notifyURL = notify_url; //回调URL
//    
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showURL = @"m.alipay.com";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于安全支付成功后重新唤起商户应用
//    NSString *appScheme = @"miaozhuAlipay";
//    
//    
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    
//    
//    
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    //    id<DataSigner> signer = CreateRSADataSigner(RSA_ALIPAY_PRIVATE);
//    //    NSString *signedString = [signer signString:orderSpec];
//    
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    //    NSString *orderString = nil;
//    if (signedString != nil) {
//        //        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//        //                       orderSpec, signedString, @"RSA"];
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            [APPDELEGATE handleAlipayResult:resultDic];
//        }];
//    }
//}



//根据RGB创建image
- (UIImage *)createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
//适配设置新的frame
- (CGRect)newSuitFrame:(CGRect)frame
{
    CGRect newFrame;
    
    newFrame.size.height = frame.size.height/SCREEN_HEIGHT_RATE;
    newFrame.size.width = frame.size.width/SCREEN_WIDTH_RATE;
    newFrame.origin.x = frame.origin.x/SCREEN_WIDTH_RATE;
    newFrame.origin.y = frame.origin.y/SCREEN_HEIGHT_RATE;
    
    return newFrame;
}

//判断是否符合电话号格式
//正则表达式
- (BOOL)textIsMobileFormat:(NSString *)text {
    
    if (!text) return NO;
    
    NSString *phoneNum = @"(^13|^15|^18|^17|^14)\\d{9}$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:phoneNum
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:text
                                                             options:0
                                                               range:NSMakeRange(0, [text length])];
        if (firstMatch) {
            //根据正则表达式，完全匹配成功，结果用数组返回
            return YES;
        }
    }
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kReachabilityChangedNotification
                                                  object:nil];
}

//自定义导航条
- (void)setUpNewNai:(NSString*)backTitle Title:(NSString*)title {
    //导航条
    UIView  * navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    navView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];

    [self.view addSubview:navView];
   
    
    //返回按钮
    UIButton  * backBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"nav_back" buttonTitle:backTitle target:self action:@selector(back)];
    [backBtn setTitle:@"     " forState:UIControlStateNormal];
    [navView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.height.equalTo(@24);
        make.left.and.equalTo(backBtn.superview).offset(10);
        make.centerY.equalTo(backBtn.superview).offset(10);
    }];
    //标题
    UILabel  * titleLabel = [XDCommonTool newlabelWithTextColor:[UIColor whiteColor] withTitle:title fontSize:18];
    [titleLabel setTextColor:[UIColor colorWithHexString:@"#333333"]];
    [navView addSubview:titleLabel];
    titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.equalTo(@19);
        make.centerX.equalTo(titleLabel.superview);
        make.centerY.equalTo(titleLabel.superview).offset(10);
        
    }];
    
    UIView  * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 63, SCREENWIDTH, 0.5)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.25;
    [self.view addSubview:bottomView];
    


}

- (void)setUpNewNai:(NSString*)backTitle Title:(NSString*)title withColor:(UIColor*)backColor{


    //导航条
    UIView  * navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    navView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    [self.view addSubview:navView];
    //返回按钮
    UIButton  * backBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"nav_back" buttonTitle:backTitle target:self action:@selector(back)];
    [navView addSubview:backBtn];
    [backBtn setTitle:@"                            " forState:UIControlStateNormal];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.height.equalTo(@24);
        make.left.and.equalTo(backBtn.superview).offset(10);
        make.centerY.equalTo(backBtn.superview).offset(10);
    }];
    //标题
    UILabel  * titleLabel = [XDCommonTool newlabelWithTextColor:[UIColor whiteColor] withTitle:title fontSize:18];
    [titleLabel setTextColor:[UIColor colorWithHexString:@"#333333"]];

    [navView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@140);
        make.height.equalTo(@19);
        make.centerX.equalTo(titleLabel.superview);
        make.centerY.equalTo(titleLabel.superview).offset(10);
        
    }];
    
    //返回按钮
    UIButton  * rightBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:nil buttonTitle:@"保存" target:self action:@selector(save)];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"#29a7e1"] forState:UIControlStateNormal];
    [rightBtn setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:15]];
    self.rightBtn = rightBtn;
    [navView addSubview:rightBtn];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@45);
        make.height.equalTo(@19);
        make.right.and.equalTo(backBtn.superview).offset(-10);
        make.centerY.equalTo(backBtn.superview).offset(10);
    }];

}


- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    //hud.dimBackground = YES;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}
-(void)alertWithMessage:(NSString *)message withLittleMessage:(NSString*)littleMessage{
    
    TDAlertItem *item1 = [[TDAlertItem alloc] initWithTitle:@"取消"];
    
    TDAlertItem *item2 = [[TDAlertItem alloc] initWithTitle:@"确定"];
    item2.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
    item2.titleColor = [UIColor colorWithHexString:@"fffefe"];
    TDAlertView *alert = [[TDAlertView alloc] initWithTitle:message message:littleMessage items:@[item1,item2] delegate:self];
     alert.hideWhenTouchBackground = NO;
    
    [alert show];
    
    
    
}
- (void)alertView:(TDAlertView *)alertView didClickItemWithIndex:(NSInteger)itemIndex{


}

@end
