//
//  changePhoneViewController.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/23.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "changePhoneViewController.h"
#import "changePhoneViewController2.h"
@interface changePhoneViewController ()<UITextFieldDelegate>
@property (nonatomic,weak)UITextField *passwordText;
@property (nonatomic,weak)UITextField *phoneText;
@property (nonatomic,weak)UITextField *codeText;


@property (nonatomic,weak)UITextField  * xinPasswordTextField;

@property (nonatomic,strong)UIButton  * submitBtn;

@property(nonatomic,strong)  MHCountDownButton  * countBtn;

@end

@implementation changePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString  * titleStr =  [NSString new];

    if (self.chanegType == PhonesType) {
        titleStr = @"更换手机号";
    }else{
        titleStr = @"更换邮箱";

    }
   
    
    
    [self setUpNewNai:nil Title:titleStr];
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sucessCode1) name:CODESUCCESS object:nil];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:self.phoneText];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(codeTextFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:self.codeText];
}
- (void)setUpUI{
    UITextField *nameText  =   [XDCommonTool newTextFieldWithStyle:UITextBorderStyleNone withPlaceHolder:nil withKeyBoardType:UIKeyboardTypeDefault withFont:[UIFont systemFontOfSize:13]];
    
  NSString  * placeStr =  [NSString new];
  
    if (self.chanegType == PhonesType) {
        placeStr = @"请输入旧手机号";
    }
    else{
        placeStr = @"请输入旧邮箱";

    }
    
    
    
    
    nameText.placeholder = placeStr;
    self.phoneText  = nameText;
    
    if (self.chanegType ==PhonesType) {
        [self.view addSubview:nameText];
        [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.centerX.equalTo(self.view.mas_centerX);
            make.left.equalTo(self.view.mas_left).offset(55+45);
            make.width.equalTo(@(560*SCREENWIDTH/768));
            make.height.equalTo(@44);
            make.top.equalTo(self.view.mas_top).offset(64+40);
        }];
    }
    else{
        [self.view addSubview:nameText];
        [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.centerX.equalTo(self.view.mas_centerX);
            //make.left.equalTo(self.view.mas_left).offset(60);
            make.centerX.equalTo(self.view.mas_centerX);
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
        
    //
    
        
    if (self.chanegType ==PhonesType) {
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
     button.userInteractionEnabled = NO;
     [button addTarget:self action:@selector(setMessage1) forControlEvents:UIControlEventTouchUpInside];
      button.countDownButtonBlock = ^{
        LRLog (@"开始获取验证码"); //开始获取验证码
      };
    
      button.second = 60;
      [self.view addSubview:button];
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameText.mas_centerY);
            make.right.equalTo(sepratorView.mas_right);
            make.width.equalTo(@70);
            make.height.equalTo(@21);
        }];
    self.countBtn = button;

    
        
        
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
    submit.userInteractionEnabled = NO;
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
- (void)submit{
   
    LRLog(@"提交了");
    [self judgeCode];
    
}

-(void)judgeCode{
    
  NSString  * idStr =   [[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO] objectForKey:@"id"];
   
    NSDictionary  * DICT = [NSDictionary new];
    if (self.chanegType == PhonesType) {
    DICT = @{@"mobile":self.phoneText.text,@"v_code":self.codeText.text,@"email":@"",@"client_id":idStr};
        

    }
    else{
        DICT = @{@"mobile":@"",@"v_code":self.codeText.text,@"email":self.phoneText.text,@"client_id":idStr};
        
    
    
    }
    
    
    
    [[NetworkClient sharedClient] POST:URL_JUDGECODE dict:DICT succeed:^(id data) {
        LRLog(@"%@",data);
    
       
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){

        
        changePhoneViewController2  * changePhone2 = [changePhoneViewController2 new];
       
        if (self.chanegType == PhonesType) {
            changePhone2.chanegType1 = PhonesTypeTwo;
          }
        else{
            changePhone2.chanegType1 = MailTypeTwo;

        
        }
        
        changePhone2.oldPhoneStr = self.phoneText.text;
        [self.navigationController pushViewController:changePhone2 animated:self];
        

    }
        else{
        
            [XDCommonTool alertWithMessage:@"验证码不正确"];
        }
        
    } failure:^(NSError *error) {
        LRLog(@"%@",error);

    }];
}

- (void)textFieldTextDidChange{
    if ([XDCommonTool checkTel:self.phoneText.text]||[XDCommonTool checkEmail:self.phoneText.text]) {
        self.countBtn.backgroundColor = [UIColor colorWithHexString:@"#28a8e0"];
        self.countBtn.userInteractionEnabled = YES;
    }
    else{
        self.countBtn.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
        self.countBtn.userInteractionEnabled = NO;
    
    }
  
       // [self.phoneText endEditing:YES];
    


}
-(void)codeTextFieldTextDidChange{

   
      // [self.codeText endEditing:YES];
        self.submitBtn.userInteractionEnabled = YES;
        self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"29a7e1"];
    
    
//        self.submitBtn.userInteractionEnabled = NO;
//        self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];

}
- (void)setMessage1{
    
    [XDCommonTool SendMessageWithPhoneOrMail:self.phoneText.text withType:@0];
   
    
}

-(void)sucessCode1{

    [self.countBtn click1];
}
@end
