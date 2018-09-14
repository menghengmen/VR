//
//  unLoginTableViewCell.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/27.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "unLoginTableViewCell.h"

@implementation unLoginTableViewCell
-(UIButton*)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [UIButton new];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.layer.borderWidth = 1;
        _registerBtn.layer.borderColor=[[UIColor colorWithHexString:@"#29a7e1"] CGColor];
        [_registerBtn setTitleColor:[UIColor colorWithHexString:@"#29a7e1"] forState:UIControlStateNormal];
        
        _registerBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        _registerBtn.layer.cornerRadius = 6;
        _registerBtn.tag = 10001;
       
        [_registerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }

    return _registerBtn;

}
-(UIButton*)loginBtn{

    if (!_loginBtn) {
        
        _loginBtn = [UIButton new];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.layer.borderWidth = 2;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
        _loginBtn.layer.borderColor=[[UIColor colorWithHexString:@"#29a7e1"] CGColor];
        _loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];

        _loginBtn.layer.cornerRadius = 6;
        [_loginBtn setTitleColor:[UIColor colorWithHexString:@"#fffefe"] forState:UIControlStateNormal];
   
        _loginBtn.tag = 10002;
        
        [_loginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    return _loginBtn;

}

-(void)btnClick:(UIButton*)sender{

    [self.delegate didSelectWithBtnTag:sender.tag];

}



- (void)awakeFromNib {
    [super awakeFromNib];
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.registerBtn];
        [self addSubview:self.loginBtn];
        
        
        [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(60);
            make.right.equalTo(self.registerBtn.superview.mas_centerX).offset(-10);

            
            make.width.equalTo(@(110));
            make.height.equalTo(@35);

        }];
        //cell高260
        [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.loginBtn.superview.mas_centerX).offset(10);
            make.top.equalTo(self.mas_top).offset(60);
            make.width.equalTo(@110);
            make.height.equalTo(@35);
            
        }];
    }
    return self;
}
@end
