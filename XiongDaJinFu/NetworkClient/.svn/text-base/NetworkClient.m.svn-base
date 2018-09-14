//
//  NetworkClient.m
//  MiaoZhu
//
//  Created by 码动 on 16/6/30.
//  Copyright © 2016年 码动. All rights reserved.
//

#import "NetworkClient.h"
#import "Reachability.h"
#import "NSData+Base64.h"
#import "LoginViewController.h"

@implementation NetworkClient

+ (instancetype)sharedClient{
    static NetworkClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *cofig=[NSURLSessionConfiguration defaultSessionConfiguration];
        // [cofig setHTTPAdditionalHeaders:nil];
        NSURLCache *cache=[[NSURLCache alloc]initWithMemoryCapacity:10 * 1024 * 1024
                                                       diskCapacity:50 * 1024 * 1024
                                                           diskPath:nil];
        [cofig setURLCache:cache];
        sharedClient = [[NetworkClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_API_URL]sessionConfiguration:cofig];
        sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return sharedClient;
}
#pragma mark -登录相关
//登录
- (void)loginWithPhoneNumber:(NSString *)phonenum
                withPassword:(NSString *)password
         withCompletionBlock:(networkCompletionBlock)block {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:phonenum forKey:@"phone_num"];
    [parameters setObject:password forKey:@"password"];
  
    [self POST2:@"Login/login" parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"state"] intValue] == 0) {
            NSString *message=[responseObject objectForKey:@"msg"];
            NSError *error = [NSError errorWithDomain:message code:0 userInfo:responseObject];
            NSLog(@"登录失败%@",responseObject);
            block(nil, error);
        } else {
            NSLog(@"登录成功%@",responseObject);
            block(responseObject, nil);
        }
    } failure:^(NSURLSessionTask *task, NSError *error) {
        if (block) {
            block (nil, error);
            NSLog(@"%@",[error.userInfo objectForKey:@"NSLocalizedDescription"]);
            
        }
    }];
}


//get方法
- (NSURLSessionTask *)GET2:(NSString *)URLString
                parameters:(id)parameters
                   success:(void (^)(NSURLSessionTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionTask *task, NSError *error))failure {
    //先判断网络状态
    GlobalObject  * globalObject = [GlobalObject shareInstance];
    
    if (globalObject.networkStatus== AFNetworkReachabilityStatusNotReachable) {
        [XDCommonTool alertWithMessage:@"无网络连接，请检查设置"];
        return   nil;
    
    }
    
    
    
    NSData *data=[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str=[data base64EncodedString];
    
    
    NSMutableDictionary *baseParameters = [[NSMutableDictionary alloc] init];
    [baseParameters setObject:str forKey:@"mz"];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    NSMutableString *mutableString = [NSMutableString stringWithFormat:@"%@%@", BASE_API_URL, URLString];
    NSURLSessionTask *task=[manager GET:mutableString parameters:baseParameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        return success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *erDic =  [NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"msg"];
        NSError *msgError = [NSError errorWithDomain:[error localizedDescription] code:0 userInfo:erDic];
        NSLog(@"GET请求失败%@",[error.userInfo objectForKey:@"NSLocalizedDescription"]);
        
        return failure (nil, msgError);
        
        
    }];
    return task;
    
}

//post方法
- (NSURLSessionTask *)POST2:(NSString *)URLString
                 parameters:(id)parameters
                    success:(void (^)(NSURLSessionTask *task, id responseObject))success
                    failure:(void (^)(NSURLSessionTask *task, NSError *error))failure {
    
    NSString *deviceId = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceID"];
    

    
    NSData *data=[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str=[data base64EncodedString];
    
    
    NSMutableDictionary *baseParameters = [[NSMutableDictionary alloc] init];
    [baseParameters setObject:str forKey:@"mz"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    //
    NSMutableString *mutableString = [NSMutableString stringWithFormat:@"%@%@", BASE_API_URL, URLString];
    //
    NSURLSessionTask *task = [manager POST:mutableString parameters:baseParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
        } progress:^(NSProgress * _Nonnull uploadProgress) {
    
    
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"成功!");

            return success(task,responseObject);
    
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSDictionary *erDic =  [NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"msg"];
            NSError *msgError = [NSError errorWithDomain:[error localizedDescription] code:0 userInfo:erDic];
            NSLog(@"POST请求失败%@",[error.userInfo objectForKey:@"NSLocalizedDescription"]);
            
            return failure (nil, msgError);
    
        }];
    
    return task;

}

/**************meng封装的网络请求方法******************************************/
-(void)POST:(NSString *)URLString dict:(id)dict succeed:(void (^)(id))succeed failure:(void (^)(NSError *))failure{
    
    //创建网络请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html", nil];
    
    
    //发送网络请求(请求方式为POST)
    [manager POST:URLString parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeed(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}
-(void)GET:(NSString *)URLString dict:(id)dict succeed:(void (^)(id))succeed failure:(void (^)(NSError *))failure{
    
    //创建网络请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",@"image/png",@"text/javascript",nil];
    //发送网络请求(请求方式为GET)
    [manager GET:URLString parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeed(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
    
}

@end
