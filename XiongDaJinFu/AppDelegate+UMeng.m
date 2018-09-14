//
//  AppDelegate+UMeng.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/5/12.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "AppDelegate+UMeng.h"

@implementation AppDelegate (UMeng)
-(void)deployUMeng{
    //打开测试模式
    [MobClick setLogEnabled:YES];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];//版本号
    
    UMConfigInstance.appKey = @"59152b774544cb2b2b002287";
    UMConfigInstance.channelId = @"";//推广渠道，默认为App Store
//    UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    [MobClick setEncryptEnabled:true];//日志加密
    
    
}
@end
