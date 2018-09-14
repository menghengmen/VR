//
//  hotHouse.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/20.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hotHouse : NSObject
@property(nonatomic,copy)  NSString  * ID;

@property(nonatomic,copy)  NSString  * address;
@property(nonatomic,copy)  NSString  * price;

@property(nonatomic,copy)  NSString  * title_image;
@property(nonatomic,copy)  NSString  * name;
@property (nonatomic,strong) NSString *date_unit;

@property(nonatomic,copy)  NSString  * charge_unit;
//货币单位
@property(nonatomic,copy)  NSString  * currency;

@end
