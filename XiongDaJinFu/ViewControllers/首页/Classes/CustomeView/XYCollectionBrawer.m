//
//  XYCollectionBrawer.m
//  testDemo
//
//  Created by 威威孙 on 2017/5/25.
//  Copyright © 2017年 威威孙. All rights reserved.
//

#import "XYCollectionBrawer.h"
#import "TestCollectionViewCell.h"
#import "XYFlatBrawerHeaderBtn.h"
#import "XYBrawerBtnView.h"
@interface XYCollectionBrawer()
@property (nonatomic,strong)UIView *btnView;//三角形
@property (nonatomic,assign)NSInteger currentSection;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,strong)NSMutableArray *statusArray;
@end

@implementation XYCollectionBrawer
{
    NSMutableArray *_dataArray;
    NSInteger _beforeSectionIndex;
    BOOL _isSlider;//是否是滑动过去的
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.statusArray = [NSMutableArray array];
        _isSlider = false;
        self.titlesScrollView.hidden = true;
        [self initCollectionView];
    }
    return self;
}

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

-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    self.pageControl.currentPage = currentIndex;
}

-(void)setCurrentSection:(NSInteger)currentSection{
    _currentSection = currentSection;

    //滑块操作
    [self moveSliderBtn:currentSection];
    
    //按钮处理
    [self detailBtn:currentSection];
    
    //移动图片
    [self scrollView:self.currentIndex];
    
    //移动标题
    [self scrollViewToFitUserHabit:self.currentSection];
}

-(void)detailBtn:(NSInteger)currentSection{
    for (int i = 0; i<self.imagesArray.count; i++) {
        XYFlatBrawerHeaderBtn *btn = (XYFlatBrawerHeaderBtn *)[self.titlesScrollView viewWithTag:i+100];
        if (btn.tag == currentSection +100 ) {
            if (btn.isSection == true) {
                continue;
            }else{
                btn.isSection = true;
            }
        }else{
            btn.isSection = false;
        }
    }
    
    //移动图片使与标题对应
    NSInteger mid =0;
    for (int i = 0; i<currentSection +100 -99; i++) {
        NSArray *imageGroup = self.imagesArray[i];
        mid = mid + imageGroup.count;
    }
    NSArray *imageGrouplast = self.imagesArray[self.currentSection];
    self.currentIndex = mid - imageGrouplast.count;
//    LxDBAnyVar(self.currentIndex);
}

-(void)moveSliderBtn:(NSInteger)currentSection{
    XYFlatBrawerHeaderBtn *btn = (XYFlatBrawerHeaderBtn *)[self.titlesScrollView viewWithTag:currentSection +100];
    btn.isSection = true;
    //处理特殊情况
    if (_isSlider && (_beforeSectionIndex == (self.imagesArray.count -1)) && currentSection == 0) {//如果是从最后一张图片继续向后滑动
        self.btnView.frame = CGRectMake(0, -5, 0, 0);
    }else if (_isSlider && (_beforeSectionIndex == 0) && currentSection == (self.imagesArray.count -1)){//从第一张往前面滑
        self.btnView.frame = CGRectMake(self.frame.size.width, -5, 0, 0);
    }
    //
    [UIView animateWithDuration:0.3f animations:^{
        self.btnView.frame = CGRectMake(btn.frame.origin.x, -5, btn.frame.size.width, 30);
    } completion:^(BOOL finished) {
        
    }];
    _beforeSectionIndex = currentSection;
}

