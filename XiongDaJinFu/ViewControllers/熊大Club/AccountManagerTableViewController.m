//
//  AccountManagerTableViewController.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/2.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "AccountManagerTableViewController.h"
#import "UMSocial.h"
#import "YJPersonInfoCell.h"
#import "changePhoneViewController.h"
#import "boundPhoneViewController.h"
@interface AccountManagerTableViewController ()<UITableViewDelegate,UITableViewDataSource,YJPersonInfoCellDelegate,WXApiDelegate,TDAlertViewDelegate>

@property  (nonatomic,strong)   NSArray  * itemArray;
//右边的数据源
@property (nonatomic, strong) NSMutableArray *detailArray1;
@property(nonatomic,strong)  UITableView  * tableView;

@end

@implementation AccountManagerTableViewController


- (NSArray*)itemArray{
    
    if (!_itemArray) {
        NSMutableArray *a1 = [NSMutableArray arrayWithArray:@[@"手机",@"邮箱",@"QQ",@"微信"]];
//        NSMutableArray *a2 = [NSMutableArray arrayWithArray:@[@"清除缓存",@"用户反馈",@"帮助",@"关于我们" ]];
        
        NSMutableArray *a2 = [NSMutableArray arrayWithArray:@[@"清除缓存",@"用户反馈",@"关于我们" ]];
        
        NSArray *arr = @[a1, a2];
        _itemArray = [NSMutableArray arrayWithArray:arr];
    
    }
    
    return _itemArray;
}

- (NSMutableArray*)detailArray1{
    
    if (!_detailArray1) {
        
        
        
        if (![XDCommonTool readBoolFromUserDefaultWithKey:IS_LOGIN]) {
            _detailArray1 = [NSMutableArray arrayWithObjects:@"未设置",@"未设置",@"未设置",@"未设置",nil];

        }else{
            _detailArray1 = [[NSMutableArray alloc] init];

        }
    
    
    }
    return _detailArray1;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wechatSuc:)
                                                 name:LOGIN_WECHATSUC
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getData)
                                                 name:BOUND_SUC
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearMessage) name:LOGIN_EXPIRE object:nil];
    
    
    
    [self setUpNewNai:nil Title:@"设置"];
    UITableView  * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
    tableView.tableHeaderView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    tableView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    tableView.scrollEnabled = NO;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [self setupui];
}

