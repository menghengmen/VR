//
//  XYScheduleOrderVC.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/12.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYScheduleOrderVC.h"
@interface XYScheduleOrderVC()
@property (nonatomic ,assign)NSInteger sex;//0:男性 1：女性
@property (nonatomic ,assign)BOOL isEnjoy;
@end
@implementation XYScheduleOrderVC

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.nameTextField addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventAllEvents];
    [self.phoneTextField addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventAllEvents];
    [self.emailTextField addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventAllEvents];
    [self.qqTextField addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventAllEvents];
    
    self.nameTextField.borderStyle = UITextBorderStyleNone;
    self.emailTextField.borderStyle = UITextBorderStyleNone;
    self.phoneTextField.borderStyle = UITextBorderStyleNone;
    self.qqTextField.borderStyle = UITextBorderStyleNone;
    
    self.sex = 0;
    self.isEnjoy = false;
}

-(void)setIsEnjoy:(BOOL)isEnjoy{
    _isEnjoy = isEnjoy;
    if (isEnjoy) {
        self.scheduleBtn.enabled = true;
        [self.scheduleBtn setBackgroundColor:[UIColor colorWithHex:0x29a7e1]];
    }else{
        self.scheduleBtn.enabled = false;
        [self.scheduleBtn setBackgroundColor:[UIColor colorWithHex:0xb9b9b9]];
    }
}

-(void)setSex:(NSInteger)sex{
    _sex = sex;
    if (sex == 0) {
        [self.nanBtn setImage:[UIImage imageNamed:@"home_icon_nan_pre"] forState:UIControlStateNormal];
        [self.nvBtn setImage:[UIImage imageNamed:@"home_icon_nv"] forState:UIControlStateNormal];
    }else if (sex == 1){
        [self.nanBtn setImage:[UIImage imageNamed:@"home_icon_nan"] forState:UIControlStateNormal];
        [self.nvBtn setImage:[UIImage imageNamed:@"home_icon_nv_pre"] forState:UIControlStateNormal];
    }
}

-(void)setUserInfo:(NSDictionary *)userInfo{
    _userInfo = userInfo;
    NSString *phone = userInfo[@"mobile"];
    NSString *email = userInfo[@"email"];
    NSString *sex = [NSString stringWithFormat:@"%ld",[userInfo[@"sex"] integerValue]];
    if (phone && phone.length >0) {
        self.phoneTextField.text = phone;
    }
    
    if (email && email.length >0) {
        self.emailTextField.text = email;
    }
    
    if (sex && sex.length >0) {
        self.sex = [sex integerValue];
    }
}

-(void)changeValue{
    if (self.nameTextField.text.length >0 && [self.phoneTextField.text isPhoneNumber] && [self.emailTextField.text isValidEmail]) {
        self.isEnjoy = true;
    }else{
        self.isEnjoy = false;
    }
}



- (IBAction)sexBtnClick:(UIButton *)sender {
        if (sender.tag == 1000) {
            self.sex = 0;
        }else if (sender.tag == 1001){
            self.sex = 1;
        }
}
    
- (IBAction)sceduleBtnClick:(id)sender {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"name"]= self.nameTextField.text;
    dict[@"sex"]= @(self.sex);
    dict[@"phone"]= self.phoneTextField.text;
    dict[@"email"]= self.emailTextField.text;
    dict[@"qq"]= self.qqTextField.text;
    if (self.scheduleBtnClickBlock) {
        self.scheduleBtnClickBlock(dict);
    }
}


@end
  
