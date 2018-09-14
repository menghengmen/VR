//
//  XYFlatDataRequest.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/15.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYFlatDataRequest : NSObject

/**
 *  获取公寓列表信息
 */
- (void)getFlatListWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;

//公寓详情
-(void)getFlatDetailWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;
//住宅详情
-(void)getHourseDetailWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;

/**
 *  获取住宅列表信息
 */
- (void)getHourseListWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;

/**
 *  获取评论列表
 */
- (void)getCommentListWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;


/**
 向七牛服务器上传图片
 */
-(void)uploadImagesToQiNiuWithParameter:(NSArray *)imagesArray type:(XYUploadFileType)type progress:(QNUpProgressHandler)progress success:(FinishedBlock)success failure:(FailedBlock)fail;


/**
 提交评论
 
 @param dic 参数
 @param success 成功
 @param fail 失败
 */
-(void)addCommentWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;



/**
 添加收藏
 
 @param dic 参数
 @param success 成功
 @param fail 失败
 */
- (void)addLikeParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;


/**
 取消收藏
 
 @param dic 参数
 @param success 成功
 @param fail 失败
 */
- (void)deleteLikeParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;

/**
 根据城市搜索大学
 
 @param dic 参数
 @param success 成功
 @param fail 失败
 */
- (void)searchUnivWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;



/**
 电话咨询
 
 @param dic 参数
 @param success 成功
 @param fail 失败
 */
- (void)telePhoneScheduleWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;


/**
 预定
 
 @param dic 参数
 @param success 成功
 @param fail 失败
 */
- (void)addConsultWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;

/**
 删除评论
 
 @param dic 参数
 @param success 成功
 @param fail 失败
 */
- (void)delCommentWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;


/**
 获取版本信息

 @param dic 参数
 @param success 成功
 @param fail 失败
 */
- (void)getVersionWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;


/**
 取消订单

 @param dic 参数
 @param success 成功
 @param fail 失败
 */
- (void)deleteOrderWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;
@end
