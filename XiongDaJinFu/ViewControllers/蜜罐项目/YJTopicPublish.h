//
//  YJTopicPublish.h
//  WalkTogether2
//
//  Created by boding on 15/7/30.
//  Copyright (c) 2015年 GYJ. All rights reserved.
//

#import <UIKit/UIKit.h>
//import "YJProject.h"

typedef NS_ENUM(NSInteger, TopicType)
{
    //运动话题
    kSportType=0,
    //赛事话题
    kMatchType,
    //俱乐部
    kClubType,
    //圈子
    kCircleType
};

@interface YJTopicPublish : UIViewController


-(instancetype)initWithTopicType:(TopicType)type Model:(id)model;

@end
