//
//  XYDeployInfoModel.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/31.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYDeployInfoChildModel;
@interface XYDeployInfoModel : NSObject
@property (nonatomic,strong) NSString *alias;//
@property (nonatomic,strong) NSString *name_en;//
@property (nonatomic,strong) NSString *name_zh;//
@property (nonatomic,strong) NSArray *child;//
@end

@interface XYDeployInfoChildModel : NSObject
@property (nonatomic,strong) NSString *alias;//
@property (nonatomic,strong) NSString *name_en;//
@property (nonatomic,strong) NSString *name_zh;//
@property (nonatomic,strong) NSString *parent_id;//
@end
