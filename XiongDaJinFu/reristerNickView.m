//
//  reristerNickView.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/5/25.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "reristerNickView.h"


@interface reristerNickView()<UITextFieldDelegate>
{
    
    NSUInteger  selectSex;
    
    
}

@property (strong, nonatomic)  UITextField *nickTextfield;
@property (strong, nonatomic)  UIButton *submitButton;

@end

@implementation reristerNickView
-(id)initWithFrame:(CGRect)frame{
    if (self) {
        self = [super initWithFrame:frame];
        [self setUpUI];
    }

    return self;

}
-(void)setUpUI{

    
    
    UIImageView  * bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
   // self.backView1 = bgImageView;
    bgImageView.image = [UIImage imageNamed:@"bg_zhuce.jpg"];
    [self addSubview:bgImageView];
    UITextField *NickTextField =   [XDCommonTool newTextFieldWithStyle:UITextBorderStyleNone withPlaceHolder:@"  请设置一个昵称" withKeyBoardType:UIKeyboardTypeDefault withFont:[UIFont systemFontOfSize:13]];
    self.nickTextfield = NickTextField;
    self.nickTextfield.delegate = self;
    
    [self.nickTextfield setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    self.nickTextfield.textColor = [UIColor colorWithHexString:@"#ffffff"];
    
    
    [bgImageView addSubview:NickTextField];
    
    [NickTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(500*SCREENWIDTH/768));
        make.height.equalTo(@(84*SCREENHEIGHT/1334));
        make.top.equalTo(self.mas_top).offset(302);
    }];
    
    
    
    UIView  * sepratorView1 = [[UIView alloc] init];
    sepratorView1.backgroundColor  = [UIColor colorWithHexString:@"#e6e6e6"];
    
    [bgImageView addSubview:sepratorView1];
    
    [sepratorView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(500*SCREENWIDTH/768));
        make.height.equalTo(@0.5);
        make.top.equalTo(NickTextField.mas_bottom);
    }];
    
    
    
    UITextField  * xinPasswordText =  [XDCommonTool newTextFieldWithStyle:UITextBorderStyleNone withPlaceHolder:nil withKeyBoardType:UIKeyboardTypeNumberPad withFont:[UIFont systemFontOfSize:13]];
    [bgImageView addSubview:xinPasswordText];
    [xinPasswordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(500*SCREENWIDTH/768));
        make.height.equalTo(@(84*SCREENHEIGHT/1334));
        make.top.equalTo(NickTextField.mas_bottom).offset(10);
    }];
    
    UIButton  * maleBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"home_icon_nan" buttonTitle:nil target:self action:@selector(selectSex:)];
    maleBtn.tag = 10086;
    [xinPasswordText addSubview:maleBtn];
    [maleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xinPasswordText.mas_left).offset(1);
        make.centerY.equalTo(xinPasswordText.mas_centerY);
        make.width.equalTo(@42);
        make.height.equalTo(@42);
        
    }];
    UIButton  * feMailBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"home_icon_nv" buttonTitle:nil target:self action:@selector(selectSex:)];
    feMailBtn.tag = 10086+1;
    [xinPasswordText addSubview:feMailBtn];
    [feMailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(maleBtn.mas_right).offset(5);
        make.centerY.equalTo(xinPasswordText.mas_centerY);
        make.width.equalTo(@42);
        make.height.equalTo(@42);
        
    }];
    
    
    //分割线
    
    UIView  * sepratorView2 = [[UIView alloc] init];
    sepratorView2.backgroundColor  = [UIColor colorWithHexString:@"#e6e6e6"];
    
    [bgImageView addSubview:sepratorView2];
    
    [sepratorView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(500*SCREENWIDTH/768));
        make.height.equalTo(@0.5);
        make.top.equalTo(xinPasswordText.mas_bottom);
    }];
    
    //注册按钮
    
    UIButton  * registerBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:nil buttonTitle:@"完成" target:self action:@selector(complete)];
    
    
    [registerBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
    registerBtn.layer.cornerRadius = 10;
    self.submitButton = registerBtn;
    [bgImageView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sepratorView2.mas_bottom).offset(40*SCREENHEIGHT/1334);
        make.width.equalTo(@(500*SCREENWIDTH/768));
        make.centerX.equalTo(self);
        make.height.equalTo(@(70*SCREENHEIGHT/1334));
        
    }];
    
    
    


}
# pragma mark -
# pragma mark 选择性别
-(void)selectSex:(UIButton*)sender{
    
    selectSex = sender.tag;
    for (int i = 0 ; i < 2 ; i ++) {
        if (sender.tag == 10086+i) {
            sender.selected = YES;
            
            if (sender.tag ==10086) {
                [sender setImage:[UIImage imageNamed:@"home_icon_nan_pre"] forState:UIControlStateNormal];
                
            }
            
            else{
                [sender setImage:[UIImage imageNamed:@"home_icon_nv_pre"] forState:UIControlStateNormal];
                
                
            }
            
            
            continue;
        }
        
        UIButton  * btn =(UIButton*) [self viewWithTag:10086+i];
        btn.selected = NO;
        
        if (btn.tag ==10086) {
            [btn setImage:[UIImage imageNamed:@"home_icon_nan"] forState:UIControlStateNormal];
            
        }
        
        else{
            [btn setImage:[UIImage imageNamed:@"home_icon_nv"] forState:UIControlStateNormal];
            
        }
        
        
    }
    
    
}
-(void)complete{
    if ([self.nickTextfield.text isEqualToString:@""]||selectSex==0) {
        [XDCommonTool alertWithMessage:@"请把信息填写完整"];
        return;
    }
    LRLog(@"填写的昵称%@",self.nickTextfield.text);
    LRLog(@"填写的昵称%lu",(unsigned long)selectSex);

    NSDictionary  * dict = @{@"nick_name":self.nickTextfield.text,@"sex":@(selectSex-10086)};
    
    if (self.registerBtnClickBlock) {
        self.registerBtnClickBlock(dict);
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
