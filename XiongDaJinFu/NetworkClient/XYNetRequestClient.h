//
//  XYNetRequestClient.h
//  testDemo
//
//  Created by XYCoder on 2017/5/3.
//  Copyright © 2017年 威威孙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYNetRequestClient : NSObject
+(instancetype)sharedNetWork;

- (void)postTextDataFromUrl:(NSString*)url requestBody:(NSDictionary*)dict whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed;

- (void)postDataFromUrl:(NSString*)url requestBody:(NSDictionary*)dict whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed;
@end
