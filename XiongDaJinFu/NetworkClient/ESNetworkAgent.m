//
//  ESNetworkAgent.m
//  Essential-New
//
//  Created by Alex on 16/3/28.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import "ESNetworkAgent.h"
#import "NSString+Extension.h"
//#import <AFNetworking.h>
//#import "ESLibTool.h"
//#import "ESNoWifiView.h"
//#import "NSData+Extension.h"

@implementation ESNetworkAgent {
    AFHTTPSessionManager* _manager;
}
static ESNetworkAgent* _agent;

+ (instancetype)sharedAgent
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _agent = [[ESNetworkAgent alloc] init];
        
        AFNetworkReachabilityManager *networkreachabiltiy = [AFNetworkReachabilityManager sharedManager];
        [networkreachabiltiy setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                    [[NSNotificationCenter defaultCenter] postNotificationName:kESNetworkReachabilityTrue object:nil userInfo:nil];
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN | AFNetworkReachabilityStatusReachableViaWiFi | AFNetworkReachabilityStatusUnknown:
                    [[NSNotificationCenter defaultCenter] postNotificationName:kESNetworkReachabilityTrue object:nil userInfo:nil];
                    break;
                default:
                    break;
            }
        }];
        
        [networkreachabiltiy startMonitoring];
    });
    return _agent;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //创建网络请求管理对象
        _manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kEssentialBaseUrl]];
        //申明返回的结果是json类型
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/html或别的
//         _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html", nil];
        //设置超时时间
        _manager.requestSerializer.timeoutInterval = 10.0f;
    }
    return self;
}

- (void)getDataFromUrl:(NSString*)url parameter:(NSDictionary*)dict whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed
{
    if (![self checkoutNetwork]) {
        return;
    }
    _manager = [[AFHTTPSessionManager alloc]init];
    [_manager GET:url parameters:nil progress:^(NSProgress* _Nonnull downloadProgress) {

    }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            NSInteger code = ((NSNumber*)[responseObject objectForKey:@"success"]).integerValue;
            if (code != 1) {
                failed(responseObject[@"error_msg"],[NSString stringWithFormat:@"%ld",[[responseObject objectForKey:@"error_code"] integerValue]]);
                return;
            }
            if (![responseObject[@"result"] isKindOfClass:[NSNull class]]) {
                finished(responseObject[@"result"]);
            }
            else {
                finished(@"");
            }

        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {

            NSString* error1 = error.localizedDescription;
            failed(error1,[NSString stringWithFormat:@"%ld",error.code]);

        }];
}

- (void)postDataFromUrl:(NSString*)url requestBody:(NSDictionary*)dict whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed
{
    if (![self checkoutNetwork]) {
        return;
    }
    
    [_manager POST:url parameters:dict progress:^(NSProgress* _Nonnull uploadProgress) {

    }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
//            NSData* data = (NSData*)responseObject;
//            LxDBObjectAsJson(responseObject);
//            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
            //先判断服务器返回的code是否正确
            NSInteger code = ((NSNumber*)[responseObject objectForKey:@"success"]).integerValue;
            if (code != 1) {
                failed(responseObject[@"error_msg"],[NSString stringWithFormat:@"%ld",[[responseObject objectForKey:@"error_code"] integerValue]]);
                return;
            }
            if (![responseObject[@"result"] isKindOfClass:[NSNull class]]) {
                finished(responseObject[@"result"]);
            }
            else {
                finished(@"");
            }
        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
            NSString* error1 = error.localizedDescription;
            failed(error1,[NSString stringWithFormat:@"%ld",error.code]);
        }];
}

- (void)postAllDataFromUrl:(NSString*)url requestBody:(NSDictionary*)dict whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed
{
    if (![self checkoutNetwork]) {
        return;
    }
    [_manager POST:url parameters:dict progress:^(NSProgress* _Nonnull uploadProgress) {

    }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            NSData* data = (NSData*)responseObject;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            finished(jsonObject);
        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
            NSString* error1 = error.localizedDescription;
            failed(error1,[NSString stringWithFormat:@"%ld",error.code]);
        }];
}

