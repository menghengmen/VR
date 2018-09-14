//
//  ESConst.h
//  Essential
//
//  Created by Alex on 16/1/25.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
//网络调用
typedef void (^FinishedBlock)(id jsonData);
typedef void (^FailedBlock) (NSString *error,NSString *errorCode);
typedef void (^ProgressBlock)();
typedef void (^uploadImageFailed)(NSString *error,NSString *errorCode);
typedef void (^uploadImageSuccess)(NSString *key);

typedef NS_ENUM(NSInteger,XYHourseType) {
    XYHourseTypeFlat = 1, ///<国际公寓
    XYHourseTypeResidence, ///<海外住宅
    XYHourseTypeUniversity
};

typedef NS_ENUM(NSInteger,XYSiftCondition) {
    XYSiftConditionCity = 1,///<城市
    XYSiftConditionUniversity,///<大学
    XYSiftConditionPrice ///<价格
};

typedef NS_ENUM(NSInteger,ESPayResult) {
    ESPayResultSuccess =1,
    ESPayResultFail
};

//三种刷新操作
typedef NS_ENUM(NSInteger, ESRefreshType) {
    ESRefreshTypeFirst = 0,
    ESRefreshTypePullDown,
    ESRefreshTypePullUp
};

typedef NS_ENUM(NSInteger,XYUploadingStatus) {
    XYUploadingStatusEmpty = 1,///<什么都没有做
    XYUploadingStatusUploading,///<加载中
    XYUploadingStatusSuccess,///<加载成功
    XYUploadingStatusFailed///<加载失败
};

typedef NS_ENUM(NSInteger,XYPhonesType) {
    XYPhonesTypeFullVideos = 1,//全景视频
    XYPhonesTypeFullImage,//全景图
    XYPhonesTypeImage//普通图片
};

/** 通用间隙10 */
extern const CGFloat kMarginFifteen;
/** 通用间隙5 */
extern const CGFloat kMarginFive;
/** 顶部导航栏和状态栏高度 */
extern const CGFloat kTopNavHeight;
/** 底部tabBar高度 */
extern const CGFloat kBottomTabHeight;
/** 动画事件 */
extern const NSTimeInterval kAnimateTime;
// 社区文本字体大小
extern const CGFloat CommunityTextHeight;
//社区评论字体大小
extern const CGFloat CommunityCommentTextHeight;
extern const NSString *h5BaseUrl;
//extern const NSString *h5BaseUrlOld;
/** 导航栏下头部的高度 */
extern const CGFloat kTitleToolViewHeight;
/** 过滤tableView的宽度 */
extern const CGFloat kFilterTableViewWidth;
/** 添加购物车商品发送通知 */
extern NSString *const kShopcartDidAddGoodNotification;

/** 选择优惠券之后修改订单金额通知 */
extern NSString *const SELECOUPONCHANGORDERPRICE;
/** 是否有地址的通知 */
extern NSString *const HASADDRESSBOTFICATION;

/** 红色十六进制 */
extern const long kRedHex;
/** 蓝色十六进制 */
extern const long kBlueHex;
/** 绿色十六进制 */
extern const long kGreenHex;
/** 导航栏文字大小 */
extern const NSInteger kNavTextFontNumber;

extern const long kBottomViewDividerColorHex;
/** 支付完成回调通知*/
extern NSString *const PayFinishBlockNotfication;

//JSPatch
extern NSString *const kJSPatchAppKey;

//微信
extern NSString *const kWXAppID;
extern NSString *const kWXAppScrect;
extern NSString *const kWXPartnerKey;

//友盟
extern NSString *const kUMUrl;
extern NSString *const kUMengAppKey;

//微博
extern NSString *const kWBAppKey;
extern NSString *const kWBSecrect;
extern NSString *const kWBRefirectURL;

//腾讯
extern NSString *const kQQAppID;
extern NSString *const kQQappKey;

//支付
extern NSString *const kUnionPayScheme;///< 银联配置
extern NSString *const kUnionPayModel;///< 银联支付模式(测试还是生产)
extern NSString *const kAliPayScheme;///< 支付宝配置

//JPush
extern NSString *const kJPushAppKey;
extern NSString *const kJPushChannel;

/*************************** Notification ************************************/

//环信推送
extern NSString *const kHyPush;

extern NSString *const kESUserInfoChangeNotification;   ///< 用户信息修改
extern NSString *const kESNetworkReachabilityTrue;;     ///< 有网
extern NSString *const kESNetworkReachabilityFalse;     ///< 没网
extern NSString *const kESGetPushMsgNotification;       ///< 接到远程推送

/*****************************************************************************/

//Base URL
extern NSString *const KImageBaseUrl;
extern NSString *const kEssentialBaseUrl;

//咨询QQ号
extern NSString *const consultQQ;

extern NSString *const appStoreID;

//社区图片默认图
extern NSString *const comPlaceImageName;

extern NSString *const userSettingInfoKey;
