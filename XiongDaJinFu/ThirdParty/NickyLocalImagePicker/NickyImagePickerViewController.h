//
//  NickyImagePickerViewController.h
//  NickyLocalImagePicker
//
//  Created by NickyTsui on 15/12/30.
//  Copyright © 2015年 com.nickyTsui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NickyImagePickerDelegate;
@interface NickyImagePickerViewController : UINavigationController
/**
 *  代理对象
 */
@property (weak,nonatomic) id <NickyImagePickerDelegate>        pickerDelegate;
@end

@protocol NickyImagePickerDelegate <NSObject>
/**
 *  代理方法 - 选择完成后回调
 *
 *  @param picker     选择器对象
 *  @param imageArray 图片数组 元素为UIImage
 */
- (void)nickyImagePicker:(NickyImagePickerViewController *)picker didSelectedImages:(NSArray<UIImage*> *)imageArray;

@end