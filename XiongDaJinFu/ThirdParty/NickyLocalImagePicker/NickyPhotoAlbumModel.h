//
//  NickyPhotoAlbumModel.h
//  NickyLocalImagePicker
//
//  Created by NickyTsui on 15/12/30.
//  Copyright © 2015年 com.nickyTsui. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class NickyPhotoAlAssetModel;


@interface NickyPhotoAlbumModel : NSObject

@property (copy,nonatomic)   NSData                  *thumbImageData;

@property (copy,nonatomic)   NSString                *albumName;

@property (assign,nonatomic) NSInteger                albumCount;

@property (strong,nonatomic) NSMutableArray          *photoArray;



@end

@interface NickyPhotoAlAssetModel : NSObject

@property (copy,nonatomic)                        NSURL                     *photoURL;

@property (assign,nonatomic,getter=isSelected)    BOOL                       selected;

@property (strong,nonatomic) UIImage                                        *thumbsImage;

@property (strong,nonatomic) UIImage                                        *detailImage;

@property (assign,nonatomic) NSInteger                                      oriaginalSize;

@end

