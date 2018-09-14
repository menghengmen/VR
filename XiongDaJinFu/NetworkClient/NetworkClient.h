//
//  LoginViewController.h
//  MaDongFrame
//
//  Created by 码动 on 16/10/8.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "SAReachabilityManager.h"
typedef void (^networkCompletionBlock)(id obj, NSError *error);

@interface NetworkClient : AFHTTPSessionManager



+ (instancetype)sharedClient;


//meng封装的网络请求方法
- (void)POST:(NSString *)URLString dict:(id)dict succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure;

- (void)GET:(NSString *)URLString dict:(id)dict succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure;

/**
 *  第三方账号相关
 *
 *  @param USERid     openID
 *  @param name       昵称
 *  @param imageUrlStr     头像
 *  @param type          类型
 */


+ (void)thirdLoginWithUserID:(NSString*)USERid withNickName:(NSString*)name withImage:(NSString*)imageUrlStr  withUserNameType:(NSNumber*)type;

/**
 *  七牛上传图片
 *
 *  @param baseUrlString 上传的根路径
 *  @param bucketStr    文件夹名
 *  @param tokenStr     上传凭证
 *  @param localUrl      图片你的本地路径
 *  @return return NSMutableArray 上传成功后的地址
 */

//- (NSString*)uploadImagesWithBaseUrl:(NSString*)baseUrlString  withLocalUrl:(NSString*)localUrl Bucket:(NSString*)bucketStr token:(NSString*)tokenStr;
@end
