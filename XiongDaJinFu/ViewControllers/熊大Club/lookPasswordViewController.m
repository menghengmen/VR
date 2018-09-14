//
//  lookPasswordViewController.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/22.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "lookPasswordViewController.h"

@interface lookPasswordViewController ()
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *code;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *submit;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property(nonatomic,strong)  MHCountDownButton  * countBtn;

@end
@implementation lookPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:self.phoneTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:self.password];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lookPasswordSucessCode) name:CODESUCCESS object:nil];

    
    [self setUpNewNai:nil Title:@"重置密码"];
   
    
    self.phoneTextField.textColor = [UIColor colorWithHexString:@"#333333"];
    
    self.phoneTextField.font = [UIFont fontWithName:@"PingFang-SC-Light" size:13];
    [self.phoneTextField setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    
   
    self.code.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.code setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    self.code.font = [UIFont fontWithName:@"PingFang-SC-Light" size:13];

    self.password.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.password setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.password.font = [UIFont fontWithName:@"PingFang-SC-Light" size:13];

    
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.submit.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
    self.submit.layer.cornerRadius =5;
    self.submit.userInteractionEnabled = NO;

    [self setUpCountBtn];
    
}
-(void)setUpCountBtn{
    MHCountDownButton *button  = [MHCountDownButton new];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#28a8e0"] forState:UIControlStateSelected];
    button.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
    button.userInteractionEnabled = NO;
    [button addTarget:self action:@selector(setMess) forControlEvents:UIControlEventTouchUpInside];
    self.countBtn = button;
    button.countDownButtonBlock = ^{
        LRLog(@"开始获取验证码"); //开始获取验证码
        //[self setMess];
        self.countBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
        [self.countBtn setTitleColor:[UIColor colorWithHexString:@"#29a7e1"] forState:UIControlStateNormal];

        self.countBtn.titleLabel.alpha = 1;
        self.countBtn.layer.borderWidth = 0.5;
        self.countBtn.layer.borderColor = [UIColor colorWithHexString:@"#29a7e1"] .CGColor;
    };
    
    button.second = 60;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topView.mas_top).offset(-8);
        make.right.equalTo(self.phoneTextField.mas_right);
        make.width.equalTo(@70);
        make.height.equalTo(@21);
    }];
    



}
- (IBAction)submitClick:(UIButton *)sender {

    NSDictionary * dict = @{@"identify":self.phoneTextField.text,@"v_code":self.code.text,@"password":self.password.text};
    
    [[NetworkClient sharedClient] POST:URL_FORGETPASSWORD dict:dict succeed:^(id data) {
        LRLog(@"修改密码%@",data);
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [XDCommonTool alertWithMessage:@"密码修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    
    } failure:^(NSError *error) {
        LRLog(@"修改密码%@",error);

    }];

}
-(void)textFieldTextDidChange{
    if ([XDCommonTool checkTel:self.phoneTextField.text]) {
        self.countBtn.backgroundColor = [UIColor colorWithHexString:@"#28a8e0"];
      
        self.countBtn.userInteractionEnabled = YES;
      
        
    }
    else{
        self.countBtn.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
        self.countBtn.userInteractionEnabled = NO;
        
    }


    if ([XDCommonTool checkTel:self.phoneTextField.text]&&self.code.text.length!=0&&self.password.text.length!=0) {
        self.submit.backgroundColor = [UIColor colorWithHexString:@"#28a8e0"];
        self.submit.userInteractionEnabled = YES;
        [self.submit setTitleColor:[UIColor colorWithHexString:@"#d9d9d9"] forState:UIControlStateNormal];
    }
    else{
        self.submit.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
        self.submit.userInteractionEnabled = NO;

    
    }


}
-(void)setMess{
    [XDCommonTool SendMessageWithPhoneOrMail:self.phoneTextField.text withType:@0];
}
-(void)lookPasswordSucessCode{
    [self.countBtn click1];
}
@end
