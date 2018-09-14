//
//  city.m
//  DCWebPicScrollView
//
//  Created by room Blin on 2017/3/7.
//  Copyright © 2017年 name. All rights reserved.
//

#import "city.h"

@implementation city

@end

#pragma mark - CityGroup
@implementation CityGroup

- (NSMutableArray *) arrayCitys
{
    if (_arrayCitys == nil) {
        _arrayCitys = [[NSMutableArray alloc] init];
    }
    return _arrayCitys;
}

@end
