//
//  XYBrowserImage.h
//  Essential-New
//
//  Created by 奕赏 on 16/8/29.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYBrowserImage : UIScrollView<UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) id smallImage;
@property (assign, nonatomic) id bigImage;
@property (assign, nonatomic) CGImageRef imageRef;
@property (strong, nonatomic) UIImage *image;

@property (copy, nonatomic) void(^singleTapDetected)();
@end
