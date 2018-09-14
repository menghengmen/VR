//
//  UIViewController+Extension.h
//  Essential-New
//
//  Created by zhu on 16/8/11.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

typedef void (^durtionBlock)();
/**
 计算耗时操作时间
 
 @param fuction 耗时操作代码块
 @return 毫秒数
 */
-(CGFloat)functionUseTimesDurtionBlock:(durtionBlock)fuction;

-(NSString *)getCurrentTime;

+ (UIViewController *)getCurrentViewController;



@end
