//
//  UIImage+NickyAddition.h
//  NickyLocalImagePicker
//
//  Created by NickyTsui on 15/12/30.
//  Copyright © 2015年 com.nickyTsui. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^NickyBigPhotoLoadFinish)(UIImage *image , NSInteger imageSize);


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface UIColor (NickyAddition)

+ (UIColor*) colorWithHexString:(NSString*)color;
+ (UIColor*) colorWithHexString:(NSString*)color alpha:(float)opacity;
@end


@interface UIImage (NickyAddition)
/**
 *  通过颜色创建image对象
 *
 *  @param color 颜色
 *
 *  @return UIImage对象
 */
+ (UIImage*)createImageWithColor:(UIColor*)color;

@end

@interface UIImageView (NickyAddition)
/**
 *  通过图片url加载大图(多线程加载)
 *
 *  @param alassetURL  图片在相册的url
 *  @param placeImage  占位图
 *  @param finishBlock 完成后回调的block
 */
- (void)loadLibraryBigImage:(NSURL *)alassetURL placeImage:(UIImage *)placeImage finishBlock:(NickyBigPhotoLoadFinish)finishBlock;
@end