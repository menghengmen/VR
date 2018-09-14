//
//  UIImage+NickyAddition.m
//  NickyLocalImagePicker
//
//  Created by NickyTsui on 15/12/30.
//  Copyright © 2015年 com.nickyTsui. All rights reserved.
//

#import "NickyCategoryTools.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation UIColor (NickyAddition)
+ (UIColor *)colorWithHexString:(NSString *)color{
    return [UIColor colorWithHexString:color alpha:1];
}

+ (UIColor*) colorWithHexString:(NSString*)color alpha:(float)opacity
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:opacity];
    
}

@end

@implementation UIImage (NickyAddition)
+ (UIImage*)createImageWithColor:(UIColor*)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end

@implementation UIImageView(NickyAddition)

- (void)loadLibraryBigImage:(NSURL *)alassetURL placeImage:(UIImage *)placeImage finishBlock:(NickyBigPhotoLoadFinish)finishBlock{
    self.image = placeImage;
    ALAssetsLibrary *libiary = [[ALAssetsLibrary alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        __block UIImage *loadImage = nil;
        [libiary assetForURL:alassetURL resultBlock:^(ALAsset *asset) {
            loadImage = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                if (finishBlock){
                    finishBlock(loadImage,asset.defaultRepresentation.size);
                }
                if (loadImage){
                    self.image = loadImage;
                }
            });
            
        } failureBlock:^(NSError *error) {
            
        }];
    });

}

@end
