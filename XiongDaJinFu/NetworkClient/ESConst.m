//
//  ESConst.m
//  Essential
//
//  Created by Alex on 16/1/25.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>


const CGFloat kMarginFifteen = 15;

const CGFloat kMarginFive = 5;

const CGFloat kTopNavHeight = 64;

const CGFloat kBottomTabHeight = 49;

const NSTimeInterval kAnimateTime = 0.35;

const CGFloat CommunityTextHeight =16;
const CGFloat CommunityCommentTextHeight =14;

const CGFloat kTitleToolViewHeight = 40;

const CGFloat kFilterTableViewWidth = 160;

NSString *const kShopcartDidAddNotification = @"shopcartDidAddNotification";

const long kRedHex = 0x990000;

const long kBlueHex = 0x000033;

const long kGreenHex = 0x330000;

const long kBottomViewDividerColorHex = 0x999999;

const NSInteger kNavTextFontNumber = 16;

//JSPatch
NSString *const kJSPatchAppKey = @"4024e3509c15c1a8";

//微信1.0
//NSString *const kWXAppID = @"wxa1561d1224f9f2bd";
//NSString *const kWXAppScrect = @"d6333fdb4602c5714bfa3471df515c1e";
//NSString *const kWXPartnerKey = @"yishanxiudianzishangwushangcheng";
//微信2.0
NSString *const kWXAppID = @"wx106efe31792496c6";
NSString *const kWXAppScrect = @"87685f2ca9d54b2dceab8aad3450e989";
NSString *const kWXPartnerKey = @"yishangyishanxiunewversion123456";

//友盟
//NSString *const kUMengAppKey = @"56389d8f67e58e0b680011b6";//1.0
NSString *const kUMUrl = @"http://www.umeng.com/social";
NSString *const kUMengAppKey = @"57a83746e0f55a1359001276";//2.0

//微博1.0
//NSString *const kWBAppKey = @"3183436290";
//NSString *const kWBSecrect = @"13ab8bb678dc2c59a1f365a77af8010f";
//NSString *const kWBRefirectURL = @"http://sns.whalecloud.com/sina2/callback";
//微博2.0
NSString *const kWBAppKey = @"104974306";
NSString *const kWBSecrect = @"45d62bd12538cc30a6a990417b0758d0";
NSString *const kWBRefirectURL = @"http://sns.whalecloud.com/sina2/callback";
//腾讯1.0
//NSString *const kQQAppID = @"1104810961";
//NSString *const kQQappKey = @"KJgrIKpj8yfxjyr6";
//腾讯2.0
NSString *const kQQAppID = @"1105512065";
NSString *const kQQappKey = @"rvMMz8o1dgDLsHzH";

//银联
NSString *const kUnionPayScheme = @"YishanxiuUnionPay";
//#ifdef DEBUG
//NSString *const kUnionPayModel = @"01";
//#else 
NSString *const kUnionPayModel = @"00";
//#endif
//支付宝
NSString *const kAliPayScheme = @"YishanxiuAliPay";

//JPush
NSString *const kJPushAppKey = @"f755f66e9dbec9ba6f03799d";
NSString *const kJPushChannel = @"App Store";

//环信推送
#ifdef DEBUG
NSString *const kHyPush =@"essentialChat_developmentG";
#else
NSString *const kHyPush =@"essentialChatG";
#endif

#pragma mark - notificaion
NSString *const kESUserInfoChangeNotification = @"UserInfoChange";
NSString *const PayFinishBlockNotfication =@"payFinishBlockNotification";
NSString *const kESNetworkReachabilityTrue = @"ESNetworkReachabilityTrue";
NSString *const kESNetworkReachabilityFalse = @"ESNetworkReachabilityFalse";
NSString *const kESGetPushMsgNotification = @"ESGetPushMsgNotification";
NSString *const SELECOUPONCHANGORDERPRICE =@"SeleCouponChangeOrderPrice";
NSString *const HASADDRESSBOTFICATION =@"HASADDRESSBOTFICATION";

NSString *const KImageBaseUrl = @"http://admin.blinroom.com";

#ifdef DEBUG
//NSString *const kEssentialBaseUrl = @"http://192.168.31.162:8080/";///<学良
//NSString *const kEssentialBaseUrl = @"http://192.168.31.83:8089/";///<xintong
//NSString *const kEssentialBaseUrl = @"http://192.168.31.162:8080/";///<zhumin
NSString *const kEssentialBaseUrl = @"http://118.178.188.77:8089/blinroom_serve_war/";///<正式
//NSString *const kEssentialBaseUrl = @"http://192.168.31.175:8080/blinroom_serve_war/";///<本地
#else
//NSString *const kEssentialBaseUrl = @"http://192.168.31.162:8080/";
//NSString *const kEssentialBaseUrl = @"http://192.168.31.83:8089/";///<xintong
//NSString *const kEssentialBaseUrl = @"http://192.168.31.162:8080/";///<zhumin
NSString *const kEssentialBaseUrl = @"http://118.178.188.77:8089/blinroom_serve_war/";///<正式
//NSString *const kEssentialBaseUrl = @"http://192.168.31.175:8080/blinroom_serve_war/";///<本地
#endif

//咨询qq
NSString *const consultQQ = @"3356555739";

//appstroeID
NSString *const appStoreID = @"1181307830";

//社区图片默认图
NSString *const comPlaceImageName = @"";

//配置信息存本地的key
NSString *const userSettingInfoKey = @"userSettingInfoKey";
