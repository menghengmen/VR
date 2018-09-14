//
//  CustomNavigationController.m
//  CustomNavigationBarDemo
//
//  Created by gary on 16/12/1.
//  Copyright © 2016年 digirun. All rights reserved.
//


#import "CustomNavigationController.h"

@implementation CustomNavigationController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //self.wantsFullScreenLayout = YES;

    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //self.wantsFullScreenLayout = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
   
     
    [self setNavigationBarHidden:NO];       // 使导航条有效
    [self.navigationBar setHidden:YES];     // 隐藏导航条，但由于导航条有效，系统的返回按钮页有效，所以可以使用系统的右滑返回手势。
    _orientationMask = UIInterfaceOrientationMaskPortrait;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)bCanDragBack
{
    if (IsiOS7Later)
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }else{}
}

#pragma mark - rotate
#pragma mark -
-(BOOL)shouldAutorotate

{//是否支持自动旋转
    
    return NO;
    
}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return _orientationMask;
//}

-(NSUInteger)supportedInterfaceOrientations{
    //return UIInterfaceOrientationMaskLandscapeRight;
    return self.orietation;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != self.orietation);
}



- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"alu_navbar_left_highlight"] forState:UIControlStateHighlighted];
        self.navigationBar.backgroundColor = [UIColor whiteColor];
//        [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//        [self.navigationBar setShadowImage:nil];
        CGRect frame = button.frame;
        frame.size = CGSizeMake(50, 30);
        button.frame = frame;
        
        // 让按钮内部的所有内容左对齐
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 让按钮的内容往左边偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        
//        viewController.hidesBottomBarWhenPushed = YES;
//        UIView *view = [[UIView alloc] init];
//        view.frame = CGRectMake(0, 0, 40, 40);
//        UIButton *button = [[UIButton alloc] init];
//        button.titleLabel.font = [UIFont systemFontOfSize:14];
//        [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//        //        [button setTitle:@"返回" forState:UIControlStateNormal];
//        button.frame = CGRectMake(0, 0, 40, 40);
//        //        CGFloat titleDisplacement = 5;
//        CGFloat contentDisplacement = 10;
//        //        button.titleEdgeInsets = UIEdgeInsetsMake(0, -titleDisplacement, 0, titleDisplacement);
//        button.contentEdgeInsets = UIEdgeInsetsMake(0, -contentDisplacement, 0, contentDisplacement);
//        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:button];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    if (self.backButtonClickBlock) {
        self.backButtonClickBlock();
    }
    [self popViewControllerAnimated:YES];
}


@end
