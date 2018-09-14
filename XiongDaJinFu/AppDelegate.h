//
//  AppDelegate.h
//  MaDongFrame
//
//  Created by 码动 on 16/10/8.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabbarController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (assign, nonatomic) CGFloat fontSize;//自定义字体大小

@property (assign) Share_Type m_ShareType;
@property (assign) id <WXApiDelegate> wxDelegate;

@end

