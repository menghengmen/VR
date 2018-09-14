//
//  ESWebService.m
//  Essential-New
//
//  Created by Alex on 16/3/28.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import "ESWebService.h"
#import "AFNetworking.h"
@implementation ESWebService

+ (void)load {
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
}

+ (instancetype)sharedWebService {
    static ESWebService *_webService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _webService = [[ESWebService alloc] init];
    });
    return _webService;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _find = [[ESFindDataRequest alloc]init];
        _flat = [[XYFlatDataRequest alloc]init];
    }
    return self;
}

- (BOOL)reacability {
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

@end
