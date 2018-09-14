//
//  XYAddressModel.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/6.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYAddressModel : NSObject
@property (nonatomic,strong) NSString *addressId;
@property (nonatomic,strong) NSString *hot;
@property (nonatomic,strong) NSString *lat;
@property (nonatomic,strong) NSString *lng;
@property (nonatomic,strong) NSString *name_en;
@property (nonatomic,strong) NSString *name_zh;
@property (nonatomic,strong) NSString *parent_id;
@property (nonatomic,assign) BOOL isSelectSection;//是否是选中的组
@property (nonatomic,strong) NSArray *univs;//大学
@property (nonatomic,assign) NSInteger tag;//按钮的tag

@end

@interface XYUnivModel : NSObject
@property (nonatomic,strong) NSString *address;//
@property (nonatomic,strong) NSString *address_id;//
@property (nonatomic,strong) NSString *univId;//
@property (nonatomic,strong) NSString *lat;//
@property (nonatomic,strong) NSString *lng;//
@property (nonatomic,strong) NSString *name_en;//
@property (nonatomic,strong) NSString *name_zh;//
@property (nonatomic,strong) NSString *title_image;
@property (nonatomic,assign) BOOL isSelected;
@end
