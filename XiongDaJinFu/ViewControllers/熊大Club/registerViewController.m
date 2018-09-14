//
//  registerViewController.m
//  XiongDaJinFu
//
//  Created by gary on 2016/12/6.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import "registerViewController.h"
#import "MainViewController.h"
#import "HomePageViewController.h"
#import "reristerNickView.h"
@interface registerViewController ()<UITextFieldDelegate,WXApiDelegate>
{
    AppDelegate *appdelegate;

    UITextField *nameText;
    UIView  * sepratorView;

    
}

@property (strong, nonatomic)  IBOutlet UIImageView *logoImage;

@property (strong, nonatomic)  UITextField *nameTextField;

@property (strong, nonatomic)  UITextField *codeTextfield;
@property (strong, nonatomic)  UITextField *passwordTextfield;
@property (weak, nonatomic)    MHCountDownButton *codeButton;

@property (strong, nonatomic)  UIButton *submitButton;
//用于做动画的view
@property (strong, nonatomic)  UIImageView *backView;
@property (strong, nonatomic)  reristerNickView *backView1;


@property (strong, nonatomic)  UIButton *leftBtn;

@end
@implementation registerViewController


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;

}
- (void)viewDidLoad{
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
   
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sucessCodeRegister) name:CODESUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backToHome1)
                                                 name:THIRD_LOGIN_SUC
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wechatSuc1:)
                                                 name:LOGIN_WECHATSUC
                                               object:nil];

    
    [self nickUI];
    [self setUpUI];

    self.backView1.alpha = 0;
}
-(void)nickUI{
    reristerNickView  * nickView = [[reristerNickView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.backView1 = nickView;
     nickView.registerBtnClickBlock = ^(NSDictionary  * dict){
        NSDictionary  * userDict =   [XDCommonTool readDicFromUserDefaultWithKey:@"userInfo"];
        NSDictionary  * dict1 = @{@"client_id":[userDict objectForKey:@"id"],@"nick_name":[dict objectForKey: @"nick_name"],@"sex":[dict objectForKey: @"sex"]};
        
        [self.navigationController popToRootViewControllerAnimated:YES];

        [[NetworkClient sharedClient] POST:URL_UPDATEINFO dict:dict1 succeed:^(id data) {
            LRLog(@"注册更改信息%@",data);
            [[NSNotificationCenter defaultCenter] postNotificationName:REGISTERSAVEMESSAGE object:self];
            
            
        } failure:^(NSError *error) {
            LRLog(@"注册更改信息%@",error);
            
        }];

        
        
    };
    
    [self.view addSubview:nickView];
    
  
}
- (void)setUpUI{
   
    UIImageView  * bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    
    bgImageView.image = [UIImage imageNamed:@"bg_zhuce.jpg"];
    self.backView = bgImageView;
    [self.view addSubview:bgImageView];
    
   
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 30, 69/2)];
    [leftBtn setImage:[UIImage imageNamed:@"icon_back_w"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = leftBtn;
    [bgImageView addSubview:leftBtn];

    
    //logo
    UIImageView  * logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"Login_logo"];
    
    [bgImageView addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.superview).offset(115);
        make.centerX.equalTo(logoImageView.superview);
        make.width.equalTo(@(194*SCREENWIDTH/768));
        make.height.equalTo(@(162*SCREENHEIGHT/1336));
    }];

    nameText = [[UITextField alloc] init];
    nameText.textColor = [UIColor colorWithHexString:@"#ffffff"];

    nameText.borderStyle=UITextBorderStyleNone;
    nameText.placeholder = @"请输入你的邮箱或手机号";
    nameText.delegate =self;
    [nameText setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];

    nameText.tag=100;
    nameText.font = [UIFont systemFontOfSize:13];
    self.nameTextField  = nameText;
    [bgImageView addSubview:nameText];
    

    [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(10);
        make.width.equalTo(@(560*SCREENWIDTH/768));
        make.height.equalTo(@(92*SCREENHEIGHT/1334));
        make.top.equalTo(self.logoImage.mas_bottom).offset(54);
    }];
    
    //分割线
    
    sepratorView = [[UIView alloc] init];
    sepratorView.backgroundColor  = [UIColor colorWithHexString:@"#ffffff"];
    sepratorView.alpha = 0.6;

    [bgImageView addSubview:sepratorView];
    
    [sepratorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(560*SCREENWIDTH/768));
        make.height.equalTo(@0.5);
        make.top.equalTo(nameText.mas_bottom);
    }];
    
    
    UIImageView  * shoujiImageView =[[UIImageView alloc] init];
    shoujiImageView.image = [UIImage imageNamed:@"icon_input_yonghu.png"];
    [bgImageView addSubview:shoujiImageView];
    
    [shoujiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nameText.mas_left).offset(-5);
        make.bottom.equalTo(sepratorView.mas_top).offset(-11.5);
        make.width.equalTo(@19);
        make.height.equalTo(@19);
    }];
    
    
    
    MHCountDownButton *button  = [MHCountDownButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blackColor];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    button .backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.3];
    button.titleLabel.alpha = 0.6;
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    self.codeButton = button;
    button.second = 60;
    [button addTarget:self action:@selector(setMessageRegister) forControlEvents:UIControlEventTouchUpInside];

    button.userInteractionEnabled = NO;
    self.codeButton.countDownButtonBlock = ^{
        LRLog(@"开始获取验证码");
    };
    

    
    [bgImageView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameText.mas_centerY);
        make.right.equalTo(sepratorView.mas_right);
        make.width.equalTo(@65);
        make.height.equalTo(@21);
    }];
    
    
    
    
    UITextField *pwdText = [[UITextField alloc] init];
    pwdText.textColor = [UIColor colorWithHexString:@"#ffffff"];

    pwdText.placeholder = @"请输入验证码";
    pwdText.keyboardType = UIKeyboardTypeNumberPad;
    [pwdText setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];

    pwdText.font = [UIFont systemFontOfSize:13];
    self.codeTextfield = pwdText;
    self.codeTextfield.delegate = self;
    [bgImageView addSubview:pwdText];
    
    [pwdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(10);
        make.width.equalTo(@(560*SCREENWIDTH/768));
        make.height.equalTo(@(92*SCREENHEIGHT/1334));
        make.top.equalTo(sepratorView.mas_bottom);
    }];
    
    //分割线
    
    UIView  * sepratorView1 = [[UIView alloc] init];
    sepratorView1.backgroundColor  = [UIColor colorWithHexString:@"#ffffff"];
    sepratorView1.alpha = 0.6;

    [bgImageView addSubview:sepratorView1];
    
    [sepratorView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(560*SCREENWIDTH/768));
        make.height.equalTo(@0.5);
        make.top.equalTo(pwdText.mas_bottom);
    }];
    
    UIImageView  * yanzhengImageView =[[UIImageView alloc] init];
    yanzhengImageView.image = [UIImage imageNamed:@"icon_input_yanzheng.png"];
    [bgImageView addSubview:yanzhengImageView];
    
    [yanzhengImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(pwdText.mas_left).offset(-5);
        make.bottom.equalTo(sepratorView1.mas_top).offset(-11.5);
        make.width.equalTo(@19);
        make.height.equalTo(@19);
    }];
    
    
    
    
    
    UITextField  * xinPasswordText = [[UITextField alloc] init];
    
    xinPasswordText.placeholder = @"请设置你的密码";
    [xinPasswordText setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    xinPasswordText.secureTextEntry = YES;
    xinPasswordText.delegate =self;
    xinPasswordText.font = [UIFont systemFontOfSize:13];
    xinPasswordText.textColor = [UIColor colorWithHexString:@"#ffffff"];

    
    self.passwordTextfield = xinPasswordText;
    [bgImageView addSubview:xinPasswordText];
    
    [xinPasswordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(10);
        make.width.equalTo(@(560*SCREENWIDTH/768));
        make.height.equalTo(@(92*SCREENHEIGHT/1334));
        make.top.equalTo(sepratorView1.mas_bottom);
    }];
    
      
    //分割线
    
    UIView  * sepratorView2 = [[UIView alloc] init];
    sepratorView2.backgroundColor  = [UIColor colorWithHexString:@"#ffffff"];
    sepratorView2.alpha = 0.6;

    [bgImageView addSubview:sepratorView2];
    
    [sepratorView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(560*SCREENWIDTH/768));
        make.height.equalTo(@0.5);
        make.top.equalTo(xinPasswordText.mas_bottom);
    }];
    
    UIImageView  * mimaImageView =[[UIImageView alloc] init];
    mimaImageView.image = [UIImage imageNamed:@"icon_input_mima.png"];
    [bgImageView addSubview:mimaImageView];
    
    [mimaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(xinPasswordText.mas_left).offset(-5);
        make.bottom.equalTo(sepratorView2.mas_top).offset(-11.5);
        make.width.equalTo(@19);
        make.height.equalTo(@19);
    }];
    
    //注册按钮
    
    UIButton  * registerBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:nil buttonTitle:@"注 册" target:self action:@selector(submitClick:)];

    
    [registerBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    registerBtn.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
    registerBtn.layer.cornerRadius = 6;
    self.submitButton = registerBtn;
    [bgImageView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sepratorView2.mas_bottom).offset(40*SCREENHEIGHT/1334);
        make.width.equalTo(@(560*SCREENWIDTH/768));
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(70*SCREENHEIGHT/1334));
        
    }];
    
    //第三方登录
     UILabel *  thirdLabel = [XDCommonTool newlabelWithTextColor:[UIColor colorWithHexString:@"999999"] withTitle:@"第三方登录" fontSize:11];
    [bgImageView addSubview:thirdLabel];
    [thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImageView.mas_top).offset(460);
        make.centerX.equalTo(thirdLabel.superview);
        make.width.equalTo(@250);
        make.height.equalTo(@35);
        
    }];
    
    //qq
   UIButton* qqBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"login_qq" buttonTitle:nil target:self action:@selector(thiredClick:)];
    qqBtn.tag = 70*2;
    [bgImageView addSubview:qqBtn];
    [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdLabel.mas_bottom).offset(8);
        make.right.equalTo(qqBtn.superview.mas_centerX).offset(-43);
        make.width.equalTo(@51);
        make.height.equalTo(@51);
    }];
    
    
    //weixin
   UIButton* weChatBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"login_weixin" buttonTitle:nil target:self action:@selector(thiredClick:)];
    weChatBtn.tag = 70*1;
    [bgImageView addSubview:weChatBtn];
    [weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdLabel.mas_bottom).offset(8);
        make.left.equalTo(weChatBtn.superview.mas_centerX).offset(43);
        make.width.equalTo(@51);
        make.height.equalTo(@51);
    }];
    
    
    
    UIView  * bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgImageView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(weChatBtn.mas_centerY);
        make.width.equalTo(@0.5);
        make.height.equalTo(@25);
    }];
    






}
-(void)thiredClick:(UIButton*)sender{
    loginViewController  * login = [loginViewController new];
    
    
    if (sender.tag == 70*2) {
        [login thiredClick:sender];
    }
    else{
        AppDelegate* tAppDel =  (AppDelegate*)[UIApplication sharedApplication].delegate;
        tAppDel.m_ShareType = Share_WeChat;
        SendAuthReq  * req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"; // @"post_timeline,sns"
        req.state = @"123";
        req.openID = @"wx045c28961f2d7114";
        appdelegate = [UIApplication sharedApplication].delegate;
        appdelegate.wxDelegate = self;
        
        [WXApi sendReq:req];
    }
    
}

