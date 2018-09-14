//
//  itemView.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/6.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "itemView.h"

@implementation itemView
-(instancetype)initWithFrame:(CGRect)frame withItemArray:(NSArray*)itemArray withEnglishArr:(NSArray*)itemEngArr{
    if (self) {
        CGFloat deviceVersion = 14;
        CGFloat bottom = -24;
        if (SCREEN_MAIN.width == 320) {
//            deviceVersion = 14;
            bottom = -20;
        }else if (SCREEN_MAIN.width == 375){
            deviceVersion = 14;
        }else if(SCREEN_MAIN.width == 414){
            deviceVersion = 16;
            bottom = -27;
        }
        
        self = [super initWithFrame:frame];
        // 按钮的尺寸
        CGFloat iconx = 15;
        CGFloat headerButtonWight = (SCREENWIDTH-iconx*(itemArray.count+1))/itemArray.count;
        CGFloat headerButtonHeight = headerButtonWight;
        for (int i = 0 ; i < itemArray.count;  i ++) {
            UIButton  * btn = [XDCommonTool newButtonWithType:UIButtonTypeCustom frame:CGRectMake(headerButtonWight*i+iconx*(i+1),0, headerButtonWight, headerButtonHeight) normalImage:[NSString stringWithFormat:@"%d",i+1] buttonTitle:nil target:self action:@selector(click:)];
           
            btn.layer.cornerRadius = 10;
            btn.clipsToBounds = YES;
            btn.tag = 999 +i;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor =[[UIColor colorWithHexString:@"#ffffff"] CGColor];
            
//            
//            btn.layer.shadowColor = [UIColor blackColor].CGColor;
//            btn.layer.shadowOffset = CGSizeMake(5.0, 5.0);
//            btn.layer.shadowOpacity = YES;
            [self addSubview:btn];


            
            UIView  * backView = [[UIView alloc] init];
            backView.backgroundColor = [UIColor blackColor];
            backView.alpha = 0.5;
            backView.layer.cornerRadius =10;
            backView.clipsToBounds = YES;
            backView.userInteractionEnabled = NO;
            [btn addSubview:backView];
            [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(btn);
                make.height.equalTo(btn);
            }];

            
            
            UIImageView   * borderImageView = [UIImageView new];
            borderImageView.image = [UIImage imageNamed:@"icon_home_main"];
            [btn addSubview:borderImageView];
            [borderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(btn);
                make.height.equalTo(btn);
            }];
            

            
            
            UILabel  * nameLabel = [UILabel new];
            nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:deviceVersion];
            nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            nameLabel.text = itemArray[i];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            [btn addSubview:nameLabel];

            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(btn.mas_centerX);
                make.top.equalTo(btn.mas_bottom).offset(bottom);
                make.width.offset(80);
                make.height.offset(50/4);
            }];
        
            
            
            UILabel  * engLabel = [XDCommonTool newlabelWithTextColor:[UIColor colorWithHexString:@"#666666"] withTitle:itemEngArr[i] fontSize:9];
            engLabel.textAlignment = NSTextAlignmentCenter;
            [btn addSubview:engLabel];
            [engLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(btn.mas_centerX);
                make.bottom.equalTo(btn.mas_bottom).offset(-5);
                make.width.offset(100);
                make.height.offset(30/4);
            }];
        
        
        
        
        }
        

    
    
    
    
    
    }

    return self;

}
-(void)click:(UIButton*)sender{

    [self.delegate tagClick:sender.tag];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