- (void)postJsonDataFromUrl:(NSString*)url requestBody:(id)object whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed
{
    if (![self checkoutNetwork]) {
        return;
    }
    AFHTTPSessionManager* mg = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kEssentialBaseUrl]];
    AFJSONRequestSerializer *req = [AFJSONRequestSerializer serializer];
    mg.requestSerializer = req;
    [mg.requestSerializer setTimeoutInterval:30.0];
    [mg POST:url parameters:object progress:^(NSProgress* _Nonnull uploadProgress) {
//        LxDBAnyVar(object);
    }
        success:^(NSURLSessionDataTask* _Nonnull task, NSDictionary* _Nullable responseObject) {
            //返回的responseObject是NSDictionary
            //先判断服务器返回的code是否正确
            NSInteger code = [responseObject[@"success"] integerValue];
            if (code != 1) {
                failed(responseObject[@"error_msg"],responseObject[@"error_code"]);
                return;
            }
            if (![responseObject[@"info"] isKindOfClass:[NSNull class]]) {
                finished(responseObject[@"info"]);
            }
            else {
                finished(responseObject[@"msg"]);
            }
        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
            failed(error.localizedDescription,[NSString stringWithFormat:@"%ld",error.code]);
        }];
}

- (void)postAllJsonDataFromUrl:(NSString*)url requestBody:(id)object whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed
{
    if (![self checkoutNetwork]) {
        return;
    }
    AFHTTPSessionManager* mg = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:GlobalUrl]];
    mg.requestSerializer = [AFJSONRequestSerializer serializer];
    [mg.requestSerializer setTimeoutInterval:30.0];
    [mg POST:url parameters:object progress:^(NSProgress* _Nonnull uploadProgress) {

    }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            finished(responseObject);
        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
            failed(error.localizedDescription,[NSString stringWithFormat:@"%ld",error.code]);
        }];
}

-(void)postImageWithJsonAndResponceJson:(NSString*)url requestBody:(id)object AndPicArray:(NSArray *)picArray whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed{    if (![self checkoutNetwork]) {
        return;
    }
    AFHTTPSessionManager* mg = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:GlobalUrl]];
//    mg.requestSerializer = [AFJSONRequestSerializer serializer];
    [mg.requestSerializer setTimeoutInterval:30.0];
    NSDictionary *dict =object;
    NSMutableDictionary *dict1 =[NSMutableDictionary dictionary];
    dict1[@"imgType"] =dict[@"imgType"];
    [mg POST:url parameters:dict1 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        if (picArray ==nil) {
//            
//        }else{
            if (picArray.count>0) {
                for (int i=0;i<picArray.count;i++) {
                    NSData *data =picArray[i];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    // 设置时间格式
                    formatter.dateFormat = @"yyyyMMddHHmmss";
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                    
                    //上传
                    /*
                     此方法参数
                     1. 要上传的[二进制数据]
                     2. 对应网站上[upload.php中]处理文件的[字段"file"]
                     3. 要保存在服务器上的[文件名]
                     4. 上传文件的[mimeType]
                     */
                    [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
                }
            }
//        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error.localizedDescription,[NSString stringWithFormat:@"%ld",error.code]);
    }];
}

- (BOOL)checkoutNetwork {
//    BOOL reachability = [AFNetworkReachabilityManager sharedManager].isReachable;
//    if (!reachability) {
//        [self addNoWifiView];
//        return true;
//    }
    return true;
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (void)addNoWifiView {
//    ESNoWifiView *nowifi = [[ESNoWifiView alloc] init];
//    UIViewController *viewC = [self getCurrentVC];
//    nowifi.center = CGPointMake(viewC.view.width/2, viewC.view.height/2);
//    [viewC.view addSubview:nowifi];
}

//- (void)postDataFromUrl:(NSString *)url andRequestBody:(NSMutableDictionary *)dict whileFinished:(FinishedBlock)finished failed:(FailedBlock)failed {
//
//    NSString *str = [NSString stringWithDictionary:dict];
//    NSDictionary *dic = [NSDictionary dictionaryWithObject:str forKey:@"StrTxt"];
//
//    [[ESSessionClient sharedClient] POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSData *oldData = (NSData *)responseObject;
//        NSData *data = [oldData removeXML];
//        id jsonObject =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        self.finishedBlock(jsonObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSString *error1 =error.localizedDescription;
//        self.failedBlock(error1);
//    }];
//}

@end
