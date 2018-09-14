//
//  XYZiXunWebViewController.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/5/6.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZiXunWebViewController : UMengViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *title;
@end
