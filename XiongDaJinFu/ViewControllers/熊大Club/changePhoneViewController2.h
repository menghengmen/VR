//
//  changePhoneViewController2.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/24.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,changeType1) {
    PhonesTypeTwo = 1, //手机
    MailTypeTwo, //邮箱
};
@interface changePhoneViewController2 : BaseViewController
@property (nonatomic,assign) changeType1 chanegType1;


@property(nonatomic,copy)  NSString  * oldPhoneStr;

@end
