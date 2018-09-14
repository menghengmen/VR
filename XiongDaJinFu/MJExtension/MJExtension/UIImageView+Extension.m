//
//  UIImageView+Extension.m
//  快看漫画
//
//  Created by 金亮齐 on 2016/12/19.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImage+Extension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Extension)

- (void)setRoundImageWithURL:(NSString *)url placeImageName:(NSString *)placeImage {
    
    __weak UIImageView *weakSelf = self;
    
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:[UIImage imageNamed:placeImage]
                     options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                         
                         __strong UIImageView *sself  = weakSelf;
                         
                         sself.image = [image clipEllipseImage]; //对图片进行倒圆角
                         
                     }];
    
    
}

@end
