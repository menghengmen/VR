//
//  AppDelegate+VersionControl.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/5/12.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "AppDelegate+VersionControl.h"
#import "XYNetRequestClient.h"
#import "UIViewController+Extension.h"
@implementation AppDelegate (VersionControl)

-(void)versionControl{
    dispatch_queue_t queue = dispatch_queue_create("versionControl",DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        [self compareLocalAndAppStoreVersion];
       dispatch_async(dispatch_get_main_queue(), ^{
           
       });
    });
    
}

-(void)compareLocalAndAppStoreVersion{
    //d当前版本号
    NSString *localVersion =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [[XYNetRequestClient sharedNetWork]postDataFromUrl:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",@"1181307830"] requestBody:nil whileFinished:^(id jsonData) {
        NSString * appStoreVersion = jsonData[@"results"][0][@"version"];
        //更新文本
//        NSString *updateText =jsonData[@"results"][0][@"releaseNotes"];
        //比较当前版本和线上版本
        [self compareVersion:localVersion and:appStoreVersion];
    } whileFailed:^(NSString *error, NSString *errorCode) {
//        [MBProgressHUD showMessage:@"获取线上版本信息失败"];
        NSDictionary *versionInfo = [XDCommonTool readDicFromUserDefaultWithKey:@"versionInfo"];
        [self compareVersion:localVersion and:versionInfo[@"version_no"]];
    }];
}

-(void)compareVersion:(NSString *)localVersion and:(NSString *)appStoreVersion{
    if ([self compareVersion:localVersion andAppStore:appStoreVersion] && appStoreVersion.length>0 &&localVersion.length>0) {
        //有新版本->是否强制更新
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"version_no"] = localVersion;
        
        [[ESWebService sharedWebService].flat getVersionWithParameter:dict success:^(id jsonData) {
//            LxDBAnyVar(jsonData);
            [XDCommonTool saveToUserDefaultWithDic:jsonData key:@"versionInfo"];
            [self detailVersionInfo:jsonData];
        } failure:^(NSString *error, NSString *errorCode) {
//            [MBProgressHUD showError:@"获取强更信息失败"];
            NSDictionary *versionInfo = [XDCommonTool readDicFromUserDefaultWithKey:@"versionInfo"];
            [self detailVersionInfo:versionInfo];
        }];
        //            CFRunLoopStop(CFRunLoopGetCurrent());
    }else{
        //已是最新版本
//        [MBProgressHUD showMessage:@"当前已是最新版本"];
    }
}

-(void)detailVersionInfo:(NSDictionary *)jsonData{
    if ([jsonData[@"is_update"] boolValue] && [jsonData[@"is_prompt"] boolValue]) {//需要强更
        
        TDAlertItem *item2 = [[TDAlertItem alloc]initWithTitle:@"前往更新" andHandle:^{
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/id1181307830"];
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
            }else{
                [[UIApplication sharedApplication] openURL:url];
            }
            
            CFRunLoopStop(CFRunLoopGetCurrent());
        }];
        item2.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
        item2.titleColor = [UIColor colorWithHexString:@"fffefe"];
        TDAlertView *alert = [[TDAlertView alloc] initWithTitle:@"发现新版本" message:jsonData[@"content"] items:@[item2] delegate:self];
        alert.hideWhenTouchBackground = NO;
        [alert show];
        CFRunLoopRun();
        
//        [[UIViewController getCurrentViewController].view addSubview:alert];
    }else if(![jsonData[@"is_update"] boolValue] && [jsonData[@"is_prompt"] boolValue]){//不需要强更，但是有更新
        TDAlertItem *item1 = [[TDAlertItem alloc] initWithTitle:@"暂不更新"];
        TDAlertItem *item2 = [[TDAlertItem alloc]initWithTitle:@"前往更新" andHandle:^{
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/id1181307830"];
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
            }else{
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        item2.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
        item2.titleColor = [UIColor colorWithHexString:@"fffefe"];
        TDAlertView *alert = [[TDAlertView alloc] initWithTitle:@"发现新版本" message:jsonData[@"content"] items:@[item1,item2] delegate:self];
        alert.hideWhenclickItem = true;
        alert.hideWhenTouchBackground = NO;
        [alert show];
    }
}


//比较当前版本是否低于线上版本
-(BOOL)compareVersion:(NSString *)local andAppStore:(NSString *)AppStore{
    NSMutableString *localStr =[NSMutableString stringWithString:local];
    NSArray *localArray =[localStr componentsSeparatedByString:@"."];
    if (AppStore && AppStore.length >0) {
        
        NSMutableString *appStoreStr =[NSMutableString stringWithString:AppStore];
        NSArray *appStoreArray =[appStoreStr componentsSeparatedByString:@"."];
        
        if (localArray.count ==appStoreArray.count) {
            //        NSInteger count =0;
            for (int i=0; i<localArray.count; i++) {
                //<正式
                //            if ([localArray[i] integerValue] < [appStoreArray[i] integerValue]) {
                //                count++;
                //            }
                
                if ([appStoreArray[i] integerValue] > [localArray[i] integerValue]) {
                    return true;
                }
            }
            //        if (count==localArray.count) {
            //            return YES;
            //        }else{
            //            return NO;
            //        }
        }
    }
    return false;
}

@end
