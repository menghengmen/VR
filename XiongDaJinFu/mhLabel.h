//
//  mhLabel.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/24.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mhLabel : UILabel
@property (nonatomic, assign) UIEdgeInsets textInsets; // 控制字体与控件边界的间隙
-(instancetype) initWithInsets:(UIEdgeInsets)insets ;

@end
