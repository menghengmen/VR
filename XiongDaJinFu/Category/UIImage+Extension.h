//
//  UIImage+Extension.h
//  Essential-New
//
//  Created by 奕赏 on 16/8/26.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface UIImage (Extension)

/**
 * 按照原比例压缩到100k
 */
+(NSData *)compressAccordingToproportionImage:(UIImage *)oldImage;

/**
 *  按照指定压缩比压缩(比例不变),Proportion(0~1)
 */
+(NSData *)compressImage:(UIImage *)oldImage AccordingToProportion:(CGFloat)Proportion;

/**
 *  按照尺寸压缩
 */
+(UIImage *)compressImage:(UIImage *)oldImage AccordingToSize:(CGSize)size;

/**
 *  按照指定字节压缩
 */
+(NSData *)compressIMage:(UIImage *)oldImage ArrordingToBT:(CGFloat)million;
+ (UIImage *)thumbnailForAsset:(ALAsset *)asset maxPixelSize:(NSUInteger)size;
@end
