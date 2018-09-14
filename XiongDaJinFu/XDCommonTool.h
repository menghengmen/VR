//
//  XDCommonTool.h
//  XiongDaJinFu
//
//  Created by gary on 16/12/1.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDCommonTool : NSObject


+ (void)goToMain;

/**
 *  正则表达式检验手机号
 */
+ (BOOL)checkTel:(NSString *)str;
/**
 *  正则表达式检验邮箱
 */
+(BOOL)checkEmail:(NSString *)email;


/**
 *  保存BOOL型数据到UserDefault
 */
+ (void)saveToUserDefaultWithBool:(BOOL)value key:(NSString *)key;

/**
 *  从UserDefault读取BOOL型数据
 */
+ (BOOL)readBoolFromUserDefaultWithKey:(NSString *)key;

/**
 *  保存NSString型数据到UserDefault
 */
+ (void)saveToUserDefaultWithString:(NSString *)value key:(NSString *)key;

/**
 *  从UserDefault读取NSString型数据
 */
+ (NSString *)readStringFromUserDefaultWithKey:(NSString *)key;

/**
 *  保存dictionary型数据到UserDefault
 */
+ (void)saveToUserDefaultWithDic:(NSDictionary *)value key:(NSString *)key;

/**
 *  从UserDefault读取dictionary型数据
 */
+ (NSDictionary *)readDicFromUserDefaultWithKey:(NSString *)key;

/**
 *  删除某个存储的元素
 */
+ (void)removeIdForKey:(NSString *)key;


/**
 *  根据相应信息弹出一个AlertView，适合点击按钮后不采取其他操作的情况
 */
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sure;

/**
 *  判断是否登录
 */
+ (BOOL)isLogin;

/**
 *  tabBar高度
 */
+ (CGFloat)tabBarHeight;

/**
 *  拼接URL
 */

+ (NSString *)getURLStringWithString:(NSString *)aString;

/**
 * 改变时间格式
 */
+(NSString *)getDateFormatterWithDate:(NSDate *)date;
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

+(NSString *)changeDate:(NSDate *)date withFormatter:(NSString *)format;
+(NSDate *)getNow;
+(NSString*)getFromDateString:(NSString *)string withStringFormatter:(NSString *)format andchangeFormat:(NSString *)aimFormat;
+(NSDate*)getDateFromString:(NSString*)dateStr;


/*提示*/
+(void)alertWithMessage:(NSString *)message;


+(void)alertWithMessage:(NSString *)message withLittleMessage:(NSString*)littleMessage;


/*获取模型中某一字段的数组*/
+(NSMutableArray *)getArrayWithKey:(NSString *)key fromArray:(NSMutableArray *)array;


+(void)showMessage:(NSString *)message inView:(UIView *)view;


//md5加密字符串
+ (NSString *)md5:(NSString *)str;
+(NSString*) escapedStringAll:(NSString*)unescaped;

+(float)fileSizeAtPath:(NSString *)path;
//计算目录大小

+(float)folderSizeAtPath:(NSString *)path;//清理缓存文件

//同样也是利用NSFileManager API进行文件操作，SDWebImage框架自己实现了清理缓存操作，我们可以直接调用。

//清楚缓存
+(void)clearCache:(NSString *)path;
//判断网络状态
+ (void)reachability;




//拿到本地文件的路径
+(NSString *)getFilePath:(NSString *)fileName;



/**
 *  文件写入沙盒
 *
 *  @param fileName   文件名
 *  @param data       要写入的数据
 *  @return return bool 是否写入成功
 */
+ (BOOL)writeFileToSandBoxWithFileName:(NSString*)fileName  withData:(id)object;
/**
 *  根据id查询沙盒中的数据<配置项和地址信息>

 *
 *  @param    cityIdStr 城市的id
 *  @param    typeStr 文件的名字 (城市或大学的区分)
 *  @return   NSMutableArray 查询的数据
 */
+ (NSMutableArray*)queryDataWithID:(NSString*)cityIdStr withType:(NSString*)typeStr;

/**
 *  根据id查询沙盒中的数据<大学>
 
 *
 *  @param    cityIdStr 大学的id或者名字
 *  @param    type   type=id查大学名字
 *  @return   NSMutableArray 查询的数据
 */

+ (NSMutableArray*)queryUniversityDataWithID:(NSString*)universityIdStr withType:(NSString*)type;
//同上
+(NSMutableArray*)queryPeiZhiWithKey:(NSString*)key withIdOrName:(NSString*)name  withType:(NSString*)type;



/**
 *  取本地配置项
 *
 *  @param fileName   文件名
 *  @param keyStr    主键
 *  @return  NSMutableArray 取到的配置项
 */
+ (NSMutableArray*)getPeiZhiWithFileName:(NSString*)fileName keyStr:(NSString*)keyStr;


/**
 根据key获取本地配置项对应的数组

 @param key key
 @return 本地配置项对应的数组
 */
+(NSArray *)getSettingInfoWithKey:(NSString *)key;


+(NSString *)getDictValueWithSectionKey:(NSString *)key andKey:(NSString *)key1;

/****************************一些常用控件的封装************************/
//一般自定义btn
+ (UIButton *)newButtonWithType:(UIButtonType)type normalImage:(NSString *)imageName  buttonTitle:(NSString*)btnTitle target:(id)target action:(SEL)action;
//纯色btn
+ (UIButton *)newButtonWithType:(UIButtonType)type target:(id)target action:(SEL)action;
//带Frame的button
+ (UIButton *)newButtonWithType:(UIButtonType)type  frame:(CGRect)frame normalImage:(NSString *)imageName  buttonTitle:(NSString*)btnTitle target:(id)target action:(SEL)action;
+(UIImageView *)newImageViewWithName:(NSString *)imageName;

+ (UITextField *)newTextFieldWithStyle:(UITextBorderStyle)style   withPlaceHolder:(NSString *)placeHolderStr withKeyBoardType:(UIKeyboardType)type withFont:(UIFont*)font;
+(UILabel *)newlabelWithTextColor:(UIColor*)color withTitle:(NSString*)title  fontSize:(CGFloat)theSize;
//第三方账号相关
//注册
+ (void)thirdRegisterWithUserID:(NSString*)USERid withNickName:(NSString*)name withImage:(NSString*)imageUrlStr  withUserNameType:(NSNumber*)type;

+(void) requestWeChatInfo:(void (^)(NSDictionary* tJsonDic))success
                     fail:(void (^)(NSDictionary* tJsonDic))failure
                     code:(NSString*)code;

/**
 * 微信拿昵称(接上面) -----私有
 * @Param
 * @Return
 */
+(void) requestWeChatUserInfo:(void (^)(NSDictionary* tJsonDic))success
                         fail:(void (^)(NSDictionary* tJsonDic))failure
                  accesstoken:(NSString*)accesstoken
                       openid:(NSString*)openid;


/**
 *  绑定第三方账户
 *
 *  @param clientIdStr   当前登录账户
 *  @param openIdSt    第三方账户的openID
 *  @return
 */

+(void)boundWithID:(NSString*)clientIdStr  openId:(NSString*)openIdSt nickName:(NSString*)nickNameStr type:(NSString*)typeStr;

//筛选
+(NSArray *)searchWithFieldArray:(NSArray *)fieldArray
                      inputString:(NSString *)inputString
                          inArray:(NSArray *)array;

/**
 *  发送验证码
 *
 *  @param phoneStr      邮箱或者手机
 *  @param type          类型 1：注册 0：非注册
 *  @return
 */
+(void)SendMessageWithPhoneOrMail:(NSString*)phoneStr  withType:(NSNumber*)type;
@end
