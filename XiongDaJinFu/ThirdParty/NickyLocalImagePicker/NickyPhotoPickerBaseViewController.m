//
//  NickyPhotoPickerBaseViewController.m
//  NickyLocalImagePicker
//
//  Created by NickyTsui on 15/12/30.
//  Copyright © 2015年 com.nickyTsui. All rights reserved.
//

#import "NickyPhotoPickerBaseViewController.h"
@interface NickyPhotoPickerBaseViewController ()

@end

@implementation NickyPhotoPickerBaseViewController


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self didRotateFromInterfaceOrientation:self.interfaceOrientation];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.rightBarButtonItem = self.rightCloseButton;

    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)closeSelf:(id)sender{
    [self.naviController dismissViewControllerAnimated:YES completion:nil];
}

- (NickyImagePickerViewController *)naviController{
    return (NickyImagePickerViewController*)self.navigationController;
}

- (UIBarButtonItem *)rightCloseButton{
    if (!_rightCloseButton){
        _rightCloseButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(closeSelf:)];
    }
    return _rightCloseButton;
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
