//
//  AppDelegate+NotificationCenter.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/5/22.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "AppDelegate+NotificationCenter.h"

@implementation AppDelegate (NotificationCenter)

-(void)addObserver{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userJudge:) name:USERJUDGE_NOTFITICSTION object:nil];
}

-(void)userJudge:(NSNotification *)info{
    XYUserJudgeView *view = [[NSBundle mainBundle]loadNibNamed:@"XYUserJudgeView" owner:nil options:nil][0];
    
    
    view.center = [UIApplication sharedApplication].keyWindow.center;
    XYSidePopView *side = [XYSidePopView initWithCustomView:view andBackgroundFrame:[UIApplication sharedApplication].keyWindow.frame andPopType:popTypeMid];
    side.hideWhenClickBackground = false;
    
    view.btnClickBlock = ^(NSInteger i){
        if (i == 1) {
            //退出
            [side dismissplay];
        }else if (i == 2){
            NSString *appstoreUrlString = [NSString stringWithFormat:
                                           @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",
                                           appStoreID];
            
            NSURL * url = [NSURL URLWithString:appstoreUrlString];
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
            }else{
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    };
}
@end
