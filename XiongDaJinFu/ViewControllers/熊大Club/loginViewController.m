//
//  loginViewController.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/8.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "loginViewController.h"
#import "UMSocial.h"
#import "lookPasswordViewController.h"
#import "registerViewController.h"
#import "WXApi.h"

#define   WScale(w)      (w*(320.0)/[UIScreen mainScreen].bounds.size.width)
#define   HScale(y)      (y*(568.0)/[UIScreen mainScreen].bounds.size.height)



@interface loginViewController ()<UITextFieldDelegate,WXApiDelegate>

{
    
    UITextField *pwdText;
    UITextField *nameText;
    UIButton  * qqBtn;
    UIButton  * weChatBtn;
    UILabel *thirdLabel;
    

    UIButton  * yincangBtnt;
    AppDelegate *appdelegate;

}


@property (strong, nonatomic)  UITextField *userNameTextField;
@property (strong, nonatomic)  UITextField *passwordTextField;
@end

@implementation loginViewController

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = YES;

}


-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameTextField.text = [XDCommonTool readStringFromUserDefaultWithKey:@"userName"];
    
    [self setUpUI];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backToHome)
                                                 name:THIRD_LOGIN_SUC
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wechatSuc1:)
                                                 name:LOGIN_WECHATSUC
                                               object:nil];
   
  }

