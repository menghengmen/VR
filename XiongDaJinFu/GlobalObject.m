//
//  GlobalObject.m
//  XiongDaJinFu
//
//  Created by gary on 16/12/1.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import "GlobalObject.h"

@implementation GlobalObject
static  GlobalObject * mPointer = nil;
+ (id)shareInstance{

    if (mPointer == nil) {
        mPointer = [[GlobalObject alloc] init];
    }

    return mPointer;


}
+ (void)destroy
{
    if (mPointer) {
        mPointer = nil;
    }
}

- (id)init{

    if (self == [super init]) {
       
        _networkStatus = AFNetworkReachabilityStatusReachableViaWiFi;

        
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    self.isWiFiwork = YES;
                    break;
                default:
                    self.isWiFiwork = NO;
                    break;
            }
        }];
    }

    return self;

}


@end
