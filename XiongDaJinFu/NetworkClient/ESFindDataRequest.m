//
//  ESFindDataRequest.m
//  Essential-New
//
//  Created by 奕赏 on 16/6/2.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import "ESFindDataRequest.h"
#import "ESNetworkAgent.h"
@implementation ESFindDataRequest
- (void)getColumnCategoryWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail {
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"articleGroup/queryGroupList" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,error);
    }];
}


- (void)getColumnListWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail {
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"article/queryArticleList" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,error);
    }];
}

- (void)getArticleRelateGoods:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail {
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"article/queryRelationProductList" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,error);
    }];
}

- (void)getArticleDetail:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail {
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"article/queryArticleDetail" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,error);
    }];
}

- (void)commentArticle:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail {
    [[ESNetworkAgent sharedAgent] postAllDataFromUrl:@"articleComments/saveComment" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,error);
    }];
}

- (void)getCommentList:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail {
    [[ESNetworkAgent sharedAgent] postDataFromUrl:@"articleComments/queryCommentsByArticleId" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,error);
    }];
}

- (void)searchArticle:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail {
    [[ESNetworkAgent sharedAgent] postJsonDataFromUrl:@"article/queryArticleSearchList" requestBody:dic whileFinished:^(id jsonData) {
        success(jsonData);
    } whileFailed:^(NSString *error,NSString *errorCode) {
        fail(error,error);
    }];
}



@end
