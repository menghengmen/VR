//
//  XYCommentModel.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/29.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYCommentPicModel,XYCommentObjectModel;
@interface XYCommentModel : NSObject
@property (nonatomic,strong) NSString *commentId;
@property (nonatomic,strong) NSString *comment;//评价方
@property (nonatomic,strong) XYCommentObjectModel *comment_obj;//评价方对象(目前为用户对象,包含字段:id,nick_name,name,icon,level)
@property (nonatomic,strong) NSString *content;//评价内容
@property (nonatomic,strong) NSString *commented;//被评价方
@property (nonatomic,strong) NSString *type;//评价类型，1=评价房源
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSString *created_time;//
@property (nonatomic,assign) CGFloat cellHeight;
@end

@interface XYCommentObjectModel : NSObject
@property (nonatomic,strong) NSString *commentId;//
@property (nonatomic,strong) NSString *nick_name;//
@property (nonatomic,strong) NSString *name;//
@property (nonatomic,strong) NSString *icon;//
@property (nonatomic,strong) NSString *level;//
@end

@interface XYCommentPicModel :NSObject
@property (nonatomic,strong) NSString *url;
@end
