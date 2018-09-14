//
//  playLoadingView.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/20.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "playLoadingView.h"

@implementation playLoadingView
- (id)initWithFrame:(CGRect)frame withTitleStr:(NSString*)titleStr{

    if (self =[super initWithFrame:frame]) {
        [self initViewWithTitle:titleStr];

    }
    return self;
}
-(void)initViewWithTitle:(NSString*)titleStr{

    UIButton  * backBtn = [[UIButton alloc] init];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"player_back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.left.equalTo(self.mas_left).offset(0);
        make.width.equalTo(@120);
        make.height.equalTo(@(24*6/2));

    }];
    
    
    UILabel  * label = [[UILabel alloc] init];
    NSString  * str = [NSString stringWithFormat:@"即将播放:%@全景视频",titleStr];
    label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    label.text  = str;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHexString:@"#b3b3b3"];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@400);
        make.height.equalTo(@40);
    }];

    UIImageView  * logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"loadingLogo"];
    [self addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(label);
        make.top.equalTo(self).offset(self.bounds.size.height/5);
        make.width.equalTo(@((127/3)*2));
        make.height.equalTo(@((107/3)*2));
        
    }];


    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc]init];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self addSubview:activityIndicator];
    [activityIndicator startAnimating];
    [activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(label);
        make.top.equalTo(label.mas_bottom).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
        
    }];
}
-(void)backButtonTouched{
    [self.delegate didClickBackBtn];

}
@end
