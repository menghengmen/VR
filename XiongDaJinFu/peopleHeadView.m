//
//  peopleHeadView.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "peopleHeadView.h"
#import "UIImageView+WebCache.h"
@interface peopleHeadView()

@property (nonatomic, weak)UIImageView *iconImageView;
@property (nonatomic, strong)UIButton *settingBtn;
@property (nonatomic, weak)UIButton *editBtn;



@end

@implementation peopleHeadView



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame] ) {
        [self setUp];
    }

    return self;

}

- (void)setUp{

    UIButton  * settingBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:nil buttonTitle:@"设置" target:self action:@selector(setting:)];
    self.settingBtn = settingBtn;
    [self addSubview:settingBtn];
   [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(settingBtn.superview.mas_left).offset(10);
       make.top.equalTo(settingBtn.superview.mas_top).offset(20);
       make.width.equalTo(@100);
   }];


    
    UIButton  * editBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:nil buttonTitle:@"编辑" target:self action:@selector(setting:)];
    self.editBtn = editBtn;
    [self addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(editBtn.superview.mas_right).offset(-10);
        make.top.equalTo(editBtn.superview.mas_top).offset(20);
        make.width.equalTo(@100);
    }];

    UIImageView  * icon = [XDCommonTool newImageViewWithName:@""];
    icon.backgroundColor = [UIColor redColor];
    NSDictionary  * userDict = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
    [icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GlobalImageUrl,[userDict objectForKey:@"icon"]]]];
    icon.layer.cornerRadius =10;
    [self addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
 
    }];



}

-(void)setting:(UIButton*)sender{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickBtn:)]) {
        [self.delegate didClickBtn:sender.titleLabel.text];
    }


}

@end