-(void)setUpUI{
   
    UIImageView  * bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    
    bgImageView.image = [UIImage imageNamed:@"bg_zhuce.jpg"];
    [self.view addSubview:bgImageView];
    

    
    
    
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 30, 69/2)];
    [leftBtn setImage:[UIImage imageNamed:@"icon_back_w"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    
    //logo
    UIImageView  * logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"Login_logo"];
    
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.superview).offset(115);
        
        make.centerX.equalTo(logoImageView.superview);
        
        make.width.equalTo(@(194*SCREENWIDTH/768));
        make.height.equalTo(@(162*SCREENHEIGHT/1336));
    }];
    
    //手机号
    nameText = [[UITextField alloc] init];

    nameText.borderStyle=UITextBorderStyleNone;
    nameText.contentMode = UIViewContentModeScaleAspectFill;
    nameText.font = [UIFont systemFontOfSize:13];
    nameText.placeholder = @"输入注册手机号或邮箱";
    nameText.delegate =self;
    nameText.textColor = [UIColor colorWithHexString:@"#ffffff"];
    [nameText setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];

    [self.view addSubview:nameText];
    
    nameText.text = [XDCommonTool readStringFromUserDefaultWithKey:@"loginNumber"];
    [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.mas_bottom).offset(54);
        make.centerX.equalTo(nameText.superview);
        make.width.equalTo(@(560*SCREENWIDTH/768-16));
        make.height.equalTo(@(84*SCREENHEIGHT/1334));
        
    }];
    
    //分割线
    
    UIView  * sepratorView = [[UIView alloc] init];
    sepratorView.backgroundColor  = [UIColor colorWithHexString:@"#ffffff"];
    sepratorView.alpha = 0.6;
    [self.view addSubview:sepratorView];
    
    [sepratorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        //make.width.equalTo(@250);
       // make.left.equalTo(nameText.mas_left+2);
        make.width.equalTo(@(560*SCREENWIDTH/768));

        make.height.equalTo(@0.5);
        make.top.equalTo(nameText.mas_bottom);
    }];
    
    
    
  
    
    
    
    //密码
    
    pwdText = [[UITextField alloc] init];
    pwdText.textColor = [UIColor colorWithHexString:@"#ffffff"];

    pwdText.placeholder = @"输入密码";
    pwdText.font = [UIFont systemFontOfSize:13];
    pwdText.secureTextEntry = YES;
    
    pwdText.delegate =self;
    [self.view addSubview:pwdText];
    self.userNameTextField = nameText;
    self.passwordTextField = pwdText;
    
    //[pwdText setValue:[UIColor colorWithHexString:@"#ffffff"] forKeyPath:@"_placeholderLabel.textColor"];
     [pwdText setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    [pwdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameText.mas_bottom).offset(5);
        make.centerX.equalTo(nameText.superview);
        make.width.equalTo(@(560*SCREENWIDTH/768-16));
        make.height.equalTo(@(84*SCREENHEIGHT/1334));
    }];
    
    //密码可见不可见
    UIButton  * yincangBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"icon_yincang" buttonTitle:nil target:self action:@selector(changeYinCang:)];
    
    yincangBtn.selected = YES;
    [self.view addSubview:yincangBtn];
    [yincangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pwdText.mas_centerY);
        make.right.equalTo(pwdText.mas_right).offset(5);
        make.width.equalTo(@20);
        make.height.equalTo(@13);
        
    }];
    
    //分割线
    
    UIView  * sepratorView1 = [[UIView alloc] init];
    sepratorView1.backgroundColor  = [UIColor colorWithHexString:@"#ffffff"];
    sepratorView1.alpha=0.6;
    [self.view addSubview:sepratorView1];
    
    [sepratorView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        //make.left.equalTo(pwdText.mas_left);
        make.width.equalTo(@(560*SCREENWIDTH/768));

        make.height.equalTo(@0.5);
        make.top.equalTo(pwdText.mas_bottom);
    }];
    
    
    UIImageView  * mimaImageview = [XDCommonTool newImageViewWithName:@"icon_input_mima.png"];
    [self.view addSubview:mimaImageview];
    [mimaImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(pwdText.mas_left).offset(-5);
        make.bottom.equalTo(sepratorView1.mas_top).offset(-11.5);
        make.width.equalTo(@19);
        make.height.equalTo(@19);
    }];
    
    // 找回密码
    UIButton *searchPwd = [[UIButton alloc] init];
    searchPwd.titleLabel.font =[UIFont systemFontOfSize:13];
    [searchPwd setTitle:@"忘记密码" forState:UIControlStateNormal];
    [searchPwd addTarget:self action:@selector(searchPwdClick) forControlEvents:UIControlEventTouchUpInside];
    [searchPwd setTitleColor:[UIColor colorWithHexString:@"#29a7e1"] forState:UIControlStateNormal];
    //[searchPwd setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
   searchPwd.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.view addSubview:searchPwd];
    [searchPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdText.mas_bottom).offset(5);
        make.right.equalTo(pwdText.mas_right).offset(32);
        make.width.equalTo(@100);
        make.height.equalTo(@(42*SCREENHEIGHT/1334));
    }];
    
    //登录按钮
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    [login setTitle:@"登 录" forState:UIControlStateNormal];
    [login setBackgroundColor:[UIColor colorWithHexString:@"#29a7e1"]];
    login.layer.cornerRadius = 6;
    [login setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:login];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchPwd.mas_bottom).offset(10);
        make.centerX.equalTo(login.superview);
        make.width.equalTo(@(560*SCREENWIDTH/768));
        make.height.equalTo(@(70*SCREENHEIGHT/1334));
    }];
    
    
    
    
    
    // 注册
    UIButton *registerBtn = [[UIButton alloc] init];
    //    [registerBtn setBackgroundImage:[UIImage imageNamed:@"register"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [registerBtn setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]];
   // registerBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [registerBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(login.mas_bottom).offset(10);
        make.centerX.equalTo(registerBtn.superview);
        make.width.equalTo(@250);
        make.height.equalTo(@35);
        
    }];
    
    
    //第三方登录
    thirdLabel = [XDCommonTool newlabelWithTextColor:[UIColor colorWithHexString:@"999999"] withTitle:@"第三方登录" fontSize:11];
    [self.view addSubview:thirdLabel];
    [thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(registerBtn.mas_bottom).offset(35);
        make.centerX.equalTo(thirdLabel.superview);
        make.width.equalTo(@250);
        make.height.equalTo(@35);
        
    }];
    
    //qq
    qqBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"login_qq" buttonTitle:nil target:self action:@selector(thiredClick:)];
    qqBtn.tag = 70*2;
    [self.view addSubview:qqBtn];
    [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdLabel.mas_bottom).offset(8);
        make.right.equalTo(qqBtn.superview.mas_centerX).offset(-43);
        make.width.equalTo(@51);
        make.height.equalTo(@51);
    }];
    
    
    //weixin
    weChatBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"login_weixin" buttonTitle:nil target:self action:@selector(weChatLogin:)];
    weChatBtn.tag = 70*1;
    [self.view addSubview:weChatBtn];
    [weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdLabel.mas_bottom).offset(8);
        make.left.equalTo(weChatBtn.superview.mas_centerX).offset(43);
        make.width.equalTo(@51);
        make.height.equalTo(@51);
    }];
    
    
    
    UIView  * bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(weChatBtn.mas_centerY);
        make.width.equalTo(@0.5);
        make.height.equalTo(@25);
    }];


}


