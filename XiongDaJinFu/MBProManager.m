//
//  MBProManager.m
//  GameTalk
//
//  Created by Wang Li on 14-10-28.
//  Copyright (c) 2014年 Wang Li. All rights reserved.
//

#import "MBProManager.h"
static MBProManager *    s_MBProManager = nil;
@implementation MBProManager
{
    MBProgressHUD           * _malMBHud;
}
- (void)dealloc
{
    
}

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_MBProManager = [[MBProManager alloc] init];
    });
    return s_MBProManager;
}


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
          containerView:(UIView *)view
{
    MBProgressHUD* tMBHud = [[MBProgressHUD alloc] initWithView:view];
    tMBHud.mode = MBProgressHUDModeText;
    tMBHud.labelText = title;
    tMBHud.detailsLabelText =content;
    tMBHud.delegate = self;
    [view addSubview:tMBHud];
    [tMBHud show:YES];
    [tMBHud hide:YES afterDelay:dissTime];
}

/**
 *显示一个加载提示
 @Param  content 内容
 @Param  title  标题
 @Param  view 承载的视图
 */
-(void) showHubHotWheels:(NSString*) content
               titleText:(NSString*) title
           containerView:(UIView *)view {
    [self hideHub];
    _malMBHud = [[MBProgressHUD alloc] initWithView:view];
    _malMBHud.mode = MBProgressHUDModeIndeterminate;
    _malMBHud.labelText = title;
    _malMBHud.detailsLabelText =content;
    _malMBHud.delegate = self;
    [view addSubview:_malMBHud];
    [_malMBHud show:YES];
}

/**
 *延时加载一个风火轮
 @Param  content 内容
 @Param  title  标题
 @Param  view 承载的视图
 */
-(void) showHubDelayHotWheels:(NSString*) content
                    titleText:(NSString*) title
                containerView:(UIView *)view
                     AferTime:(float) dissTime {
    MBProgressHUD* tMBHud = [[MBProgressHUD alloc] initWithView:view];
    tMBHud.alpha = 0;
    tMBHud.backgroundColor = [UIColor clearColor];
    tMBHud.mode = MBProgressHUDModeText;
    tMBHud.labelText = title;
    tMBHud.detailsLabelText =content;
    tMBHud.delegate = self;
    [view addSubview:tMBHud];
    [tMBHud show:YES];
    [tMBHud hide:YES afterDelay:0.3];
}

/**
 *显示一个加载提示
 @Param  content 内容
 @Param  title  标题
 @Param  view 承载的视图
 */
-(void) showHubActive:(NSString*) content
              titleText:(NSString*) title
          containerView:(UIView *)view
{
    [self hideHub];
    _malMBHud = [[MBProgressHUD alloc] initWithView:view];
    _malMBHud.mode = MBProgressHUDModeIndeterminate;
    _malMBHud.labelText = title;
    _malMBHud.detailsLabelText =content;
    _malMBHud.delegate = self;
    [view addSubview:_malMBHud];
    [_malMBHud show:YES];
}

-(MBProgressHUD*)GetHubView
{
    return _malMBHud;
}

/**
 * 手动消失HUB
 * @Param
 * @Return
 */
-(void) hideHub
{
    if (_malMBHud != nil) {
        @synchronized(s_MBProManager){
            [_malMBHud removeFromSuperview];
            [_malMBHud hide:YES];
            _malMBHud = nil;
        }
    }
}


#pragma mark-
#pragma mark MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    hud = nil;
}
@end
