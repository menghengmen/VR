//
//  XYTeleConsultView.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/20.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYTeleConsultView.h"
@interface XYTeleConsultView()
@property (nonatomic,assign)BOOL isEnjoy;
//@property (nonatomic,assign)BOOL isAggress;
@end
@implementation XYTeleConsultView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)awakeFromNib{
    [super awakeFromNib];
    self.isEnjoy = false;
    [self.nameTextFidle addTarget:self action:@selector(change:) forControlEvents:UIControlEventAllEditingEvents];
    [self.phoneTextFidle addTarget:self action:@selector(change:) forControlEvents:UIControlEventAllEditingEvents];
    [self.emailTextFidle addTarget:self action:@selector(change:) forControlEvents:UIControlEventAllEditingEvents];
    
    self.nameTextFidle.borderStyle = UITextBorderStyleNone;
    self.phoneTextFidle.borderStyle = UITextBorderStyleNone;
    self.emailTextFidle.borderStyle = UITextBorderStyleNone;
}

-(void)setInfo:(NSDictionary *)info{
    _info = info;
    NSString *phone = info[@"mobile"];
    NSString *email = info[@"email"];
    NSString *sex = [NSString stringWithFormat:@"%ld",[info[@"sex"] integerValue]];
    if (phone && phone.length >0) {
        self.phoneTextFidle.text = phone;
    }
    
    if (email && email.length >0) {
        self.emailTextFidle.text = email;
    }
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


-(void)change:(UITextField *)sender{
    if (self.nameTextFidle.text.length >0 && [self.phoneTextFidle.text isPhoneNumber] && [self.emailTextFidle.text isValidEmail]) {
        self.isEnjoy = true;
    }else{
        self.isEnjoy = false;
    }
}



//- (IBAction)agressBtnClick:(id)sender {
//}

- (IBAction)scheduleBtnClick:(id)sender {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"name"] = self.nameTextFidle.text;
    dict[@"phone"] = self.phoneTextFidle.text;
    dict[@"email"] = self.emailTextFidle.text;
    if (self.scheduleBtnClickBlock) {
        self.scheduleBtnClickBlock(dict);
    }
}
@end
