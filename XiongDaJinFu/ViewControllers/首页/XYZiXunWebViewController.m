//
//  XYZiXunWebViewController.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/5/6.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYZiXunWebViewController.h"

@interface XYZiXunWebViewController ()<UIWebViewDelegate>

@end

@implementation XYZiXunWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.navigationController.navigationItem.titleView = [UILabel navigationTitleLabelWithText:self.title];
    [MBProgressHUD showIndicatorMessage:@"加载中" toView:self.view];
    [self initTool];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.backgroundColor = [UIColor whiteColor];
    
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)initTool{
    UIView *siftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:siftView];
    
    UIButton *sift = [UIButton buttonWithType:UIButtonTypeCustom];
    [sift setImage:[UIImage imageNamed:@"icon_kefu"] forState:UIControlStateNormal];
    sift.tag = 101;
    sift.titleLabel.font = [UIFont systemFontOfSize:15];
    [sift addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    sift.frame = CGRectMake(10, 0, 40, 40);
    [sift setTitleColor:[UIColor colorWithHex:0x29a7e1] forState:UIControlStateNormal];
    [siftView addSubview:sift];
}

-(void)btnClick:(UIButton *)sender{
    if ([QQApiInterface isQQInstalled]) {
        NSString *qqStr=[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",consultQQ];
        NSURL *url = [NSURL URLWithString:qqStr];
        [[UIApplication sharedApplication] openURL:url];
    }else{
        //            TDAlertItem *item1 = [[TDAlertItem alloc] initWithTitle:@"取消"];
        TDAlertItem *item2 = [[TDAlertItem alloc] initWithTitle:@"确定"];
        item2.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
        item2.titleColor = [UIColor colorWithHexString:@"fffefe"];
        TDAlertView *alert = [[TDAlertView alloc] initWithTitle:@"提醒" message:@"本机尚未安装QQ，请先行安装" items:@[item2] delegate:nil];
        alert.hideWhenTouchBackground = NO;
        
        [alert show];
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view];
    [MBProgressHUD showError:@"加载失败，请重试！"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
