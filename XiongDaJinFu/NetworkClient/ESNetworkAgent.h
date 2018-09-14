//
//  ESNetworkAgent.h
//  Essential-New
//
//  Created by Alex on 16/3/28.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD+Extension.h"
//#import <YYModel.h>

@interface ESNetworkAgent : NSObject

+ (instancetype)sharedAgent;

- (void)postDataFromUrl:(NSString *)url requestBody:(NSDictionary *)dict whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed;

-(void)getDataFromUrl:(NSString *)url parameter:(NSDictionary *)dict whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed;

- (void)postAllDataFromUrl:(NSString *)url requestBody:(NSDictionary *)dict whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed;

/**
 *  post上传json数据
 */
-(void)postJsonDataFromUrl:(NSString *)url requestBody:(id)object whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed;
/**
 *  post上传json数据(返回所有数据)
 */
-(void)postAllJsonDataFromUrl:(NSString *)url requestBody:(id)object whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed;

-(void)postImageWithJsonAndResponceJson:(NSString*)url requestBody:(id)object AndPicArray:(NSArray *)picArray whileFinished:(FinishedBlock)finished whileFailed:(FailedBlock)failed;
@end
