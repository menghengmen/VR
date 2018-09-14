//
//  XYSettingInfoModelNew.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/5/24.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYSettingInfoChildModel;
@interface XYSettingInfoModelNew : NSObject
@property (nonatomic,strong) NSString *alias;
@property (nonatomic,strong) NSString *name_en;
@property (nonatomic,strong) NSString *name_zh;
@property (nonatomic,strong) NSArray *child;

@end

@interface XYSettingInfoChildModel : NSObject
@property (nonatomic,strong) NSString *alias;
@property (nonatomic,strong) NSString *name_en;
@property (nonatomic,strong) NSString *name_zh;
@property (nonatomic,strong) NSString *parent_id;

@end
