//
//  changePhoneViewController2.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/24.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "changePhoneViewController2.h"

@interface changePhoneViewController2 ()
@property (nonatomic,weak)UITextField *passwordText;
@property (nonatomic,weak)UITextField *phoneText;
@property (nonatomic,weak)UITextField *codeText;



@property (nonatomic,strong)UIButton  * submitBtn;

@property(nonatomic,strong)  MHCountDownButton  * countBtn;

@end

@implementation changePhoneViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString  * phoneStr = [NSString new];
    
    if (self.chanegType1 == PhonesTypeTwo) {
        phoneStr = @"更换手机号";
    }else{
        phoneStr = @"更换邮箱";
        
    }

    
    
    [self setUpNewNai:nil Title:phoneStr];
    [self setUpUI];
 
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sucessCode2) name:CODESUCCESS object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:self.phoneText];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(codeTextFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:self.codeText];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)setUpUI{
    NSString  * phoneStr = [NSString new];
    
    if (self.chanegType1 == PhonesTypeTwo) {
        phoneStr = @"请输入你的新手机号";
    }else{
        phoneStr = @"请输入你的新邮箱";

    }
    
    
    
    UITextField *nameText  =   [XDCommonTool newTextFieldWithStyle:UITextBorderStyleNone withPlaceHolder:phoneStr withKeyBoardType:UIKeyboardTypePhonePad withFont:[UIFont systemFontOfSize:13]];
    self.phoneText  = nameText;
    if (self.chanegType1 ==PhonesTypeTwo) {
        [self.view addSubview:nameText];
        [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.centerX.equalTo(self.view.mas_centerX);
            make.left.equalTo(self.view.mas_left).offset(55+50);
            make.width.equalTo(@(560*SCREENWIDTH/768));
            make.height.equalTo(@44);
            make.top.equalTo(self.view.mas_top).offset(64+40);
        }];
    }
    else{
        [self.view addSubview:nameText];
        [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            //make.left.equalTo(self.view.mas_left).offset(60);
            make.width.equalTo(@(560*SCREENWIDTH/768));
            make.height.equalTo(@44);
            make.top.equalTo(self.view.mas_top).offset(64+40);
        }];
        
        
    }

    
    
    
    
  
    
    
    
    
    
    //分割线
    
    UIView  * sepratorView = [[UIView alloc] init];
    sepratorView.backgroundColor  = [UIColor colorWithHexString:@"#e6e6e6"];
    
    [self.view addSubview:sepratorView];
    
    [sepratorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(560*SCREENWIDTH/768));
        make.height.equalTo(@1);
        make.top.equalTo(nameText.mas_bottom);
    }];
    
    
    if (self.chanegType1 ==PhonesTypeTwo) {
        // 区号
        UILabel  * label = [XDCommonTool newlabelWithTextColor:[UIColor colorWithHexString:@"#999999"] withTitle:@"+86 |" fontSize:13];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameText.mas_centerY);
            make.left.equalTo(sepratorView.mas_left);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
    }

    
    MHCountDownButton *button  = [MHCountDownButton new];
    
    [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
    button.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
    self.countBtn = button;
    [button addTarget:self action:@selector(setMessage2) forControlEvents:UIControlEventTouchUpInside];

    
    //button.backgroundColor = [UIColor colorWithHexString:@"#28a8e0"];
    button.countDownButtonBlock = ^{
        LRLog(@"开始获取验证码"); //开始获取验证码
        
    };
    
    button.second = 60;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameText.mas_centerY);
        make.right.equalTo(sepratorView.mas_right);
        make.width.equalTo(@70);
        make.height.equalTo(@21);
    }];
    
    
    
    
    UITextField *pwdText = [XDCommonTool newTextFieldWithStyle:UITextBorderStyleNone withPlaceHolder:@"请输入验证码" withKeyBoardType:UIKeyboardTypeNumberPad withFont:[UIFont systemFontOfSize:13]];
    
    self.codeText = pwdText;
    [self.view addSubview:pwdText];
    
    [pwdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(560*SCREENWIDTH/768));
        make.height.equalTo(@44);
        make.top.equalTo(nameText.mas_bottom).offset(10);
    }];
    
    //分割线
    
    UIView  * sepratorView1 = [[UIView alloc] init];
    sepratorView1.backgroundColor  = [UIColor colorWithHexString:@"#e6e6e6"];
    
    [self.view addSubview:sepratorView1];
    
    [sepratorView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(560*SCREENWIDTH/768));
        make.height.equalTo(@1);
        make.top.equalTo(pwdText.mas_bottom);
    }];
    
    
    
    
    
    UIButton *submit =   [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:nil buttonTitle:@"确认" target:self action:@selector(submit)];
    [submit setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    submit.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
    submit.layer.cornerRadius = 10;
    [self.view addSubview:submit];
    self.submitBtn = submit;
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(sepratorView1);
        make.height.equalTo(@(70*SCREENHEIGHT/1334));
        make.top.equalTo(pwdText.mas_bottom).offset(23);
    }];
}

-(void)submit{
    
    if ([self.phoneText.text isEqualToString:self.oldPhoneStr]) {
        [XDCommonTool alertWithMessage:@"不能与旧手机号或者旧邮箱一样"];
        return;
    }
    
    NSString  * idStr =   [[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO] objectForKey:@"id"];
    
    NSDictionary  *DICT = [NSDictionary new];
    
    if (self.chanegType1 == PhonesTypeTwo) {
        DICT = @{@"mobile":self.oldPhoneStr,@"new_mobile":self.phoneText.text,@"v_code":self.codeText.text,@"email":@"",@"new_email":@"",@"client_id":idStr};
        

    }
    else{
      DICT = @{@"mobile":@"",@"new_mobile":@"",@"v_code":self.codeText.text,@"email":self.oldPhoneStr,@"new_email":self.phoneText.text,@"client_id":idStr};
    
    }
    
    
    
    [[NetworkClient sharedClient] POST:URL_UPDATEPHONEORMAIL dict:DICT succeed:^(id data) {
        LRLog(@"%@",data);
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [XDCommonTool alertWithMessage:@"更换成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            [XDCommonTool alertWithMessage:@"验证码不正确"];

        }
    } failure:^(NSError *error) {
        LRLog(@"%@",error);
        
    }];




}
-(void)setMessage2{

  
    [XDCommonTool SendMessageWithPhoneOrMail:self.phoneText.text withType:@0];
    

}

-(void)textFieldTextDidChange{

    if ([XDCommonTool checkTel:self.phoneText.text]||[XDCommonTool checkEmail:self.phoneText.text]) {
        self.countBtn.backgroundColor = [UIColor colorWithHexString:@"#28a8e0"];
        self.countBtn.userInteractionEnabled = YES;
    }
    else{
        self.countBtn.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
        self.countBtn.userInteractionEnabled = NO;
        
    }


}

-(void)codeTextFieldTextDidChange{
    
    
    // [self.codeText endEditing:YES];
    self.submitBtn.userInteractionEnabled = YES;
    self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"29a7e1"];
    
    
    //        self.submitBtn.userInteractionEnabled = NO;
    //        self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
    
}
-(void)sucessCode2{
    [self.countBtn click1];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
