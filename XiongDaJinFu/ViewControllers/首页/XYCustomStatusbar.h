//
//  XYCustomStatusbar.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/30.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCustomStatusbar : UIWindow

@property (nonatomic,strong)UIImageView *logoImageView;
@property (nonatomic,strong)UILabel *statusTextLabel;
+(instancetype)sharedStatusBar;
-(void)showStatusWithString:(NSString *)string delayInSeconds:(double)delayInSeconds;

-(void)hiddenStatusBar;
@end
