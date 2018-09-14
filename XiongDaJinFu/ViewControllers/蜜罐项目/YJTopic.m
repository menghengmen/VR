//
//  YJTopic.m
//  WalkTogether2
//
//  Created by boding on 15/7/21.
//  Copyright (c) 2015年 GYJ. All rights reserved.
//

#import "YJTopic.h"

@implementation YJTopic
+(instancetype)topicWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc]initWithDictionary:dictionary];
}
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.myId =  value;
    }
    else if([key isEqualToString:@"images"])
    {
    
        NSString *str = value;
        self.imageArr = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    }

}
@end
