//
//  orderModel.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/17.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "apartmentModel.h"
@interface orderModel : NSObject
@property(nonatomic,assign)  NSNumber  * type;

@property(nonatomic,assign)  NSNumber  * client_id;

@property(nonatomic,assign)  NSNumber  * commodity_id;
@property(nonatomic,copy)  NSString  * created_date;
@property(nonatomic,assign)  NSNumber  * ID;
@property(nonatomic,copy)  NSString  * image;

@property(nonatomic,copy)  NSString  * name;
@property(nonatomic,strong)  NSString  * order_no;
@property(nonatomic,strong)  apartmentModel  * apartment_house_type;
@property(nonatomic,strong)  apartmentModel  * house;

@end