-(void)backToHome{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textFieldTextDidChange{

    if ([XDCommonTool checkTel:self.nameTextField.text]||[XDCommonTool checkEmail:self.nameTextField.text]) {
        self.codeButton.userInteractionEnabled = YES;
        self.codeButton.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.codeButton.titleLabel.alpha = 1;

    
    }
    else{
    
        self.codeButton.userInteractionEnabled = NO;
       self.codeButton.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.codeButton.titleLabel.alpha = 0.6;

    }

}

- (void)submitClick:(UIButton *)sender {
  
  
    //直接进入填写昵称界面(测试用)
   //[self viewMiss];
    if(![self judgeInfo]){
        return;
    }
    NSDictionary  * dict = @{@"identify":self.nameTextField.text,@"type":@1,@"v_code":self.codeTextfield.text,@"pwd":self.passwordTextfield.text};
    [[NetworkClient sharedClient] POST:URL_REGISTER dict:dict succeed:^(id data) {
        LRLog(@"%@",data);
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [self viewMiss];
            
            //保存信息,做自动登录操作
            NSDictionary  * userDict = @{@"mobile":self.nameTextField.text};
            [XDCommonTool saveToUserDefaultWithDic:userDict  key:USER_INFO];
             [XDCommonTool saveToUserDefaultWithString:self.passwordTextfield.text  key:@"password"];
            
            //自动登录
            loginViewController  * LOGIN = [loginViewController new];
            [LOGIN BGLogin:^{
                
            }];

        }else{
        
        [XDCommonTool alertWithMessage:[data objectForKey:@"error_msg"]];
        }
        
    } failure:^(NSError *error) {
        LRLog(@"%@",error);
    }];
}

