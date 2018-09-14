//
//  XYFlatDataRequest.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/15.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYFlatDataRequest.h"
#import "ESNetworkAgent.h"

@implementation XYFlatDataRequest

-(void)getFlatListWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"apartment/get" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
}

-(void)getFlatDetailWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:[NSString stringWithFormat: @"apartment/get/%@",dic[@"apartment_id"] ] requestBody:nil whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
    
}

-(void)getHourseDetailWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:[NSString stringWithFormat: @"house/get/%@",dic[@"house_id"] ] requestBody:nil whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
    
}

- (void)getHourseListWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"house/get" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
}

- (void)getCommentListWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"base/getComment" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
}

-(void)addCommentWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"base/addComment" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
}


/**
 向七牛服务器上传图片
 
 @param dic 上传的参数
 @param progress 上传的进度
 @param success 成功
 @param fail 失败
 */
-(void)uploadImagesToQiNiuWithParameter:(NSArray *)imagesArray type:(XYUploadFileType)type progress:(QNUpProgressHandler)progress success:(FinishedBlock)success failure:(FailedBlock)fail{
    //获取token
    NSString *fileType = [NSString string];
    if (type == XYUploadFileTypeAvatar) {//头像
        fileType = @"avatar";
    }else if (type == XYUploadFileTypeCommentImage){//评论图片
        fileType = @"comment_image";
    }
    NSString *url =[NSString stringWithFormat:@"base/qiniu/upToken/%@",fileType];
    //
    
    [[ESNetworkAgent sharedAgent] postDataFromUrl:url requestBody:nil whileFinished:^(id jsonData) {
        NSString *token = jsonData[@"up_token"];//token
        //        NSString *bucket = jsonData[@"bucket"];//上传的空间名
        NSString *baseUrl = jsonData[@"base_url"];//上传路径
        NSString *host = jsonData[@"bucket_host"];//空间域名
        
        //上传七牛
        NSMutableArray *imagesData = [self getImagesDataWithImagesArray:imagesArray];
        NSMutableArray *resposeArray = [NSMutableArray array];
        //        NSInteger count = 0;
        for (int i = 0; i<imagesData.count; i++) {
            //            count ++;
            [self uploadFile:imagesData[i] fileName:baseUrl index:i token:token success:^(NSString *key) {
                NSString *urlStr = [NSString stringWithFormat:@"%@%@",host,key];
                [resposeArray addObject:urlStr];
                if (resposeArray.count == imagesData.count) {
                    //排序
                    
                    success([self detailImagesNameWithIndex:resposeArray]);
                }
            } error:^(NSString *error,NSString *errorCode) {
                fail(error,errorCode);
            }];
            
        }
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
}

-(NSArray *)detailImagesNameWithIndex:(NSArray *)images{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<images.count; i++) {
        [arr addObject:@"."];
    }
    
    for (NSString *str in images) {
        NSInteger index = [[str substringWithRange:NSMakeRange(str.length - 5, 1)] integerValue];
        [arr replaceObjectAtIndex:index withObject:str];
    }
    return arr;
}

-(NSMutableArray *)getImagesDataWithImagesArray:(NSArray *)images{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<images.count; i++) {
        UIImage *image = images[i];
        NSData *imageData = UIImagePNGRepresentation(image);
        [arr addObject:imageData];
    }
    return arr;
}

-(void)uploadFile:(NSData *)data fileName:(NSString *)filename index:(NSInteger)index token:(NSString *)token success:(uploadImageSuccess)url error:(uploadImageFailed)error{
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@%@%@%ld.png",filename, str,[NSString createRandomString:10],index];
    [upManager putData:data key:fileName token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  //                  NSLog(@"info:%@", info);
                  //                  NSLog(@"resp:%@", resp);
                  //                  NSLog(@"key:%@", key);
                  url(key);
              } option:nil];
}

- (void)addLikeParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"base/addLike" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
}

- (void)deleteLikeParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:[NSString stringWithFormat:@"base/delLike/%@",dic[@"like_id"]] requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
}

- (void)searchUnivWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"base/getUniv" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
}

- (void)telePhoneScheduleWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"base/addConsult" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
}

- (void)addConsultWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"order/add" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
}

- (void)delCommentWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:[NSString stringWithFormat: @"base/delComment/%@",dic[@"comment_id"]] requestBody:nil whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
}

- (void)getVersionWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"edition/selectEditionById" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
}

- (void)deleteOrderWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail{
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"/order/del" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,errorCode);
    }];
}
@end
