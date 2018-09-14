//
//  XYMapViewController.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/12.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYMapViewController.h"

@interface XYMapViewController ()<UIWebViewDelegate>

@end

@implementation XYMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_MAIN.width, SCREEN_MAIN.height -64)];
    web.delegate = self;
    [self.view addSubview:web];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
