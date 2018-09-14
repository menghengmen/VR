//
//  XYNetRequestClient.m
//  testDemo
//
//  Created by XYCoder on 2017/5/3.
//  Copyright © 2017年 威威孙. All rights reserved.
//

#import "XYNetRequestClient.h"

#define baseUrl @"https://zhibo.1ying.com.cn"
//网络调用
//typedef void (^FinishedBlock)(id jsonData);
//typedef void (^FailedBlock) (NSString *error);

@implementation XYNetRequestClient
{
    AFHTTPSessionManager *_manager;
}
+(instancetype)sharedNetWork{
    static XYNetRequestClient *request;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[XYNetRequestClient alloc]init];
    });
    return request;
}

-(instancetype)init{
    if (self = [super init]) {
        _manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kEssentialBaseUrl]];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html", nil];
        //设置超时时间
        _manager.requestSerializer.timeoutInterval = 10.0f;
    }
    return self;
}

- (void)postTextDataFromUrl:(NSString*)url requestBody:(NSDictionary*)dict whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed
{
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html", nil];
    [_manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error.localizedDescription,[NSString stringWithFormat:@"%ld",error.code]);
    }];
}

- (void)postDataFromUrl:(NSString*)url requestBody:(NSDictionary*)dict whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed
{
    [_manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error.localizedDescription,[NSString stringWithFormat:@"%ld",error.code]);
    }];
}
@end
