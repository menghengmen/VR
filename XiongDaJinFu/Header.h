//
//  Header.h
//  XiongDaJinFu
//
//  Created by gary on 16/12/1.
//  Copyright © 2016年 digirun. All rights reserved.
//




#import "SDCycleScrollView.h"
#import "SDPhotoBrowser.h"
#import "MJRefresh.h"
#import "JCTagView.h"
#import "SelectLabelView.h"
#import "UIView+SLExtension.h"
#import "MBProgressHUD+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "UIButton+Extension.h"
#import "UIImage+Extension.h"
#import "UIColor+Extension.h"
#import "UILabel+Extension.h"
#import "UIView+Extension.h"
#import "UIButton+ImageTitleSpacing.h"
#import "NSString+Extension.h"
#import "UIViewController+BackButtonHandler.h"
#import "UIViewController+Extension.h"
#import "UITableView+Wave.h"
#import <YYModel.h>
#import "NSDictionary+Extension.h"
#import "MJExtension.h"
#import "UMSocial.h"
#import "NSString+STRegex.h"
#import "NSDictionary+Extension.h"
#import "XiongDaJinFu-Swift.h"
#import "NSArray+Extension.h"
#import "UMSocialQQHandler.h"
#import "YJPickerKeyBoard.h"
#import "UIImageView+WebCache.h"
#import "UIImage+WebP.h"
#import <UMMobClick/MobClick.h>
#import "UMengViewController.h"
#import "UMengTableViewController.h"
#import "MHCountDownButton.h"
#import "UIButton+ImageViewTitle.h"
#import "UIButton+ImageTitleSpacing.h"
#import "AvoidCrash.h"
#import "TDAlertView.h"
#import "XYSidePopView.h"
#import "HTY360PlayerVC.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import <IQKeyboardManager.h>
#import "mhLabel.h"
#import "PhotoManager.h"
#import "parentViewController.h"
#import "XYToolCategory.h"

typedef enum{
    Share_PYQuan,
    Share_WeChat,
    Share_WeiBo,
    Share_QQZone,
    Share_QQFriend
}Share_Type;


typedef NS_ENUM(NSInteger,XYUploadFileType) {
    XYUploadFileTypeAvatar = 1,
    XYUploadFileTypeCommentImage
};
//全景播放器相关
#define FIRSTPLAY @"firstPlay"
#define FIRSTDOUBLE @"firstDoubleScreen"
#define USINGMOTION @"usingMotion"
#define DOUBLESCREEN @"doubleScreen"

//第三方绑定成功
#define BOUND_SUC @"BOUNDSUCCESS"
//
#define kGoTopNotificationName  @"goToTop"
#define kLeaveTopNotificationName  @"goToLeave"


//微信授权成功
#define LOGIN_WECHATSUC @"loginwechatSuc"   //微信授权登录成功
//微信开发者ID
#define URL_WECHAT_APPID @"wx045c28961f2d7114"
#define URL_WECHAT_APPSECRET @"beeaefe8eafd1cdbe52c962ff7837e2b"
//注册的时候提交信息
#define REGISTERSAVEMESSAGE @"registerSaveMessage"

//第三方登录成功
#define THIRD_LOGIN_SUC @"thirdLoginSuccess"
//用户信息
#define USER_INFO @"userInfo"
#define QINIU    @"qiNiuUpload"
#define IS_LOGIN  @"isLogin"
//是否是第三方登录
#define IS_THIRD_LOGIN  @"isThirdLogin"
//登录失效
#define   LOGIN_EXPIRE @"login_expire"
//退出成功
#define   LOGINOUT_SUCCESS @"loginout_success"

//cook信息
#define   COOKIES @"cookieDict"

#define   kLocalCookieName     @"MyProjectCookie";

#define   kLocalUserData       @"MyProjectLocalUser";
#define   kServerSessionCookie @"JSESSIONID";

#define   CODESUCCESS  @"code_success"


//全局
#define   GlobalUrl @"http://118.178.188.77:8089/blinroom_serve_war/"
//测试
//#define  GlobalUrl      @"http://192.168.31.162:8080/"
//本地
//#define  GlobalUrl      @"http://192.168.31.162:8080/"
#define    GlobalImageUrl @"http://admin.blinroom.com"
//配置项
#define    URL_Dictionary           (  GlobalUrl     "base/getDictionary")
//所有地址信息
#define    URL_ALL_ADDRESS          (  GlobalUrl     "base/getAddress")

//首页
#define    URL_HOMEDATA             (  GlobalUrl     "aggregate/homePage")

//评论

#define    URL_COMMENT              (  GlobalUrl     "base/getComment")
//大学列表
#define    URL_UNIVERSITYLIST       (  GlobalUrl     "base/getUniv")
//国际公寓列表

#define    URL_APARTMENTLIST        (  GlobalUrl     "apartment/get")
//公寓房型-查询
#define    URL_APARTMENTHOUSETYPE   (  GlobalUrl     "apartment/getHouseType")
//添加咨询信息
#define    URL_ASKINFOMATION        (  GlobalUrl     "base/addConsult")

//获取评价
#define    URL_GETCOMMENT           (  GlobalUrl     "base/getComment")


//添加评价
#define    URL_ADDCOMMENT           (  GlobalUrl     "base/addComment")


//海外住宅列表

#define    URL_HOUSELIST            (  GlobalUrl     "house/get")
//用户登录
#define    URL_LOGIN                (  GlobalUrl     "user/login")
//用户注册
#define    URL_REGISTER             (  GlobalUrl     "user/register")
//发送验证码
#define    URL_SENDERCODE           (  GlobalUrl     "user/sendSms")
#define    URL_SENDERMAILCODE       (  GlobalUrl     "user/sendEmail")
//校验验证码
#define    URL_JUDGECODE            (  GlobalUrl     "user/checkPhoneOrEmail")

#define    URL_UPDATEPHONEORMAIL    (  GlobalUrl     "user/updatePhoneOrEmail")




//第三方注册

#define    URL_THIRDREGISTER        (  GlobalUrl     "user/thirdRegister")
//用户修改信息

#define    URL_UPDATEINFO           (  GlobalUrl     "user/update")
//用户信息详情

#define    URL_USERINFO             (  GlobalUrl     "user/get")


#define    URL_FORGETPASSWORD       (  GlobalUrl   "user/forgetPassword")

//绑定
#define    URL_BOUND                (  GlobalUrl     "user/updateBinding")

//绑定
#define    URL_UNBOUND              (  GlobalUrl     "user/removeBind")
//退出登录
#define    URL_LOGOUT               (  GlobalUrl     "user/logout")

//我的订单
#define    URL_MYORDER              (  GlobalUrl     "order/get")

//我的收藏
#define    URL_MYCOLLECTION         (  GlobalUrl     "base/getLike")

//删除收藏
#define    URL_DeleCOLLECTION       (  GlobalUrl     "base/delLike")

//状态栏显示的通知
#define STATUS_APPRENCE @"statusApprence"
//状态栏消失的通知
#define STATUS_DISMISS @"statusDisMiss"
#define USERJUDGE_NOTFITICSTION @"userJudgeNotification"

//用户评价
#define UserJudgeCount @"userJudgeCount"



