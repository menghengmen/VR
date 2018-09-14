//
//  AppDelegate.m
//  MaDongFrame
//
//  Created by 码动 on 16/10/8.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "WXApi.h"
#import "loginViewController.h"
#import "UMSocialWechatHandler.h"
#import "AppDelegate+UMeng.h"
#import "AppDelegate+VersionControl.h"
#import "AppDelegate+NotificationCenter.h"
@interface AppDelegate ()
<UITabBarControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    
    //这句代码会让AvoidCrash生效，若没有如下代码，则AvoidCrash就不起作用

     [AvoidCrash becomeEffective];
    //自动登录
    
    loginViewController  * LOGIN = [loginViewController new];
    [LOGIN BGLogin:^{
        
    }];
    //向微信注册应用。
    
    [WXApi registerApp:URL_WECHAT_APPID withDescription:@"Wechat"];
    [self deployUMeng];
    [self addObserver];
    [self versionControl];
    

    [self getAllAddress];
    [self getAllDictionary];
    [self getAllUniversity];
    
    
    self.window.rootViewController = [[MainTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    [NSThread sleepForTimeInterval:2.0];

//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(statusApprence:) name:STATUS_APPRENCE object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(statusDismiss:) name:STATUS_DISMISS object:nil];
    
//    NSMutableArray  * data=   [XDCommonTool queryDataWithID:@"tsbq" withType:@"allDictionary.plist"];
//    LRLog(@"查询的城市为%@",data);
   
    
    [UMSocialData setAppKey:@"5837a86eaed1790d84002b05"];

    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105771689" appKey:@"751LFvyUV3Yb7H4V" url:@"http://www.blinroom.com/"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx045c28961f2d7114" appSecret:@"d72115ebf935060a5e509bd7353c5edf" url:@"http://www.blinroom.com/"];
    
    //键盘设置（无需设置，直接编译即可）
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = false;
    manager.preventShowingBottomBlankSpace = true;
    
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    /*! @brief 处理微信通过URL启动App时传递的数据
     *
     * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
     * @param url 微信启动第三方应用时传递过来的URL
     * @param delegate  WXApiDelegate对象，用来接收微信触发的消息。
     * @return 成功返回YES，失败返回NO。
     */
    //   BOOL  qqbool =  [ CommonTool readBoolFromUserDefaultWithKey:@"qqLogin"];
    //    if (qqbool==YES) {
    //        return  NO;
    //    }
    //    else{
    // return [WXApi handleOpenURL:url delegate:self];
    
    //}
    
    
    switch (_m_ShareType) {
        case Share_PYQuan:
        case Share_WeChat:
        {
            return [WXApi handleOpenURL:url delegate:self];
        }
            break;
        case Share_QQFriend:
        case Share_QQZone:
        {
            return [TencentOAuth HandleOpenURL:url];
        }
            break;
        case Share_WeiBo:
        {
            //return [WeiboSDK handleOpenURL:url delegate:self];
            return [TencentOAuth HandleOpenURL:url];
        }
            break;
        default:
            break;
    }
    return [TencentOAuth HandleOpenURL:url];
    
    
    
}
# pragma mark -
# pragma mark 得到所有地址信息
- (void)getAllAddress{
    [[NetworkClient sharedClient] POST:URL_ALL_ADDRESS dict:nil succeed:^(id data) {
       BOOL  success=   [XDCommonTool writeFileToSandBoxWithFileName:@"allAddress.plist" withData:data];
        if (success) {
            LRLog(@"写入成功");
        }
        else{
            LRLog(@"写入失败");

        }
    
          } failure:^(NSError *error) {
        
    }];
    
    
}
# pragma mark -
# pragma mark 得到所有配置项
- (void)getAllDictionary{

    [[NetworkClient sharedClient] POST:URL_Dictionary dict:nil succeed:^(id data) {
//        LRLog(@"配置项信息为%@",data);
        BOOL  success=   [XDCommonTool writeFileToSandBoxWithFileName:@"allDictionary.plist" withData:data];
        if (success) {
            LRLog(@"写入成功");
            [XYToolCategory readSettingInfoFromLocalFileAndSave];
        }
        else{
            
            LRLog(@"写入失败");
            
        }
    
    } failure:^(NSError *error) {
        
    }];
}

# pragma mark -
# pragma mark 得到所有大学
- (void)getAllUniversity{
  [[NetworkClient sharedClient] POST:URL_UNIVERSITYLIST dict:nil succeed:^(id data) {
//      LRLog(@"%@",data);
      BOOL  success=   [XDCommonTool writeFileToSandBoxWithFileName:@"allUniversity.plist" withData:data];
      if (success) {
          LRLog(@"写入成功");
      }
      else{
          LRLog(@"写入失败");
          
      }
  
  
  } failure:^(NSError *error) {
      LRLog(@"%@",error);
  }];



}

#pragma mark- 根据设备获取 自定义fontSize
- (CGFloat)fontSize{
    if (CGSizeEqualToSize(self.window.frame.size, CGSizeMake(320, 480))) {
        _fontSize = 15.0;
    }else if (CGSizeEqualToSize(self.window.frame.size, CGSizeMake(320, 568))){
        _fontSize = 16.0;
    }else if (CGSizeEqualToSize(self.window.frame.size, CGSizeMake(375, 667))){
        _fontSize = 17.0;
    }else if (CGSizeEqualToSize(self.window.frame.size, CGSizeMake(414, 736))){
        _fontSize = 20.0;
    }
    
    return _fontSize;
}

-(void)statusApprence:(NSNotification *)obj{
    NSDictionary *dict = obj.object;
    NSString *str = dict[@"str"];
    double delay = [dict[@"time"] doubleValue];
    [[XYCustomStatusbar sharedStatusBar]showStatusWithString:str delayInSeconds:delay];
}

-(void)statusDismiss:(NSNotification *)obj{
    [[XYCustomStatusbar sharedStatusBar]hiddenStatusBar];
}
/*! 微信回调，不管是登录还是分享成功与否，都是走这个方法 @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp{
    NSLog(@"resp %d",resp.errCode);
    
    /*
     enum  WXErrCode {
     WXSuccess           = 0,    成功
     WXErrCodeCommon     = -1,  普通错误类型
     WXErrCodeUserCancel = -2,    用户点击取消并返回
     WXErrCodeSentFail   = -3,   发送失败
     WXErrCodeAuthDeny   = -4,    授权失败
     WXErrCodeUnsupport  = -5,   微信不支持
     };
     */
    if ([resp isKindOfClass:[SendAuthResp class]]) {   //授权登录的类。
        if (resp.errCode == 0) {  //成功。
            SendAuthResp *resp2 = (SendAuthResp *)resp;
            
            //通知
            // [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_WECHATSUC object:self];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_WECHATSUC object:nil userInfo:@{@"code":resp2.code}];
            //这里处理回调的方法 。 通过代理吧对应的登录消息传送过去。
            if ([_wxDelegate respondsToSelector:@selector(loginSuccessByCode:)]) {
                SendAuthResp *resp2 = (SendAuthResp *)resp;
            }
        }else{ //失败
            NSLog(@"error %@",resp.errStr);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:[NSString stringWithFormat:@"reason : %@",resp.errStr] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
}
@end
