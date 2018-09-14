//
//  YJTopic.h
//  WalkTogether2
//
//  Created by boding on 15/7/21.
//  Copyright (c) 2015年 GYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJTopic : NSObject
@property (nonatomic, copy) NSString *entrytype;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *myId;
@property (nonatomic, copy) NSString *entryid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *creatorid;
@property (nonatomic, copy) NSString *creatorhead;
@property (nonatomic, copy) NSString *praise;
@property (nonatomic, copy) NSString *ismine;
@property (nonatomic, copy) NSString *creatorname;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic,copy)NSString *ispraised;
+(instancetype)topicWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
