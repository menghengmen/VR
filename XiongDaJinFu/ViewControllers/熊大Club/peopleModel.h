//
//  peopleModel.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface peopleModel : NSObject
@property(nonatomic,copy)  NSString  * be_from;
@property(nonatomic,copy)  NSString  * birthday;
@property(nonatomic,copy)  NSString  * icon;
@property(nonatomic,copy)  NSString  * major_id;
@property(nonatomic,copy)  NSString  * mobile;
@property(nonatomic,copy)  NSString  * name;
@property(nonatomic,assign)  NSNumber  * sex;
@property(nonatomic,copy)  NSString  * univ_id;
@property(nonatomic,strong)  NSArray  * label;
@property(nonatomic,copy)  NSString  * nick_name;

@end
