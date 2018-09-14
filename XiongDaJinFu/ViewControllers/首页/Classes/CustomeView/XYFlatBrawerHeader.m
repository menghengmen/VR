//
//  XYFlatBrawerHeader.m
//  testDemo
//
//  Created by 威威孙 on 2017/3/21.
//  Copyright © 2017年 威威孙. All rights reserved.
//

#import "XYFlatBrawerHeader.h"
#import "XYBrawerHeaderImageView.h"
#import "XYFlatBrawerHeaderBtn.h"
#import "XYBrawerBtnView.h"

@interface XYFlatBrawerHeader()<UIScrollViewDelegate>
//@property (nonatomic,strong)UIImageView *indicateView;//指示用的三角形
@property (nonatomic,strong)UIView *btnView;
@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)UIImageView *leftImageView;
@property (nonatomic,strong)UIImageView *rightImageView;
@property (nonatomic,strong)UIImageView *midImageView;
@property (nonatomic,strong)NSArray *titlesArray;
@property (nonatomic,strong)NSArray *picsArray;

@property (nonatomic,assign)NSInteger leftIndex;
@property (nonatomic,assign)NSInteger midIndex;
@property (nonatomic,assign)NSInteger rightIndex;

@property (nonatomic,assign)NSInteger currentSection;

@end
@implementation XYFlatBrawerHeader
{
    NSInteger _picsCount;
    CGFloat _currentBtnCenterX;//当前按钮
    BOOL _btnsIsOutSideTitlesView;//按钮长度是否超出屏幕范围
    BOOL _isSlider;//是否是滑动过去的
    NSInteger _beforeSectionIndex;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _picsCount = 0;
        _midIndex = 0;
        _isSlider = false;
    }
    return self;
}

-(UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]init];
    }
    return _leftImageView;
}

-(UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]init];
    }
    return _rightImageView;
}

-(UIImageView *)midImageView{
    if (!_midImageView) {
        _midImageView = [[UIImageView alloc]init];
    }
    return _midImageView;
}

//-(UIImageView *)indicateView{
//    if (!_indicateView) {
//        _indicateView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.titlesScrollView.frame.size.height -10, 20, 10)];
//        _indicateView.image = [UIImage imageNamed:@"white_Triangle"];
//    }
//    return _indicateView;
//}

-(UIView *)btnView{
    if (!_btnView) {
        _btnView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([XYBrawerBtnView class]) owner:nil options:nil][0];
        _btnView.frame = CGRectMake(0, -5, 10, 30);
    }
    return _btnView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 5)];
        //        _pageControl.hidesForSinglePage = true;
        _pageControl.tintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        //        _pageControl.pageIndicatorTintColor = [UIColor clearColor];
    }
    return _pageControl;
}

-(UIScrollView *)titlesScrollView{
    if (!_titlesScrollView) {
        _titlesScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 25, self.frame.size.width, 25)];
        _titlesScrollView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7f];
        _titlesScrollView.bounces = false;
        _titlesScrollView.clipsToBounds = false;
        _titlesScrollView.showsVerticalScrollIndicator =NO;
        _titlesScrollView.showsHorizontalScrollIndicator =NO;
        
    }
    return _titlesScrollView;
}

-(void)initContent{
    //
    self.currentPictureIndex = 0;
    self.currentSection = 0;
    
    UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:scrollView];
    self.picsScrollView =scrollView;
    self.picsScrollView.userInteractionEnabled =YES;
    self.userInteractionEnabled =YES;
    self.picsScrollView.contentSize =CGSizeMake(self.frame.size.width *3, self.frame.size.height);
    self.picsScrollView.bounces =NO;
    self.picsScrollView.pagingEnabled =YES;
    self.picsScrollView.showsVerticalScrollIndicator =NO;
    self.picsScrollView.showsHorizontalScrollIndicator =NO;
    self.picsScrollView.delegate =self;
    self.picsScrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    
    
    NSInteger picsCount = 0;
    for (int i = 0; i<[self.delegate numOfSectionsInDrawer:self]; i++) {
        picsCount = picsCount + [self.delegate flatBrawerHeader:self numOfIntemsInSection:i];
    }
    for (int i = 0; i<3; i++) {
        
        CGRect rect = CGRectMake(self.frame.size.width *i, 0, self.frame.size.width, self.frame.size.height);
        
        if (picsCount == 0 || picsCount == 1) {
            _leftIndex = 0;
            _rightIndex = 0;
            self.picsScrollView.scrollEnabled = false;
        }else{
            self.picsScrollView.scrollEnabled = true;
            _leftIndex = (_midIndex -1 +picsCount)%picsCount;
            _rightIndex = (_midIndex +1 +picsCount)%picsCount;
            
        }
        
        if (i ==0) {
            self.leftImageView = [self.delegate flatBrawerHeader:self itemForHeaderAtIndex:_leftIndex];
            self.leftImageView.frame = rect;
            [self.picsScrollView addSubview:self.leftImageView];
        }else if (i==1){
            self.midImageView =[self.delegate flatBrawerHeader:self itemForHeaderAtIndex:_midIndex];
            self.midImageView.frame = rect;
            [self.picsScrollView addSubview:self.midImageView];
        }else if (i ==2){
            self.rightImageView =[self.delegate flatBrawerHeader:self itemForHeaderAtIndex:_rightIndex];
            self.rightImageView.frame = rect;
            [self.picsScrollView addSubview:self.rightImageView];
        }
    }

    [self addSubview:self.titlesScrollView];
    [self loadTitlesView];
    
    self.currentSection = 0;
}