-(void)viewMiss{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationDelegate:self];
    self.backView.transform = CGAffineTransformMakeScale(3, 3);
    self.backView.alpha = 0;
    
    self.backView1.transform = CGAffineTransformMakeScale(1, 1);
    self.backView1.alpha = 1;
    [UIView commitAnimations];
}

- (BOOL)judgeInfo{

    if ([self.nameTextField.text isEqualToString:@""]||[self.codeTextfield.text isEqualToString:@""]||[self.passwordTextfield.text isEqualToString:@""]) {
        [XDCommonTool alertWithMessage:@"信息不能为空"];
        return NO;
    }
    if (![XDCommonTool checkTel:self.nameTextField.text]&&![XDCommonTool checkEmail:self.nameTextField.text]) {
        [XDCommonTool alertWithMessage:@"请输入正确的账号"];
        return NO;
    }

    return YES;

}
-(void)setMessageRegister{
  
    [XDCommonTool SendMessageWithPhoneOrMail:self.nameTextField.text withType:@1];
   
}
-(void)sucessCodeRegister{
    [self.codeButton click1];
    self.codeButton.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0];
    self.codeButton.titleLabel.alpha = 1;
    self.codeButton.layer.borderWidth = 0.5;
    self.codeButton.layer.borderColor = [UIColor whiteColor] .CGColor;
}
- (void)backToHome1
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark 微信登录回调

/**
 * 微信授权成功回调
 * @Param
 * @Return
 */
/**
 * 微信拿昵称(接上面) -----私有
 * @Param
 * @Return
 */

-(void) wechatSuc1:(NSNotification*) notification{
    NSLog(@"code %@",notification);
    
    
    NSDictionary  * dict1 = notification.userInfo;
    
    NSString  * codeStr = [dict1 objectForKey:@"code"];
    
    [XDCommonTool requestWeChatInfo:^(NSDictionary *tJsonDic) {
        NSLog(@"success%@",tJsonDic);
        //封装的方法(第三方注册)
        [XDCommonTool thirdRegisterWithUserID:[tJsonDic objectForKey:@"openid"] withNickName:[tJsonDic objectForKey:@"nickname"] withImage:[tJsonDic objectForKey:@"headimgurl"] withUserNameType:@2];
        
    } fail:^(NSDictionary *tJsonDic) {
        NSLog(@"error%@",tJsonDic);
    } code:codeStr];
}


@end
