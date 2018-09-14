//
//  NickyPhotoPreviewController.h
//  NickyLocalImagePicker
//
//  Created by NickyTsui on 15/12/30.
//  Copyright © 2015年 com.nickyTsui. All rights reserved.
//

#import "NickyPhotoPickerBaseViewController.h"
#import "NickyPhotoAlbumModel.h"

@interface NickyPhotoPreviewController : NickyPhotoPickerBaseViewController

@property (assign,nonatomic)NSInteger                   currentPage;

@property (strong,nonatomic)NSArray                     *photoArray;

@property (assign,nonatomic,getter=isSelectedMode)BOOL                        selectedMode;

@end
