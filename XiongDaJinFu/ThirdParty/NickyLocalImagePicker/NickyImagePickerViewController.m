//
//  NickyImagePickerViewController.m
//  NickyLocalImagePicker
//
//  Created by NickyTsui on 15/12/30.
//  Copyright © 2015年 com.nickyTsui. All rights reserved.
//

#import "NickyImagePickerViewController.h"
#import "NickyPhotoAlbumListViewController.h"
#import "NickyCategoryTools.h"
@interface NickyImagePickerViewController ()
@property (strong,nonatomic)NickyPhotoAlbumListViewController       *albumListController;
@end

@implementation NickyImagePickerViewController

- (instancetype)init{
    self = [super initWithRootViewController:self.albumListController];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    /** 设置导航栏样式 */
    [self settingNavigationBar];
    
    // Do any additional setup after loading the view.
}
- (void)settingNavigationBar{
    [self.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#49484C" alpha:.95]] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:19]};

    
    [self.navigationBar setTintColor:[UIColor whiteColor]];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (NickyPhotoAlbumListViewController *)albumListController{
    if (!_albumListController){
        _albumListController = [[NickyPhotoAlbumListViewController alloc]init];
    }
    return _albumListController;
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
