//
//  ESFindDataRequest.h
//  Essential-New
//
//  Created by 奕赏 on 16/6/2.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESFindDataRequest : NSObject
//@property (strong, nonatomic) NSString *header;
/**
 *  获取 专栏 列表
 */
- (void)getColumnListWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;

/**
 *  获取专栏分类
 */
- (void)getColumnCategoryWithParameter:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;


/**
 *  获取文章相关商品
 */
- (void)getArticleRelateGoods:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;

/**
 *  获取文章相关信息
 */
- (void)getArticleDetail:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;

/**
 *  评论/回复评论
 */

- (void)commentArticle:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;
/**
 *  获取文章全部评论
 */
- (void)getCommentList:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;
/**
 *  搜索文章
 */
- (void)searchArticle:(NSDictionary *)dic success:(FinishedBlock)success failure:(FailedBlock)fail;

/**
 *  相关商品
 */

@end
