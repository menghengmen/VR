//
//  UtilityManager.h
//  VideoPlay
//
//  Created by WangLi on 15/4/2.
//  Copyright (c) 2015年 WangLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define OutType 0
#define InType 1

typedef void (^UserInfoOverblock) (void);

@interface UtilityManager : NSObject

+ (id)shareInstance;
+(NSString *)giftDirectoryWithContentName:(NSString *)fileName;

/**
 * 对象转JSON STRING
 * @Param
 * @Return
 */
+(NSString*)DataTOjsonString:(id)object;

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 * 以上获取的数据可以通过以下方式进行单位转换
 * @Param
 * @Return
 */
+ (NSString*) bytesToAvaiUnit:(int )bytes;
/**
 * 2.WIFI流量统计功能 返回的结果为byte
 * @Param
 * @Return
 */
+ (long long int)getInterfaceBytes:(int )retype;
/**
 * 获得蜂窝数据下流量变化
 * @Param
 * @Return
 */
+(long long int) getGprs3GFlowIOBytes:(int)type;
/**
 * 秒数转 分'秒''
 * @Param
 * @Return
 */
+(NSString*) secondToStr:(long long)sec;
/**
 * 截取部分图像
 * @Param
 * @Return
 */
+(UIImage*)getSubImage:(CGRect)rect srcImg:(UIImage*)srcimg;
/**
 * 放缩图片
 * @Param
 * @Return
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
/**
 * 强制翻转成竖屏
 * @Param
 * @Return
 */
+(void) forceRotateToPortrait;
/**
 * 计算缓存大小
 * @Param
 * @Return
 */
+(float) caculateCacheSize:(NSArray*)folders;
/**
 * 清除缓存大小
 * @Param
 * @Return
 */
+(BOOL)cleanCache:(NSArray*)folders;

/**
 * tableView 底部的加载更多
 * @Param
 * @Return
 */
+(UIView*) tableViewMore;

/**
 * 心得动画生成一个
 * @Param
 * @Return
 */
-(UIView*)doHeartImgAnimate:(CGPoint)start;
-(void) cleanAllAnimate;
-(CAAnimationGroup*) customInitAnimate:(CGPoint)start;

/**
 * 爸爸的剪裁方式
 * @Param
 * @Return
 */
+ (UIImage *) drawSmallToSize:(UIImage *)img size:(CGRect)drawrect;
/**
 * hmacsha1 算法
 * @Param
 * @Return
 */
- (NSString *) hmacSha1:(NSString*)key text:(NSString*)text;
/**
 * 字串MD5 加密
 * @Param
 * @Return
 */
- (NSString *)md5:(NSString *)str;
/**
 * 判断是否是手机号
 * @Param
 * @Return
 */
-(BOOL) checkPhoneNum:(NSString*)phoneStr;

/**
 * 请求个人信息
 * @Param
 * @Return
 */
-(void) requestSelfInfo:(UserInfoOverblock) over;

/**
 * 检查某功能是否允许访问
 * @Param
 * @Return
 */
-(BOOL) checkIsAuthor:(NSString*)checkType;
/**
 * 获得本地的城市数组
 * @Param
 * @Return
 */
-(NSArray*)GetLocalCitysArr;
/**
 * 根据城市ID 查名字
 * @Param
 * @Return
 */
-(NSString*) cityIDQueryName:(int) cityID;
/**
 * tableView 底部的加载更多
 * @Param
 * @Return
 */
+(UIView*) tableViewMore:(int)width;
/**
 * 转码unicode 除数字和字母
 * @Param
 * @Return
 */
-(NSString*) escapedStringAll:(NSString*)unescaped;

//判断是否是http或者https链接
+ (BOOL)isHttpURL:(NSString *)urlString;

+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
+(NSString *)giftDirectoryWithContentNameByCreation:(NSString *)fileName;

/**
 * 中文转拼音
 * @Param
 * @Return
 */
+ (NSString *) phonetic:(NSString*)sourceString;

@end
