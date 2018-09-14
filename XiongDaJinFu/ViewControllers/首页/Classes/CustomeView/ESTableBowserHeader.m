//
//  ESTableBowserHeader.m
//  Essential-New
//
//  Created by 奕赏 on 16/9/5.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import "ESTableBowserHeader.h"
#import "XYImageModel.h"
#import "XYBrawerHeaderImageView.h"
#define SCREENSIZE [UIScreen mainScreen].bounds.size
static NSString *PlaceHoldImage =@"bigClassPlaceHold";
@implementation ESTableBowserHeader
{
    
    NSArray *_picsUrlArray;
    XYBrawerHeaderImageView *leftImage;
    XYBrawerHeaderImageView *midImage;
    XYBrawerHeaderImageView *rightImage;
    
    NSInteger _leftIndex;
    NSInteger _midIndex;
    NSInteger _rightIndex;
    dispatch_source_t _timer;
    BOOL _isRun;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        self.scrollView.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(SCREENSIZE.width *3, self.frame.size.height);
        self.scrollView.bounces = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

-(void)setPictureUrlArray:(NSArray *)pictureUrlArray{
    _pictureUrlArray = pictureUrlArray;
    _picsUrlArray = _pictureUrlArray;
    [self initContent];
}

-(void)touch:(UITapGestureRecognizer *)tap{
    if (self.HeaderClickBlock) {
        self.HeaderClickBlock(_midIndex);
    }
}


-(void)initContent{
    
    _midIndex =0;
//    _leftIndex =(_midIndex -1 +self.picsUrlArray.count)%self.picsUrlArray.count;
//    _rightIndex =(_midIndex +1 +self.picsUrlArray.count)%self.picsUrlArray.count;
    for (int i =0; i<3; i++) {
        XYBrawerHeaderImageView *image =[[XYBrawerHeaderImageView alloc]initWithFrame:CGRectMake(SCREENSIZE.width *i, 0, SCREENSIZE.width, self.height)];
        image.contentMode =UIViewContentModeScaleAspectFill;
        image.clipsToBounds =YES;
        [self.scrollView addSubview:image];
        if (i ==0) {
            XYImageModel *model =_picsUrlArray[(_midIndex -1 +_picsUrlArray.count)%_picsUrlArray.count];
            leftImage =image;
            image.url = model.url;
            image.isPlayer = model.isVideo ? YES:NO;
        }else if (i==1){
            XYImageModel *model =_picsUrlArray[_midIndex];
            midImage =image;
            image.url = model.url;
            image.isPlayer = model.isVideo ? YES:NO;
        }else if (i ==2){
            XYImageModel *model = _picsUrlArray[(_midIndex +1 +_picsUrlArray.count)%_picsUrlArray.count];
            rightImage =image;
            image.url = model.url;
            image.isPlayer = model.isVideo ? YES:NO;
        }
    }
    self.scrollView.contentOffset =CGPointMake(SCREENSIZE.width, 0);
    
    UIPageControl *pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.height -26, self.frame.size.width, 17)];
    pageControl.numberOfPages =_picsUrlArray.count;
    pageControl.currentPage =_midIndex;
    [self addSubview:pageControl];
    pageControl.currentPageIndicatorTintColor =[UIColor blackColor];
    pageControl.pageIndicatorTintColor =[UIColor colorWithHex:0xb4b4b4];
    self.pageControl =pageControl;
    
    //定时器
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer =dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),3.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self autoScrollView];
        });
    });
    dispatch_resume(_timer);
    _isRun =YES;
}

-(void)setIsInScreen:(BOOL)isInScreen{
    _isInScreen =isInScreen;
    if (_isInScreen ==YES) {
        if (_isRun ==NO) {
            dispatch_resume(_timer);
            _isRun =YES;
        }
    }else{
        if (_isRun ==YES) {
            dispatch_suspend(_timer);
            _isRun =NO;
        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    dispatch_suspend(_timer);
    _isRun =NO;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    dispatch_resume(_timer);
    _isRun =YES;
}

-(void)autoScrollView{
    if (_picsUrlArray.count >0) {
        [UIView animateWithDuration:1 animations:^{
            self.scrollView.contentOffset =CGPointMake(SCREENSIZE.width *2, 0);
        } completion:^(BOOL finished) {
            _midIndex = (_midIndex +_picsUrlArray.count +1)%_picsUrlArray.count;
            XYImageModel *mModel =_picsUrlArray[_midIndex];
            midImage.url =mModel.url;
            
            _leftIndex =(_midIndex -1 +_picsUrlArray.count)%_picsUrlArray.count;
            _rightIndex =(_midIndex +1 +_picsUrlArray.count)%_picsUrlArray.count;
            
            XYImageModel *lModel =_picsUrlArray[_leftIndex];
            XYImageModel *rModel =_picsUrlArray[_rightIndex];
            leftImage.url = lModel.url;
            rightImage.url = rModel.url;
            
            [self.scrollView setContentOffset:CGPointMake(SCREENSIZE.width, 0) animated:NO];
            self.pageControl.currentPage =_midIndex;
        }];
    }

}

//停止滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat contentSet =self.scrollView.contentOffset.x;
    if (contentSet ==0) {
        _midIndex = (_midIndex +_picsUrlArray.count -1)%_picsUrlArray.count;
    }else if (contentSet ==SCREENSIZE.width *2){
        _midIndex = (_midIndex +_picsUrlArray.count +1)%_picsUrlArray.count;
    }
    XYImageModel *mModel = _picsUrlArray[_midIndex];
    midImage.url = mModel.url;
    midImage.isPlayer = mModel.isVideo?YES:NO;
    
    
    _leftIndex =(_midIndex -1 +_picsUrlArray.count)%_picsUrlArray.count;
    _rightIndex =(_midIndex +1 +_picsUrlArray.count)%_picsUrlArray.count;
    
    XYImageModel *lModel = _picsUrlArray[_leftIndex];
    leftImage.url = lModel.url;
    leftImage.isPlayer = lModel.isVideo?YES:NO;
    
    XYImageModel *rModel = _picsUrlArray[_rightIndex];
    rightImage.url = rModel.url;
    rightImage.isPlayer = rModel.isVideo?YES:NO;

    [self.scrollView setContentOffset:CGPointMake(SCREENSIZE.width, 0) animated:NO];
    
    self.pageControl.currentPage =_midIndex;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}


@end