# pragma mark -
# pragma mark 切换密码可见不可见
- (void)changeYinCang:(UIButton*)btn{
    
    
    if (btn.selected ==YES) {
        pwdText.secureTextEntry = NO;
        btn.selected = NO;
        [btn setImage:[UIImage imageNamed:@"icon_xianshi"] forState:UIControlStateNormal];
        }
    
    else {
        pwdText.secureTextEntry = YES;
        btn.selected = YES;
        
        [btn setImage:[UIImage imageNamed:@"icon_yincang"] forState:UIControlStateNormal];
        
        
    }
    
    
    
}
-(void)backToHome{

  
    
    [self.navigationController popViewControllerAnimated:YES];

    [self saveLoginSession];
   


}
- (void)login {

    if ([self.userNameTextField.text isEqualToString:@""]||[self.passwordTextField.text isEqualToString:@""]) {
        [self showHint:@"信息不能为空"];
        return;
    }
      
    if (![XDCommonTool checkTel:self.userNameTextField.text]&&![XDCommonTool checkEmail:self.userNameTextField.text]) {
        [self showHint:@"请输入正确的手机号或者邮箱"];
        return;
    }
   
    [XDCommonTool saveToUserDefaultWithString:self.userNameTextField.text key:@"loginNumber"];
    
    
    NSDictionary  * dict = @{@"identify":self.userNameTextField.text,@"type":@1,@"pwd":self.passwordTextField.text};
    
    //个人信息存本地
    [XDCommonTool saveToUserDefaultWithString:self.userNameTextField.text key:@"userName"];
  
    [[NetworkClient sharedClient] POST:URL_LOGIN dict:dict succeed:^(id data) {
        LRLog(@"%@",data);
       if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
           [self showHint:@"登录成功"];
            [self saveLoginSession];
            
            
            NSDictionary  * userDict = [data objectForKey:@"result"];
            [XDCommonTool saveToUserDefaultWithBool:YES key:IS_LOGIN];
            
            //个人信息存本地
            [XDCommonTool saveToUserDefaultWithDic:userDict  key:USER_INFO];
           
            [XDCommonTool saveToUserDefaultWithString:self.userNameTextField.text  key:@"phone"];
            [XDCommonTool saveToUserDefaultWithString:self.passwordTextField.text  key:@"password"];

            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHint:[data objectForKey:@"error_msg"]];
        }
        
      
    
    } failure:^(NSError *error) {
       LRLog(@"%@",error);
   }];



}
- (void)registerClick:(UIButton *)sender {
   [self.navigationController pushViewController:[registerViewController new] animated:YES];


}

- (void)thiredClick:(UIButton *)sender {
   
    
    AppDelegate* tAppDel =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    tAppDel.m_ShareType = Share_QQFriend;
    UMSocialSnsPlatform  * snsPlatForm = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatForm.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        // 获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            //封装的方法(第三方注册)
           
            [XDCommonTool thirdRegisterWithUserID:snsAccount.usid withNickName:snsAccount.userName withImage:snsAccount.iconURL withUserNameType:@1];
            
}});
    

}
- (void)weChatLogin:(UIButton *)sender {
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view becomeFirstResponder];


}
- (void)searchPwdClick{
    [self.navigationController pushViewController:[lookPasswordViewController new] animated:YES];


}
# pragma mark -
# pragma mark 后台登录
-(void)BGLogin:(LoginSuccess)BGLogin{
 NSDictionary  * userDict =   [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];

   
    if ([[userDict objectForKey:@"mobile"] isEqualToString:@""]||[[XDCommonTool readStringFromUserDefaultWithKey:@"password"] isEqualToString:@""]) {
        return;
    }
    
    if (![[userDict allKeys] containsObject:@"qq_id"]&&![[userDict allKeys] containsObject:@"we_chat_id"]&&![[userDict allKeys] containsObject:@"mobile"]) {
        return;
    }
    
    NSDictionary  * dict = [NSDictionary new];
     //判断是第三方登录还是手机号登录
    if ([XDCommonTool readBoolFromUserDefaultWithKey:IS_THIRD_LOGIN]) {
       
        //判断是微信还是qq
        NSString  * openIdStr =    [[userDict allKeys] containsObject:@"qq_id"]?[userDict  objectForKey:@"qq_id"]:[userDict objectForKey:@"we_chat_id"];

        
        dict = @{@"identify":openIdStr,@"type":@2};
        

    }
    else{
        dict = @{@"identify":[[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO] objectForKey:@"mobile"],@"type":@1,@"pwd":[XDCommonTool readStringFromUserDefaultWithKey:@"password"]};
    }
    
    [[NetworkClient sharedClient] POST:URL_LOGIN dict:dict succeed:^(id data) {
        
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [self saveLoginSession];
            
            NSDictionary  * userDict = [data objectForKey:@"result"];
           [XDCommonTool saveToUserDefaultWithBool:YES key:IS_LOGIN];
            
            //个人信息存本地
            [XDCommonTool saveToUserDefaultWithDic:userDict  key:USER_INFO];
            
            
            
        }
        else{
            [XDCommonTool alertWithMessage:[data objectForKey:@"error_msg"]];
            
        }
        

    
    
    
    } failure:^(NSError *error) {
        
    }];
    

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


# pragma mark -
# pragma mark cookie信息

-(void)saveLoginSession{
       NSArray  * allCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
      for (NSHTTPCookie * cookies in allCookies) {
          if ([cookies.name isEqualToString:@"JSESSIONID"]) {
         NSMutableDictionary *cookiesDict = [NSMutableDictionary new];
            [cookiesDict setValue:cookies.properties forKey:@"cookieDict"];
             //设置cookie
              [[NSHTTPCookieStorage sharedHTTPCookieStorage]setCookie:cookies];
              
          }
    }

  }
- (void)saveCookie{

    NSUserDefaults  * userDe  = [NSUserDefaults standardUserDefaults];
    NSArray  * allCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie * cookies in allCookies) {
       
            NSMutableDictionary *cookiesDict = [NSMutableDictionary new];
            //[cookiesDict setValue:cookies.properties forKey:kLocalCookieName];
       }

}
@end
