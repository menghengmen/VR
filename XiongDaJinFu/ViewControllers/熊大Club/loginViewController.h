//
//  loginViewController.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/8.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef void (^LoginSuccess)  (void);

@interface loginViewController : BaseViewController

//后台登录
-(void)BGLogin:(LoginSuccess)BGLogin;
- (void)thiredClick:(UIButton *)sender;
- (void)weChatLogin:(UIButton *)sender;
@end
