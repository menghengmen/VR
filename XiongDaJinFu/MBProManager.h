//
//  MBProManager.h
//  GameTalk
//
//  Created by Wang Li on 14-10-28.
//  Copyright (c) 2014年 Wang Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface MBProManager : NSObject<MBProgressHUDDelegate>
+ (id)shareInstance;

/**
 *显示一个提示X秒后消失
 @Param  content 内容
 @Param  title  标题
 @Param  dissTime 消失的秒数
 @Param  view 承载的视图
 */
-(void) showHubAutoDiss:(NSString*) content
              titleText:(NSString*) title
               AferTime:(float) dissTime
          containerView:(UIView *)view;

/**
 *显示一个加载提示
 @Param  content 内容
 @Param  title  标题
 @Param  view 承载的视图
 */
-(void) showHubActive:(NSString*) content
            titleText:(NSString*) title
        containerView:(UIView *)view;

/**
 *显示一个加载提示
 @Param  content 内容
 @Param  title  标题
 @Param  view 承载的视图
 */
-(void) showHubHotWheels:(NSString*) content
               titleText:(NSString*) title
           containerView:(UIView *)view;

/**
 *显示一个加载提示
 @Param  content 内容
 @Param  title  标题
 @Param  view 承载的视图
 */
-(void) showHubDelayHotWheels:(NSString*) content
                    titleText:(NSString*) title
                containerView:(UIView *)view
                     AferTime:(float) dissTime;

/**
 * 手动消失HUB
 * @Param
 * @Return
 */
-(void) hideHub;

-(MBProgressHUD*)GetHubView;
@end
