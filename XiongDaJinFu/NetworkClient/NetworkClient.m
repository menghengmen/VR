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
#import "MBProManager.h"

//#import "QiniuSDK.h"
//#import "QiniuPutPolicy.h"

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

# pragma mark -
# pragma mark meng
/**************meng封装的网络请求方法******************************************/
-(void)POST:(NSString *)URLString dict:(id)dict succeed:(void (^)(id))succeed failure:(void (^)(NSError *))failure{
    
    
    
    
    //先判断网络状态
    if ([SAReachabilityManager sharedReachabilityManager].currentReachabilityStatus == NotReachable) {
        AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MBProManager* tMBManager = [MBProManager shareInstance];
        UIWindow* window = appdelegate.window;
        [tMBManager showHubAutoDiss:@"网络断开连接,请检查设置！" titleText:nil AferTime:1.5f containerView:window];
        return;
    }
      //创建网络请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
   
      manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html", nil];
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 6.0f;
    
   // [manager addValue:@"" forHTTPHeaderField:@"Cookie"];

    
    //发送网络请求(请求方式为POST)
    
    [manager POST:URLString parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        succeed(responseObject);
        
        
   
    
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);

    }];
}
-(void)GET:(NSString *)URLString dict:(id)dict succeed:(void (^)(id))succeed failure:(void (^)(NSError *))failure{
    
   
    
    //先判断网络状态
    if ([SAReachabilityManager sharedReachabilityManager].currentReachabilityStatus == NotReachable) {
        AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MBProManager* tMBManager = [MBProManager shareInstance];
        UIWindow* window = appdelegate.window;
        [tMBManager showHubAutoDiss:@"网络断开连接,请检查设置！" titleText:nil AferTime:1.5f containerView:window];
        return;
    }
    

    
    
    //创建网络请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",@"image/png",@"text/javascript",nil];
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 6.0f;
    
      [manager GET:URLString parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeed(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
}
# pragma mark -
# pragma mark 七牛上传图片
/*
- (NSString*)uploadImagesWithBaseUrl:(NSString *)baseUrlString withLocalUrl:(NSString *)localUrl Bucket:(NSString *)bucketStr token:(NSString *)tokenStr
{
    NSString  * __block urlStr = [NSString new];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    NSData *data = [NSData dataWithContentsOfFile:baseUrlString];
    
    NSString *key = [NSURL fileURLWithPath:baseUrlString].lastPathComponent;
    
    QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil
                                               progressHandler:^(NSString *key, float percent){
                                                   
                                               }
                                                        params:@{ @"x:foo":@"fooval" }
                                                      checkCrc:YES
                                            cancellationSignal:nil];
    
    
    [upManager putData:data key:key token:tokenStr
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  if (!info.error) {
                      NSString *contentURL = [NSString stringWithFormat:@"http://ok4372s5v.bkt.clouddn.com/%@",key];
                      urlStr = contentURL;
                      NSLog(@"QN Upload Success URL= %@",contentURL);
                      
                      [XDCommonTool alertWithMessage:@"图片上传成功"];
                  
                  }
                  else {
                      
                      NSLog(@"%@",info.error);
                  }
              } option:opt];


    return urlStr;

}
*/


@end
