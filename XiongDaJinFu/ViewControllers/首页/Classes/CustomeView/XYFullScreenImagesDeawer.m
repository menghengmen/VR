//
//  XYFullScreenImagesDeawer.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/17.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYFullScreenImagesDeawer.h"
#import "XYBrowserImage.h"
@interface XYFullScreenImagesDeawer()<UIScrollViewDelegate>
@property (nonatomic,strong)UIImageView *moveImageView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)UILabel *desLabel;//描述label
@property (nonatomic,strong)UILabel *numLabel;//计数label
@end
@implementation XYFullScreenImagesDeawer
{
    XYBrowserImage *leftImage;
    XYBrowserImage *midImage;
    XYBrowserImage *rightImage;
    NSInteger _currentImageIndex;
    NSInteger _leftImageIndex;
    NSInteger _rightImageIndex;
    UIView *_formView;
}

+(instancetype)sharedImageBrawer{
    static XYFullScreenImagesDeawer *imageBrawer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageBrawer = [[XYFullScreenImagesDeawer alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        imageBrawer.userInteractionEnabled = true;
        imageBrawer.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
    });
    return imageBrawer;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.scrollView];
        
        [self addSubview:self.moveImageView];
        for (int i =0; i<3; i++) {
            XYBrowserImage *image1 =[[XYBrowserImage alloc]initWithFrame:CGRectMake(SCREEN_MAIN.width*i, 0, SCREEN_MAIN.width, SCREEN_MAIN.height)];
            //        image1.delegate =self;
            if (i ==0) {
                leftImage =image1;
            }else if (i ==1){
                midImage =image1;
            }else if (i ==2){
                rightImage =image1;
            }
            [self.scrollView addSubview:image1];
            
            
            image1.singleTapDetected =^(){
                [self removeSelf1];
            };
            
        }
        
        [self addSubview:self.desLabel];
        [self addSubview:self.numLabel];
    }
    return self;
}

-(UIImageView *)moveImageView{
    if (!_moveImageView) {
        _moveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _moveImageView.contentMode =UIViewContentModeScaleAspectFit;
        _moveImageView.alpha =0.0f;
    }
    return _moveImageView;
}

-(UILabel *)desLabel{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, SCREEN_MAIN.height - 40, SCREEN_MAIN.width - 15 -15 - 10 -60, 35)];
        _desLabel.font = [UIFont systemFontOfSize:14];
        _desLabel.alpha = 0.0f;
        _desLabel.textAlignment = NSTextAlignmentLeft;
        _desLabel.textColor = [UIColor whiteColor];
        _desLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    }
    return _desLabel;
}

-(UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_MAIN.width -15 -60, SCREEN_MAIN.height - 40, 60, 35)];
        _numLabel.font = [UIFont systemFontOfSize:14];
        _numLabel.alpha = 0.0f;
        _numLabel.textAlignment = NSTextAlignmentRight;
        _numLabel.textColor = [UIColor whiteColor];
        _numLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    }
    return _numLabel;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.pagingEnabled =YES;
        _scrollView.delegate =self;
        _scrollView.bounces =NO;
        _scrollView.showsVerticalScrollIndicator =NO;
        _scrollView.showsHorizontalScrollIndicator =NO;
        _scrollView.contentSize =CGSizeMake(SCREEN_MAIN.width*3, SCREEN_MAIN.height);
        _scrollView.contentOffset =CGPointMake(SCREEN_MAIN.width, 0);
    }
    return _scrollView;
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    self.desLabel.hidden = false;
    if (self.titlesArray && self.titlesArray.count == self.dataArray.count) {
        self.desLabel.text = self.titlesArray[currentIndex];
    }else if (self.titlesArray && self.titlesArray.count == 1){
        self.desLabel.text = self.titlesArray.firstObject;
    }else{
        self.desLabel.hidden = true;
    }
    
    self.numLabel.text = [NSString stringWithFormat:@"%ld/%ld",currentIndex +1,self.dataArray.count];
}

-(void)showImageBrawerWithDataArray:(NSArray *)dataArray andCurrentIndex:(NSInteger)currentIndex andBegainRect:(CGRect)begainRect{
    
    self.hidden = false;
    midImage.hidden = false;
    self.dataArray = dataArray;
    self.rect = begainRect;
    self.isInScreen = true;
    [self.moveImageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[currentIndex]] placeholderImage:[UIImage imageNamed:@"room_default_img"]];
    self.moveImageView.frame = begainRect;
    self.moveImageView.hidden = false;
    
    
    
    //图片赋初值
    NSString *midUrl =self.dataArray[currentIndex];
    _currentImageIndex =currentIndex;
    self.currentIndex = currentIndex;
    midImage.imageView.hidden =YES;
    [midImage.imageView sd_setImageWithURL:[NSURL URLWithString:midUrl] placeholderImage:[UIImage imageNamed:@"room_default_img"]];
    
    NSString *lefturl =self.dataArray[(currentIndex +self.dataArray.count-1)%self.dataArray.count];
    [leftImage.imageView sd_setImageWithURL:[NSURL URLWithString:lefturl] placeholderImage:[UIImage imageNamed:@"room_default_img"]];
    
    NSString *rightUrl =self.dataArray[(currentIndex +self.dataArray.count+1)%self.dataArray.count];
    [rightImage.imageView sd_setImageWithURL:[NSURL URLWithString:rightUrl] placeholderImage:[UIImage imageNamed:@"room_default_img"]];
    
    CGRect rec =[midImage convertRect:midImage.imageView.frame toView:self];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor =[[UIColor clearColor]colorWithAlphaComponent:1.0];
        self.desLabel.alpha = 1.0f;
        self.numLabel.alpha = 1.0f;
        self.moveImageView.frame =rec;
        self.moveImageView.alpha =1.0f;
    } completion:^(BOOL finished) {
        self.moveImageView.hidden =YES;
//        self.desLabel.hidden = false;
        self.numLabel.hidden = false;
        midImage.imageView.hidden =NO;
    }];
}

