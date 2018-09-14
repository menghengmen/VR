//
//  ESWebService.h
//  Essential-New
//
//  Created by Alex on 16/3/28.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESFindDataRequest.h"
#import "XYFlatDataRequest.h"
@interface ESWebService : NSObject

+ (instancetype)sharedWebService;

@property (strong, nonatomic) ESFindDataRequest *find;
@property (strong, nonatomic) XYFlatDataRequest *flat;

- (BOOL)reacability;
@end
