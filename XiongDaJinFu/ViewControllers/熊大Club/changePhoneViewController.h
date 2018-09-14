//
//  changePhoneViewController.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/23.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,changeType) {
    PhonesType = 1, //手机
    MailType, //邮箱
};
@interface changePhoneViewController : BaseViewController

@property (nonatomic,assign) changeType chanegType;

@property(nonatomic,strong)  NSString  * typeStr;

@end
