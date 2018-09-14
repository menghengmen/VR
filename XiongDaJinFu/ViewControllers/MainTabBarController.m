//
//  MainTabBarController.m
//  Yueshijia
//
//  Created by CosyVan on 2016/11/20.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "MainTabBarController.h"

#import "HomePageViewController.h"
#import "HoneyBottleViewController.h"
#import "MyAccountViewController.h"
#import "CustomNavigationController.h"
#import "MainViewController.h"
#import "MyTabBar.h"
#import <objc/runtime.h>
@interface MainTabBarController ()<UITabBarDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomePageViewController *homeVC = [[HomePageViewController alloc] init];
    homeVC.title = @"首页";
    [self addChildVC:homeVC imageName:@"tab_icon_home" selectedImageName:@"tab_icon_home_pr-1"];
    
    HoneyBottleViewController *specialVC = [[HoneyBottleViewController alloc] init];
    specialVC.title = @"大学";
    [self addChildVC:specialVC imageName:@"tab_icon_quanzi" selectedImageName:@"tab_icon_daxue_pr-1"];
    
    
    MainViewController *meVC = [[MainViewController alloc] init];
       meVC.title = @"我的";
    [self addChildVC:meVC imageName:@"tab_icon_person" selectedImageName:@"tab_icon_geren_pr"];
    
   MyTabBar *myTabBar = [[MyTabBar alloc] init];
    myTabBar.delegate = self;
    [self setValue:myTabBar forKey:@"tabBar"];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    for (UITabBarItem *item1 in tabBar.subviews) {
//        if (item1 == item) {
//            for (<#type *object#> in <#collection#>) {
//                <#statements#>
//            }
//            objc_setAssociatedObject(item1, @"isSelectItem", [NSNumber numberWithBool:true], OBJC_ASSOCIATION_COPY_NONATOMIC);
//        }else{
//            objc_setAssociatedObject(item1, @"isSelectItem", [NSNumber numberWithBool:false], OBJC_ASSOCIATION_COPY_NONATOMIC);
//        }
//    }
    
    for (UIView *view in tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
        }
    }
}

- (void)addChildVC:(UIViewController *)childVc imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    
    UIEdgeInsets   insets = UIEdgeInsetsMake(4, 0, -4, 0);
    childVc.tabBarItem.imageInsets = insets;
    
    
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    
    //设置文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#999999"];

    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor clearColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 添加为tabbar控制器的子控制器
    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}

- (BOOL)shouldAutorotate{
    
    return self.selectedViewController.shouldAutorotate;
    
}

@end