-(void)setupui{
    UIButton  * logoutBtn =     [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:nil buttonTitle:@"退出登录" target:self action:@selector(logout)];
    logoutBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    logoutBtn.layer.borderWidth = 0.5f;
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    logoutBtn.layer.borderColor = [[UIColor colorWithHexString:@"#28a8e0"] CGColor];
    [logoutBtn setTitleColor:[UIColor colorWithHexString:@"#28a8e0"] forState:UIControlStateNormal];
    logoutBtn.layer.cornerRadius = 6;
    
       if (![XDCommonTool readBoolFromUserDefaultWithKey:IS_LOGIN])
           return;
 
           [self.view addSubview:logoutBtn];

    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(logoutBtn.superview.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(500 -64);
//        make.width.equalTo(@(496*SCREENHEIGHT/1334));
        make.height.equalTo(@(68*SCREENHEIGHT/1334));
        make.left.equalTo(self.view.mas_left).offset(28);
        make.right.equalTo(self.view.mas_right).offset(-28);
    }];
}
#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.itemArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.itemArray[section] count];
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_MAIN.width, 30)];
    
    UILabel* LABEL = [XDCommonTool newlabelWithTextColor:[UIColor colorWithHexString:@"#999999"] withTitle:nil fontSize:10];
    LABEL.textAlignment = NSTextAlignmentLeft;
    
    if(section == 0){
     LABEL.text = @" 账户绑定";
    }else{
        LABEL.text = @" 系统支持";

    }
    [view addSubview:LABEL];
    [LABEL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.bottom.equalTo(view).offset(-5);
    }];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJPersonInfoCell *cell = [YJPersonInfoCell personInfoCellWithTableView:tableView];
    cell.delegate = self;
    //cell左边的数据
    NSArray  * arr = self.itemArray[indexPath.section];
    cell.name.text = arr[indexPath.row];
    [cell.name setTextColor:[UIColor colorWithHexString:@"#666666"] ];
    if (indexPath.row == [self.itemArray[indexPath.section] count] -1) {
        cell.line.hidden = true;
    }else{
        cell.line.hidden = false;
    }
    
    //cell右边的数据
    NSString *nameStr = self.detailArray1[indexPath.row];
    if (indexPath.section==0) {
        cell.text.text = nameStr;
        [cell.text setTextColor:[UIColor colorWithHexString:@"#666666"] ];
        

    }
    
    if ([nameStr isEqualToString:@"未绑定"]) {
        cell.text.textColor = [UIColor colorWithHex:0xcccccc];
    }else{
        cell.text.textColor = [UIColor colorWithHex:0x666666];
    }
    if (indexPath.section == 1) {
        if(indexPath.row ==0){
            //缓存大小
            NSArray *pathcaches=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString* cacheDirectory  = [pathcaches objectAtIndex:0];
            float cacheSize = [XDCommonTool folderSizeAtPath:cacheDirectory];
            cell.text.text =[NSString stringWithFormat:@"%.1fM",cacheSize];
        }
       if (indexPath.row==2) {
            NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            cell.text.text = version;
        }
    
    
    
    
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![XDCommonTool readBoolFromUserDefaultWithKey:IS_LOGIN]) {
        if (indexPath.section == 0) {

        [XDCommonTool alertWithMessage:@"请登录"];
        return;
        }
    }
    
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                NSDictionary  * userDict =   [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];

                if( [[userDict allKeys]containsObject:@"mobile"]){
                
                    changePhoneViewController  * changge = [changePhoneViewController new];
                    changge.chanegType = PhonesType;
                    changge.typeStr = @"手机";
                     [self.navigationController pushViewController:changge animated:YES];
                }
                else{
                    
                    boundPhoneViewController  * bound = [boundPhoneViewController new];
                    bound.typeStr = @"手机";
                    [self.navigationController pushViewController:bound animated:YES];
                }
              
           
            }
                
                break;
                
            case 1:{
                NSDictionary  * userDict =   [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];

                if( [[userDict allKeys]containsObject:@"email"]){

                
                changePhoneViewController  * changge = [changePhoneViewController new];
                changge.chanegType = MailType;
                [self.navigationController pushViewController:changge animated:YES];
                
                }
                else{
                
                    boundPhoneViewController  * bound = [boundPhoneViewController new];
                    
                    bound.typeStr = @"邮箱";
                    [self.navigationController pushViewController:bound animated:YES];
                }
                
            }
                
                break;
            
            
            
            case 2:
                [[[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO] allKeys] containsObject:@"qq_nick_name"]?[self unBoundQQ]:[self boundQQ];
                break;
            case 3:
                
                [[[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO] allKeys] containsObject:@"we_chat_nick_name"]?[self unBoundWeChat]:                [self boundWeChat];
                break;
                
            default:
                break;
        }

    }
    
    
    
    if (indexPath.section ==1) {
       
        switch (indexPath.row) {
            case 0:
                [self clearHuanCun];
               
                
                break;
            case 1:{
                //跳转到评分界面
                NSString *str1 = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1181307830";
                
                //[NSString stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@", @"1094156447"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str1]];
                break;
            }
            default:
                break;
        }
       
   
    }


}
-(void)clearHuanCun{
    NSArray *pathcaches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSLog(@"%@",pathcaches);
    NSString* cacheDirectory = [pathcaches objectAtIndex:0];
    [XDCommonTool clearCache:cacheDirectory];
    //        [aTableview reloadData];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    [self showHint:@"清除缓存成功"];


}
# pragma mark -
# pragma mark 微信绑定
-(void)boundWeChat{
    AppDelegate* tAppDel =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    tAppDel.m_ShareType = Share_WeChat;
    SendAuthReq  * req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"; // @"post_timeline,sns"
    req.state = @"123";
    req.openID = URL_WECHAT_APPID;
    tAppDel = [UIApplication sharedApplication].delegate;
    tAppDel.wxDelegate = self;
    
    [WXApi sendReq:req];

}
-(void) wechatSuc:(NSNotification*) notification{
    NSLog(@"code %@",notification);
    
    
    NSDictionary  * dict1 = notification.userInfo;
    
    NSString  * codeStr = [dict1 objectForKey:@"code"];
    
    [XDCommonTool requestWeChatInfo:^(NSDictionary *tJsonDic) {
        NSLog(@"success%@",tJsonDic);
        
        [XDCommonTool boundWithID:[[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO]  objectForKey:@"id"] openId:[tJsonDic objectForKey:@"openid"] nickName:[tJsonDic objectForKey:@"nickname"] type:@"2"];
    } fail:^(NSDictionary *tJsonDic) {
        NSLog(@"error%@",tJsonDic);
    } code:codeStr];
}
# pragma mark -
# pragma mark QQ绑定

