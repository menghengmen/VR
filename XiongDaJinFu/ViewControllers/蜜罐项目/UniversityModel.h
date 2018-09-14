//
//  UniversityModel.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/10.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "fullImageModel.h"
#import "UniversityVideos.h"
#import "universityTitleImage.h"
@interface UniversityModel : NSObject

@property  (assign,nonatomic) NSNumber*  address_id;
@property  (copy,nonatomic) NSString*  ID;
@property(nonatomic,copy)  NSString  * images;

@property(nonatomic,copy)  NSString  * intro_zh;

@property(nonatomic,copy)  NSString  * lat;

@property(nonatomic,copy)  NSString  * lng;
@property(nonatomic,copy)  NSString  * name_en;
@property(nonatomic,copy)  NSString  * name_zh;
@property(nonatomic,copy)  NSString  * title_image;

@property(nonatomic,strong)  NSArray  * full_shot_images;
@property(nonatomic,strong)  NSArray  * videos;

@end
