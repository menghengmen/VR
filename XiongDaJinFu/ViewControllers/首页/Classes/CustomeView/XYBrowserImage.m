//
//  XYBrowserImage.m
//  Essential-New
//
//  Created by 奕赏 on 16/8/29.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import "XYBrowserImage.h"

@implementation XYBrowserImage
{
    BOOL isBig;
}
#define SCREENSIZE [UIScreen mainScreen].bounds.size
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:imageView];
        self.imageView =imageView;
        self.bounces =false;
        self.showsVerticalScrollIndicator =NO;
        self.showsHorizontalScrollIndicator =NO;
        self.minimumZoomScale =1.0f;
        self.maximumZoomScale =2.0;
        self.delegate =self;
        imageView.contentMode =UIViewContentModeScaleAspectFit;
        self.contentSize =frame.size;
        isBig =NO;
        
        self.userInteractionEnabled =YES;
        self.imageView.userInteractionEnabled =YES;
        self.imageView.multipleTouchEnabled =YES;
        
        //单击手势
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        [self.imageView addGestureRecognizer:singleTap];
        
        //双击手势
        UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleClick:)];
        doubleTap.numberOfTouchesRequired =1;
        doubleTap.numberOfTapsRequired =2;
        [self.imageView addGestureRecognizer:doubleTap];
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
        
    }
    return self;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    self.contentSize =CGSizeMake(SCREENSIZE.width *self.zoomScale, SCREENSIZE.height *self.zoomScale);
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    if (scale !=1.0f) {
        isBig =YES;
    }
}

-(void)singleTap:(UITapGestureRecognizer *)sender{
    if (self.singleTapDetected) {
        self.singleTapDetected();
    }
}

-(void)doubleClick:(UITapGestureRecognizer *)sender{
    CGPoint point =[sender locationInView:self.imageView];
    CGFloat scale =isBig?1.0:2.0;
    
    CGFloat oldXScale =point.x /SCREENSIZE.width;
    CGFloat oldYScale =point.y /SCREENSIZE.height;
    [UIView animateWithDuration:0.5f animations:^{
        self.contentSize =CGSizeMake(SCREENSIZE.width *scale, SCREENSIZE.height *scale);
        self.imageView.size =self.contentSize;
        CGPoint movePoint =CGPointMake(SCREENSIZE.width *scale *oldXScale, SCREENSIZE.height *scale *oldYScale);
        self.contentOffset =CGPointMake(movePoint.x -point.x, movePoint.y -point.y);
    } completion:^(BOOL finished) {
    }];
    isBig =!isBig;
}

-(void)setImageRef:(CGImageRef)imageRef{
    _imageRef =imageRef;
    self.imageView.image =[UIImage imageWithCGImage:imageRef];
//    CGImageGetWidth(imageRef);
    self.contentSize =CGSizeMake(SCREENSIZE.width, SCREENSIZE.height);
}

-(void)setImage:(UIImage *)image{
    _image =image;
    self.imageView.image =image;
    self.contentSize =CGSizeMake(SCREENSIZE.width, SCREENSIZE.height);
//    [self layoutSubviews];
}




@end