- (UIImage *)screenshot
{
    CGSize imageSize = CGSizeZero;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        } else {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//
//    CIContext *context1 = [CIContext contextWithOptions:nil];
//    CIImage *image1 = image.CIImage;
//    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//    [filter setValue:image1 forKey:kCIInputImageKey];
//    [filter setValue:@2.0f forKey: @"inputRadius"];
//    CIImage *result = [filter valueForKey:kCIOutputImageKey];
//    CGImageRef outImage = [context1 createCGImage: result fromRect:[result extent]];
//    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    return image;
}

//停止滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView ==self.scrollView) {
        [self reloadImages:scrollView];
        self.currentIndex =_currentImageIndex;
//        self.countLabel.text =[NSString stringWithFormat:@"%ld/%ld",self.currentIndex +1,self.dataArray.count];
        [self.scrollView setContentOffset:CGPointMake(SCREEN_MAIN.width, 0)];
        if (self.getScrollViewIndexBlock) {
            self.getScrollViewIndexBlock(_currentImageIndex);
        }
    }
}

-(void)reloadImages:(UIScrollView *)scrollView{
    if (self.scrollView.contentOffset.x ==2*SCREEN_MAIN.width) {
        _currentImageIndex =(_currentImageIndex +self.dataArray.count +1)%self.dataArray.count;
    }else if (self.scrollView.contentOffset.x ==0){
        _currentImageIndex =(_currentImageIndex +self.dataArray.count -1)%self.dataArray.count;
    }
    NSString *mid =self.dataArray[_currentImageIndex];
    [midImage.imageView sd_setImageWithURL:[NSURL URLWithString:mid] placeholderImage:[UIImage imageNamed:@"room_default_img"]];
    //保证缩放后滚动其他图片不缩放
    midImage.zoomScale =1.0f;
    //保证双击后滚动其他图片不缩放
    midImage.contentSize =CGSizeMake(SCREEN_MAIN.width, SCREEN_MAIN.height);
    midImage.imageView.size =midImage.contentSize;
    
    _leftImageIndex =(_currentImageIndex +self.dataArray.count -1)%self.dataArray.count;
    _rightImageIndex =(_currentImageIndex + self.dataArray.count +1)%self.dataArray.count;
    
    NSString *left =self.dataArray[_leftImageIndex];
    [leftImage.imageView sd_setImageWithURL:[NSURL URLWithString:left] placeholderImage:[UIImage imageNamed:@"room_default_img"]];
    
    NSString *right =self.dataArray[_rightImageIndex];
    [rightImage.imageView sd_setImageWithURL:[NSURL URLWithString:right] placeholderImage:[UIImage imageNamed:@"room_default_img"]];
}

-(void)removeSelf1{//
    [self.moveImageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[_currentImageIndex]] placeholderImage:[UIImage imageNamed:@"room_default_img"]];
    CGRect ct =[self.scrollView convertRect:midImage.frame toView:self];
    self.moveImageView.frame =ct;
    self.moveImageView.hidden =NO;
    midImage.hidden =YES;
    
    //多层过滤是否在屏幕内
    if (!self.isInScreen) {
        if (self.rect.origin.y >= SCREEN_MAIN.height || self.rect.origin.y +self.rect.size.height <= 0 ) {
            self.isInScreen = false;
        }else{
            self.isInScreen = true;
        }
    }
//
    CGRect form;
    if (self.isInScreen == true) {
        form =self.rect;
    }else{
        CGFloat width =SCREEN_MAIN.width +100;
        CGFloat height =width *SCREEN_MAIN.height /SCREEN_MAIN.width;
        form =CGRectMake(-50, -(height -SCREEN_MAIN.height)/2.0, width, height);
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.0f];
        self.moveImageView.frame =form;
        self.moveImageView.alpha =0.0f;
        self.desLabel.alpha = 0.0f;
        self.numLabel.alpha = 0.0f;
    } completion:^(BOOL finished) {
//        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//        [self removeFromSuperview];
        self.hidden = true;
    }];
}
@end
