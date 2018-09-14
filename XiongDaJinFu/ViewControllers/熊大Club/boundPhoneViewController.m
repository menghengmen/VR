//
//  boundPhoneViewController.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/5/11.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "boundPhoneViewController.h"

@interface boundPhoneViewController ()<UITextFieldDelegate>
@property (nonatomic,weak)UITextField *phoneText;
@property (nonatomic,weak)UITextField *codeText;



@property (nonatomic,strong)  UIButton  * submitBtn;

@property (nonatomic,strong)  MHCountDownButton  * countBtn;
@end

@implementation boundPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:self.phoneText];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(codeTextFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:self.codeText];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sucessCode) name:CODESUCCESS object:nil];
    
    
    NSString  * titleStr =[self.typeStr isEqualToString:@"手机"]?@"绑定手机":@"绑定邮箱";
    
    [self setUpNewNai:nil Title:titleStr];

    [self setUpUI];


}
- (void)setUpUI{
    UITextField *nameText  =   [XDCommonTool newTextFieldWithStyle:UITextBorderStyleNone withPlaceHolder:nil withKeyBoardType:UIKeyboardTypeDefault withFont:[UIFont systemFontOfSize:13]];
    nameText.placeholder = [self.typeStr isEqualToString:@"手机"]?@"请输入你要绑定的手机号":@"请输入你要绑定的邮箱";
    self.phoneText  = nameText;
    [self.view addSubview:nameText];
    [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.width.equalTo(@(560*SCREENWIDTH/768));
            make.height.equalTo(@44);
            make.top.equalTo(self.view.mas_top).offset(64+40);
        }];
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
    MHCountDownButton *button  = [MHCountDownButton new];
    [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
    button.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
    button.userInteractionEnabled = NO;
    [button addTarget:self action:@selector(setMessage1) forControlEvents:UIControlEventTouchUpInside];
    self.countBtn = button;
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
-(void)submit1{

    NSDictionary  * boundDict = [NSDictionary new];
    
    if ([self.typeStr isEqualToString:@"手机"]) {
        boundDict=@{@"client_id":[[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO] objectForKey:@"id"],@"mobile":self.phoneText.text};

    }
    else{
    
    boundDict=@{@"client_id":[[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO] objectForKey:@"id"],@"email":self.phoneText.text};
    
    }
    [[NetworkClient sharedClient] POST:URL_BOUND dict:boundDict succeed:^(id data) {
        LRLog(@"%@",data);
        
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [XDCommonTool alertWithMessage:@"绑定成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        else{
           
            if ([data [@"error_code"]  isEqualToNumber:[NSNumber numberWithInt:40401]]){
                [XDCommonTool alertWithMessage:@"该手机号已被绑定"];

            }
            
            if ([data [@"error_code"]  isEqualToNumber:[NSNumber numberWithInt:40402]]){
                [XDCommonTool alertWithMessage:@"该邮箱已被绑定"];
                
            }
       
        
        }
        
        
        
    } failure:^(NSError *error) {
        LRLog(@"%@",error);
    }];



 }
# pragma mark -
# pragma mark 校验验证码

-(void)submit{
    
    if ([self.phoneText.text isEqualToString:@""]||[self.codeText.text isEqualToString:@""]) {
        [XDCommonTool alertWithMessage:@"请把信息填写完整"];
        return;
    }
    
    NSString  * idStr =   [[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO] objectForKey:@"id"];
    
    NSDictionary  * DICT = [NSDictionary new];
    if ([self.typeStr isEqualToString:@"手机"]) {
        DICT = @{@"mobile":self.phoneText.text,@"v_code":self.codeText.text,@"email":@"",@"client_id":idStr};
    }
    else{
        DICT = @{@"mobile":@"",@"v_code":self.codeText.text,@"email":self.phoneText.text,@"client_id":idStr};
        }
    
    [[NetworkClient sharedClient] POST:URL_JUDGECODE dict:DICT succeed:^(id data) {
        LRLog(@"%@",data);
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [self submit1];
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
}

-(void)codeTextFieldTextDidChange{
    //[self.codeText endEditing:YES];
    self.submitBtn.userInteractionEnabled = YES;
    self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"29a7e1"];
    
    
    //        self.submitBtn.userInteractionEnabled = NO;
    //        self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
    
}
- (void)setMessage1{
    
    [XDCommonTool SendMessageWithPhoneOrMail:self.phoneText.text withType:@0];
 
    
}
-(void)sucessCode{
    [self.countBtn click1];
}

@end
