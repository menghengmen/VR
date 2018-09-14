//
//  MHContentModel.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/2/22.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHContentModel : NSObject
@property(nonatomic,copy)  NSString  * identify;

@property(nonatomic,copy)  NSString  * imageBase;

@property(nonatomic,strong)  NSArray  * images;
@property(nonatomic,copy)  NSString  * text;


@end
