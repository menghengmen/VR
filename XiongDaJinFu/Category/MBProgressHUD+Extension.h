//
//  MBProgressHUD+Extension.h
//  Essential-New
//
//  Created by Alex on 16/2/29.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extension)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showIndicatorMessage:(NSString *)message;
+ (MBProgressHUD *)showIndicatorMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

+ (void)showMessage:(NSString *)text;
+ (void)showMessage:(NSString *)text toView:(UIView *)view;

@end
