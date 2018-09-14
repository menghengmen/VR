//
//  GlobalObject.h
//  XiongDaJinFu
//
//  Created by gary on 16/12/1.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface GlobalObject : NSObject

@property (nonatomic) BOOL isNetworkStatus;
@property (nonatomic) BOOL isWiFiwork;

@property  (nonatomic,assign)  AFNetworkReachabilityStatus networkStatus;

+ (id)shareInstance;

@end
