//
//  NickyPhotoAlbumModel.m
//  NickyLocalImagePicker
//
//  Created by NickyTsui on 15/12/30.
//  Copyright © 2015年 com.nickyTsui. All rights reserved.
//

#import "NickyPhotoAlbumModel.h"


@implementation NickyPhotoAlbumModel


- (NSMutableArray *)photoArray{
    if (!_photoArray){
        _photoArray = [[NSMutableArray alloc]init];
    }
    return _photoArray;
}

@end


@implementation NickyPhotoAlAssetModel

- (void)setPhotoURL:(NSURL *)photoURL{
    _photoURL = [photoURL copy];
    ALAssetsLibrary *libiary = [[ALAssetsLibrary alloc]init];
    // 设置图片url 时,获取相片的封面图 并放置到本model中缓存
    [libiary assetForURL:photoURL resultBlock:^(ALAsset *asset) {
        self.thumbsImage = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
    } failureBlock:^(NSError *error) {
        
    }];
}

@end
