//
//  SAReachabilityManager.h
//  SAFramework
//
//  Created by whs on 15/3/7.
//  Copyright (c) 2015年 whs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface SAReachabilityManager : NSObject {
	Reachability *internetReach;
}

@property (nonatomic, strong) Reachability *internetReach;

+ (SAReachabilityManager *)sharedReachabilityManager;

- (NetworkStatus)currentReachabilityStatus;

@end
