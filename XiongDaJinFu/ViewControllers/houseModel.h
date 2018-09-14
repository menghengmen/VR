//
//  houseModel.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/10.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface houseModel : NSObject



@property(nonatomic,copy)  NSString  * address;

@property(nonatomic,copy)  NSString  * currency;

@property  (assign,nonatomic) NSNumber*  hot;

@property  (assign,nonatomic) NSNumber*  ID;

@property(nonatomic,copy)  NSString  * intro_zh;
@property(nonatomic,copy)  NSString  * intro_en;

@property(nonatomic,copy)  NSString  * name;

@property  (assign,nonatomic) NSNumber*  order;
@property  (assign,nonatomic) NSNumber*  provider_id;
@property(nonatomic,copy)  NSString  * title_image;


//address = 22222;
//currency = 3;
//hot = 0;
//id = 1;
//"intro_en" = 333;
//"intro_zh" = 1;
//name = "19 Pitt Street";
//order = 0;
//"provider_id" = 0;
//"title_image" = 222222;




@end
