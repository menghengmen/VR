//
//  CLPhotosVIew.m
//  高仿发微博
//
//  Created by darren on 16/6/24.
//  Copyright © 2016年 shanku. All rights reserved.
//

#import "CLPhotosVIew.h"
@interface CLPhotosVIew()

/***/
@property (nonatomic,strong) UIScrollView *scrollView;

/***/
@property (nonatomic,weak) UIImageView *imgView;

@end

@implementation CLPhotosVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)setPhotoArray:(NSArray *)photoArray
{
    _photoArray = photoArray;
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }

    for (int i = 0; i < photoArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:imageView];
    }
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat line = 3;
    CGFloat magin = 0;
    CGFloat magin2 = 5;
    CGFloat imageW = (self.frame.size.width-(line - 1)*magin2-2*magin)/line;
    CGFloat imageH = imageW;
    
    for (int i = 0; i < self.photoArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        self.imgView = imageView;
        [self.scrollView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = i + 10;
        imageView.userInteractionEnabled  = YES;
        imageView.image = self.photoArray[i];
        CGFloat imageX = magin + (magin2 + imageW)*(i%3);
        CGFloat imageY = (imageH + magin2)*(i/3);
        imageView.frame =  CGRectMake(imageX, imageY, imageW, imageH);
        
        if (i==(self.photoArray.count - 1)) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChooseImage)]];
        }
        
        // 加一个关闭按钮
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width-20, 0, 20, 20)];
        closeBtn.tag = i;
        if (i != (self.photoArray.count - 1)) {
            [closeBtn setBackgroundImage:[UIImage imageNamed:@"error_wine"] forState:UIControlStateNormal];
            [closeBtn addTarget:self action:@selector(removeImg:) forControlEvents:UIControlEventTouchUpInside];
            [self.imgView addSubview:closeBtn];
            
        }
    }
    
    NSInteger row = (self.photoArray.count-1)/line;
    self.scrollView.contentSize = CGSizeMake(0, self.frame.size.height + imageH*row);
}

- (void)removeImg:(UIButton *)btn
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.photoArray];
    [arr removeObjectAtIndex:btn.tag];
    self.photoArray = arr;
    [self layoutSubviews];
    
    self.clickcloseImage(btn.tag);
}


/**
 *  调用相册
 */
- (void)clickChooseImage
{
    self.clickChooseView();
}

@end