-(void)loadTitlesView{
    [self addSubview:self.pageControl];
    [self.titlesScrollView addSubview:self.btnView];
    
    CGFloat beforeBtnMaxX = 0.0f;
    NSArray * titles = [self.delegate titlesOfFlatBrawer:self];
    if (titles.count ==0 ) {
        self.titlesScrollView.hidden = true;
        return;
    }
    for (int i = 0; i<[self.delegate titlesOfFlatBrawer:self].count;i++ ) {
        XYFlatBrawerHeaderBtn *btn = [XYFlatBrawerHeaderBtn buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        CGSize size = [btn.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:btn.titleLabel.font,NSFontAttributeName, nil]];
        //        [btn setBackgroundColor:[UIColor colorWithRandomColor]];
        btn.frame = CGRectMake(beforeBtnMaxX, 0, size.width +30, 25);
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesScrollView addSubview:btn];
        beforeBtnMaxX = CGRectGetMaxX(btn.frame);
        self.titlesScrollView.contentSize = CGSizeMake(beforeBtnMaxX , 25);
        
        if (i == self.currentSection) {
            btn.isSection = true;
        }else{
            btn.isSection = false;
        }
    }
}

-(void)titleBtnClick:(UIButton *)sender{
    _isSlider = true;
    self.currentSection = sender.tag - 100;
    //移动三角形
    for (int i = 0; i<[self.delegate numOfSectionsInDrawer:self]; i++) {
        XYFlatBrawerHeaderBtn *btn = (XYFlatBrawerHeaderBtn *)[self.titlesScrollView viewWithTag:i+100];
        if (btn.tag == sender.tag) {
            if (btn.isSection == true) {
                continue;
            }else{
                btn.isSection = true;
                self.currentSection = sender.tag -100;
            }
        }else{
            btn.isSection = false;
        }
    }
    //移动图片使雨标题对应
    NSInteger mid =0;
    for (int i = 0; i<sender.tag -99; i++) {
        mid = mid + [self.delegate flatBrawerHeader:self numOfIntemsInSection:i];
    }
    _midIndex =mid - [self.delegate flatBrawerHeader:self numOfIntemsInSection:self.currentSection];
    [self scrollView:_midIndex];
    [self scrollViewToFitUserHabit:self.currentSection];
}

-(void)touch:(UITapGestureRecognizer *)tap{
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _isSlider = true;//是滑动的
    if (scrollView == self.picsScrollView) {
        CGFloat contentSet =self.picsScrollView.contentOffset.x;
        if (contentSet == 0) {
            _midIndex = (_midIndex +_picsCount -1)%_picsCount;
        }else if (contentSet == self.frame.size.width *2){
            _midIndex = (_midIndex +_picsCount +1)%_picsCount;
        }
        [self scrollView:_midIndex];
    }
}

-(void)scrollView:(NSInteger)midIndex{
    _leftIndex =(_midIndex -1 +_picsCount)%_picsCount;
    _rightIndex =(_midIndex +1 +_picsCount)%_picsCount;
    
    CGRect midRect = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    self.midImageView = [self rePlaceImageView:self.midImageView WithIndex:_midIndex andRect:midRect];
    
    
    CGRect leftRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.leftImageView = [self rePlaceImageView:self.leftImageView WithIndex:_leftIndex andRect:leftRect];
    
    CGRect rightRect = CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    self.midImageView  = [self rePlaceImageView:self.rightImageView WithIndex:_rightIndex andRect:rightRect];
    if (self.picsScrollView.contentOffset.x !=self.picsScrollView.frame.size.width) {
        [self.picsScrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:false];
    }
    self.currentSection = [self sectionOfpicIndex:_midIndex];
    [self scrollViewToFitUserHabit:self.currentSection];
//    self.pageControl.currentPage = _midIndex;
    self.currentPictureIndex = _midIndex;
}

