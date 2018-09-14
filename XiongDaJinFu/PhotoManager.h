//
//  PhotoManager.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/5/3.
//  Copyright © 2017年 digirun. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@protocol PhotoPickDelegate <NSObject>

- (void)imagePicker:(UIImage *)image;

- (void)imagePickerDidCancel;

- (void)videoPickerTimeError;

- (void)videoPickerSuc:(NSString*)outPath;

- (void)videoPickerError:(AVAssetExportSessionStatus)status;

- (void)videoPickerDidCancel;

@end

@interface PhotoManager : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property (nonatomic,weak) id<PhotoPickDelegate> delegate;
+ (id)shareInstance;
- (void)showNormalPicker:(UIViewController *)root;
- (void)showCameraPicker:(UIViewController *)root;

/**
 * 选取本地视频
 * @Param
 * @Return
 */
- (void)showLocalVideoPicker:(UIViewController *)root;
/**
 * 自己拍摄
 * @Param
 * @Return
 */
- (void)showCameraVideoPicker:(UIViewController *)root;
@end
