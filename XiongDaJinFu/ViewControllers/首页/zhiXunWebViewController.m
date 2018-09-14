//
//  zhiXunWebViewController.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/5/8.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "zhiXunWebViewController.h"

@interface zhiXunWebViewController ()<UIWebViewDelegate>

@end

@implementation zhiXunWebViewController


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [MBProgressHUD showIndicatorMessage:@"加载中" toView:self.view];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNewNai:nil Title:self.titleStr];
    

    NSURLRequest  * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    
    UIWebView  * web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
    web.delegate = self;
    [web loadRequest:request];
    [self.view addSubview:web];
    
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view];
    [MBProgressHUD showError:@"加载失败，请重试！"];
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