-(void)unBoundQQ{
    [[NetworkClient sharedClient] POST:URL_UNBOUND dict:@{@"client_id":[[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO]  objectForKey:@"id"],@"type":@1} succeed:^(id data) {
        LRLog(@"fdsfdsf%@",data);
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [self getData];
            [XDCommonTool alertWithMessage:@"解绑成功"];
        }

    
    
    } failure:^(NSError *error) {
        LRLog(@"fdsfdsf%@",error);

    }];



}
-(void)unBoundWeChat{
    [[NetworkClient sharedClient] POST:URL_UNBOUND dict:@{@"client_id":[[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO]  objectForKey:@"id"],@"type":@2} succeed:^(id data) {
        LRLog(@"wechatfdsfdsf%@",data);
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [self getData];
            [XDCommonTool alertWithMessage:@"解绑成功"];

        }
    } failure:^(NSError *error) {
        LRLog(@"fdsfdsf%@",error);
        
    }];
    
    
    
}



- (void)boundQQ{
   
    AppDelegate* tAppDel =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    tAppDel.m_ShareType = Share_QQFriend;
    UMSocialSnsPlatform  * snsPlatForm = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatForm.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        // 获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            LRLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
              [XDCommonTool boundWithID:[[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO] objectForKey:@"id"] openId:snsAccount.usid nickName:snsAccount.userName type:@"1"];
            }});
}

# pragma mark -
# pragma mark TDAlertViewDelegate
- (void)alertView:(TDAlertView *)alertView didClickItemWithIndex:(NSInteger)itemIndex{
    
    if (itemIndex==0) {
        LRLog(@"%ld",(long)itemIndex);

    }else{
    
        [self sureLogout];
    }



}



# pragma mark -
# pragma mark 退出登录
- (void)logout{

    [self alertWithMessage:@"退出登录" withLittleMessage:@"你确定要退出登录吗？"];
    
  
}
-(void)sureLogout{

    [[NetworkClient sharedClient] POST:URL_LOGOUT dict:nil succeed:^(id data) {
        LRLog(@"退出登录%@",data);
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [self clearMessage];
            [XDCommonTool alertWithMessage:@"退出成功"];
              //退出成功
              [[NSNotificationCenter defaultCenter ] postNotificationName:LOGINOUT_SUCCESS object:self ];
            //[self.navigationController pushViewController:[loginViewController new] animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        LRLog(@"退出登录%@",error);
        
    }];


}
- (void)clearMessage{
    [XDCommonTool removeIdForKey:IS_LOGIN];
    [XDCommonTool removeIdForKey:USER_INFO];
    [XDCommonTool removeIdForKey:@"password"];
    [XDCommonTool removeIdForKey:IS_THIRD_LOGIN];

    
    NSArray  * allCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        for (NSHTTPCookie * cookies in allCookies) {
            if ([cookies.name isEqualToString:@"JSESSIONID"]) {
                NSMutableDictionary *cookiesDict = [NSMutableDictionary new];
                [cookiesDict setValue:cookies.properties forKey:@"cookieDict"];
                [[NSHTTPCookieStorage sharedHTTPCookieStorage]deleteCookie:cookies];
                
            }
        }
        
    
}
-(void)getData{
    
    NSString  * idStr = [[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO] objectForKey:@"id"];
    
    if (![XDCommonTool readBoolFromUserDefaultWithKey:IS_LOGIN]) {
        return;
    }
    
    [[NetworkClient sharedClient] POST:[NSString stringWithFormat:@"%@/%@",URL_USERINFO,idStr] dict:nil succeed:^(id data) {
        LRLog(@"das ds, .f%@",data);
       
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [XDCommonTool saveToUserDefaultWithDic:[data objectForKey:@"result"] key:USER_INFO];
           
          }
        
        NSDictionary  * userDict =   [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
        
       
        NSMutableString* phoneStr = [NSMutableString new];
       phoneStr = [[userDict allKeys] containsObject:@"mobile"]?[userDict objectForKey:@"mobile"]:@"未绑定";
        if ([[userDict allKeys]containsObject:@"mobile"]) {
             phoneStr = [ userDict[@"mobile"] mutableCopy];
            [phoneStr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }
        
         NSString  * mailStr =  [[userDict allKeys] containsObject:@"email"]?[userDict objectForKey:@"email"]:@"未绑定";
        
              
        
        
        
        NSString  * weChatStr =  [[userDict allKeys] containsObject:@"we_chat_nick_name"]?[userDict objectForKey:@"we_chat_nick_name"]:@"未绑定";
        
        NSString  * QQStr =  [[userDict allKeys] containsObject:@"qq_nick_name"]?[userDict objectForKey:@"qq_nick_name"]:@"未绑定";
       
       
       self.detailArray1 = [NSMutableArray arrayWithObjects:phoneStr, mailStr,QQStr,weChatStr ,nil];
        [self.tableView reloadData];
    
    } failure:^(NSError *error) {
        LRLog(@"das ds, .f%@",error);
    }];
}
@end
