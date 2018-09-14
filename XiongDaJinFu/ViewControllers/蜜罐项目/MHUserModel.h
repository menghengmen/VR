//
//  MHUserModel.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/2/22.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHUserModel : NSObject
@property (nonatomic,copy)   NSString *avatar_url;

@property (nonatomic,copy)   NSString *nickname;

@property (nonatomic,strong) NSNumber *ID;

@property (nonatomic,copy)   NSString *reg_type;
@end