-(void)initCollectionView{
    _dataArray = [NSMutableArray array];
    self.backgroundColor = [UIColor whiteColor];
    self.currentIndex = 0;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.imageViewCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height) collectionViewLayout:flowLayout];
    self.imageViewCollection.contentOffset = CGPointMake(self.frame.size.width, 0);
    self.imageViewCollection.backgroundColor = [UIColor whiteColor];
    self.imageViewCollection.delegate = self;
    self.imageViewCollection.dataSource = self;
    self.imageViewCollection.pagingEnabled = true;
    
    self.imageViewCollection.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.imageViewCollection];
    
    [self.imageViewCollection registerNib:[UINib nibWithNibName:NSStringFromClass([TestCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([TestCollectionViewCell class])];
    
    [self addSubview:self.titlesScrollView];
    [self addSubview:self.pageControl];
    
}

-(void)setImagesArray:(NSArray *)imagesArray{
    _imagesArray = imagesArray;
    
    if (imagesArray.count>0) {
        
        NSMutableArray *titles = [NSMutableArray array];
        for (NSArray *array in imagesArray) {
            for (XYImageModel *model in array) {
                [_dataArray addObject:model];
            }
            XYImageModel *model = array[0];
            if (model.des && model.des.length >0) {
                [titles addObject:model.des];
            }
        }
        [self loadTitles:titles];
        
        self.pageControl.numberOfPages = _dataArray.count;
//        _dataArray = [NSMutableArray arrayWithArray:self.statusArray];
        [_dataArray addObject:_dataArray[0]];
        [_dataArray insertObject:_dataArray[_dataArray.count -2] atIndex:0];
        if (_dataArray.count == 3 ) {
            self.imageViewCollection.scrollEnabled = false;
        }else{
            self.imageViewCollection.scrollEnabled = true;
        }
        
    }else{
        _dataArray = [NSMutableArray array];
    }
    [self.imageViewCollection reloadData];
    
    self.currentSection = 0;
}

-(void)loadTitles:(NSArray *)titles{
    [self.titlesScrollView addSubview:self.btnView];
    CGFloat beforeBtnMaxX = 0.0f;
    if (titles.count == 0) {
        self.titlesScrollView.hidden = true;
        self.pageControl.hidden = false;
        return;
    }
    self.titlesScrollView.hidden = false;
    self.pageControl.hidden = true;
    for (int i = 0; i<titles.count;i++ ) {
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

-(void)titleBtnClick:(XYFlatBrawerHeaderBtn *)sender{
    _isSlider = false;
    [self btnClickFunction:sender.tag];
}

-(void)btnClickFunction:(NSInteger)section{
    self.currentSection = section - 100;
    
}

-(void)scrollView:(NSInteger)midIndex{
    
    [self.imageViewCollection setContentOffset:CGPointMake(self.frame.size.width *(midIndex +1), 0) animated:true];
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
        if (currentSetction == self.imagesArray.count -1) {//是最后一个
            [self.titlesScrollView setContentOffset:CGPointMake(CGRectGetMaxX(btn.frame) +15 -self.frame.size.width, 0) animated:true];
        }else{//不是最后一个
            XYFlatBrawerHeaderBtn *right = (XYFlatBrawerHeaderBtn *)[self.titlesScrollView viewWithTag:currentSetction +100 +1];
            [self.titlesScrollView setContentOffset:CGPointMake(CGRectGetMaxX(right.frame) +15 -self.frame.size.width, 0) animated:true];
        }
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TestCollectionViewCell class]) forIndexPath:indexPath];
//    cell.testIamgeView.backgroundColor = [UIColor colorWithRandomColor];
    XYImageModel *model = _dataArray[indexPath.item];
    if (model.isVideo && model.isVideo == true) {
        [cell.testIamgeView sd_setImageWithURL:[NSURL URLWithString:self.title_imageUrl] placeholderImage:[UIImage imageNamed:@"main_default_img"]];
    }else{
        [cell.testIamgeView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"main_default_img"]];
    }
    if (model.isVideo && model.isVideo == true){
        cell.playBtnImageView.hidden = false;
    }else{
        cell.playBtnImageView.hidden = true;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XYImageModel *model = _dataArray[indexPath.item];
    if (self.imageClickBlock) {
        self.imageClickBlock(model,self.currentIndex);
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _isSlider = true;
    if (scrollView == self.imageViewCollection) {
        //图片相关
        NSInteger page = scrollView.contentOffset.x/self.frame.size.width;
//        NSLog(@"滚动到：%zd",page);
        if (page == 0) {//滚动到左边
            scrollView.contentOffset = CGPointMake(self.frame.size.width * (_dataArray.count - 2), 0);
            self.currentIndex = _dataArray.count - 3;
        }else if (page == _dataArray.count - 1){//滚动到右边
            scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
            self.currentIndex = 0;
        }else{
            self.currentIndex = page - 1;
        }
        
        //
        NSInteger currentSection = [self sectionOfpicIndex:self.currentIndex];
//        //滑块操作
        [self moveSliderBtn:currentSection];
        
        //按钮处理
//        [self detailBtn:currentSection];
        for (int i = 0; i<self.imagesArray.count; i++) {
            XYFlatBrawerHeaderBtn *btn = (XYFlatBrawerHeaderBtn *)[self.titlesScrollView viewWithTag:i+100];
            if (btn.tag == currentSection +100 ) {
                if (btn.isSection == true) {
                    continue;
                }else{
                    btn.isSection = true;
                }
            }else{
                btn.isSection = false;
            }
        }
        
//        //移动标题
        [self scrollViewToFitUserHabit:currentSection];
        
//
    }
}

-(NSInteger)sectionOfpicIndex:(NSInteger)picIndex{
    NSInteger count= 0;
    for (int i = 0; i<self.imagesArray.count; i++) {
        NSArray *array = self.imagesArray[i];
        count = count +array.count;
        if (count >picIndex) {
            return i;
        }
    }
    return 0;
}



@end