-(void)setCurrentSection:(NSInteger)currentSection{
    _currentSection = currentSection;
    //pageControl操作
//    self.pageControl.numberOfPages = [self.delegate flatBrawerHeader:self numOfIntemsInSection:currentSection];
//    self.pageControl.currentPage = [self currentSectionIndex:_midIndex];
    
    NSInteger picsCount = 0;
    for (int i = 0; i<[self.delegate numOfSectionsInDrawer:self]; i++) {
        picsCount = picsCount + [self.delegate flatBrawerHeader:self numOfIntemsInSection:i];
    }
    self.pageControl.numberOfPages = picsCount;
    self.pageControl.currentPage = _midIndex;
    
    //滑块操作
    for (int i = 0; i<[self.delegate titlesOfFlatBrawer:self].count; i++) {
        XYFlatBrawerHeaderBtn *btn = (XYFlatBrawerHeaderBtn *)[self.titlesScrollView viewWithTag:i +100];
        if (i == _currentSection) {
            //
            btn.isSection = true;
            
            //处理特殊情况
            if (_isSlider && (_beforeSectionIndex == ([self.delegate titlesOfFlatBrawer:self].count -1)) && currentSection == 0) {//如果是从最后一张图片继续向后滑动
                self.btnView.frame = CGRectMake(0, -5, 0, 0);
            }else if (_isSlider && (_beforeSectionIndex == 0) && currentSection == ([self.delegate titlesOfFlatBrawer:self].count -1)){//从第一张往前面滑
                self.btnView.frame = CGRectMake(self.frame.size.width, -5, 0, 0);
            }
            //
            [UIView animateWithDuration:0.3f animations:^{
                self.btnView.frame = CGRectMake(btn.frame.origin.x, -5, btn.frame.size.width, 30);
            } completion:^(BOOL finished) {
                
            }];
        }else{
            btn.isSection = false;
        }
    }
    _beforeSectionIndex = currentSection;
}

//让标题view实时滚动以符合使用习惯
-(void)scrollViewToFitUserHabit:(NSInteger)currentSetction{
    XYFlatBrawerHeaderBtn *btn =(XYFlatBrawerHeaderBtn *)[self.titlesScrollView viewWithTag:currentSetction +100];
    CGRect rect  = [self.titlesScrollView convertRect:btn.frame toView:[UIApplication sharedApplication].keyWindow];
    
    if (rect.origin.x <15) {//在左侧没显示完全
        if (currentSetction == 0) {//是第一个
            [self.titlesScrollView setContentOffset:CGPointMake(0, 0) animated:true];
        }else{//不是第一个
            XYFlatBrawerHeaderBtn *left = (XYFlatBrawerHeaderBtn *)[self.titlesScrollView viewWithTag:currentSetction +100 -1];
            [self.titlesScrollView setContentOffset:CGPointMake(CGRectGetMinX(left.frame) -15, 0) animated:true];
        }
    }else if (rect.origin.x +rect.size.width >self.frame.size.width -15){//在右侧没显示完全
        if (currentSetction == [self.delegate numOfSectionsInDrawer:self] -1) {//是最后一个
            [self.titlesScrollView setContentOffset:CGPointMake(CGRectGetMaxX(btn.frame) +15 -self.frame.size.width, 0) animated:true];
        }else{//不是最后一个
            XYFlatBrawerHeaderBtn *right = (XYFlatBrawerHeaderBtn *)[self.titlesScrollView viewWithTag:currentSetction +100 +1];
            [self.titlesScrollView setContentOffset:CGPointMake(CGRectGetMaxX(right.frame) +15 -self.frame.size.width, 0) animated:true];
        }
    }
}

-(UIImageView *)rePlaceImageView:(UIImageView *)imageView WithIndex:(NSInteger)index andRect:(CGRect)rect{
    UIImageView *new = [self.delegate flatBrawerHeader:self itemForHeaderAtIndex:index];
    new.frame = rect;
    for (UIImageView *image in self.picsScrollView.subviews) {
        if ((image.frame.origin.x == rect.origin.x) &&![image isKindOfClass:[UIScrollView class]]) {
            [image removeFromSuperview];
        }
    }
    
    [self.picsScrollView addSubview:new];
    return new;
}

-(NSInteger)currentSectionIndex:(NSInteger)picIndex{
    NSInteger count= 0;
    NSInteger sectionCount = [self sectionOfpicIndex:picIndex];
    for (int i = 0; i<sectionCount; i++) {
        NSInteger num = [self.delegate flatBrawerHeader:self numOfIntemsInSection:i];
        count = count +num;
    }
    return picIndex - count;
}


-(NSInteger)sectionOfpicIndex:(NSInteger)picIndex{
    NSInteger count= 0;
    for (int i = 0; i<[self.delegate numOfSectionsInDrawer:self]; i++) {
        NSInteger num = [self.delegate flatBrawerHeader:self numOfIntemsInSection:i];
        count = count +num;
        if (count >picIndex) {
            _currentSection = i;
            return i;
        }
    }
    return _currentSection;
}

-(void)reloadData{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self initContent];
    NSInteger picsCount = 0;
    for (int i = 0; i<[self.delegate numOfSectionsInDrawer:self]; i++) {
        picsCount = picsCount + [self.delegate flatBrawerHeader:self numOfIntemsInSection:i];
    }
    _picsCount = picsCount;
    if ([self.delegate titlesOfFlatBrawer:self].count == 0) {
        self.titlesScrollView.hidden = true;
    }else{
        self.titlesScrollView.hidden = false;
    }
    
    if ([self.delegate titlesOfFlatBrawer:self].count >0) {
        self.pageControl.hidden = true;
    }else{
        self.pageControl.hidden = false;
    }
    
    
}

@end
