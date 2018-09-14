//
//  apartModel.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/27.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYLikeApartmentModel;
@interface apartModel : NSObject
@property(nonatomic,copy)  NSString  * type;
@property(nonatomic,assign)  BOOL like;
@property(nonatomic,copy)  NSString  * likeId;
@property (nonatomic,strong) NSString *be_liked;
@property (nonatomic,strong) XYLikeApartmentModel *be_liked_apartment;

@end

@interface XYLikeApartmentModel:NSObject
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *address_id;
@property (nonatomic,strong) NSString *be_liked_apartment;
@property (nonatomic,strong) NSString *charge_unit;
@property (nonatomic,strong) NSString *currency;
@property (nonatomic,strong) NSArray *facility;
@property (nonatomic,strong) NSString *apartId;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSString *intro_zh;
@property (nonatomic,strong) NSArray *label;
@property (nonatomic,strong) NSString *lat;
@property (nonatomic,strong) NSString *lng;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *title_image;
@property (nonatomic,strong) NSString *date_unit;

@end

