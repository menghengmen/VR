//
//  LoginViewController.h
//  MaDongFrame
//
//  Created by 码动 on 16/10/8.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void (^networkCompletionBlock)(id obj, NSError *error);

@interface NetworkClient : AFHTTPSessionManager


#pragma mark -登录相关
//登录
- (void)loginWithPhoneNumber:(NSString *)phonenum
                withPassword:(NSString *)password
     withCompletionBlock:(networkCompletionBlock)block;
//get方法
- (NSURLSessionTask *)GET2:(NSString *)URLString
                parameters:(id)parameters
                   success:(void (^)(NSURLSessionTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionTask *task, NSError *error))failure;

+ (instancetype)sharedClient;


//meng封装的网络请求方法
- (void)POST:(NSString *)URLString dict:(id)dict succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure;

- (void)GET:(NSString *)URLString dict:(id)dict succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure;

@end
