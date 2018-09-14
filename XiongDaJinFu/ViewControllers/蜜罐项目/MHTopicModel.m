//
//  MHTopicModel.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/2/21.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "MHTopicModel.h"

@implementation MHTopicModel



+ (NSArray<NSString *> *)setupDataFieldsIsModelArray:(BOOL *)isModelArray {
    return @[@"data"];
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"feeds" : [MHTopicModel class]};
}



@end
