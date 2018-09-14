//
//  playLoadingView.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/20.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGProgressHUD.h"

@protocol loadViewDelegate <NSObject>
@optional
- (void)didClickBackBtn;
@end

@interface playLoadingView : UIView
@property (strong, nonatomic) UIButton *backBtn1;
@property(nonatomic,strong)    JGProgressHUD *HUD;
;

@property(nonatomic,copy)    NSString *titleStr;

@property(nonatomic,weak)  id<loadViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame withTitleStr:(NSString*)titleStr;
@end
