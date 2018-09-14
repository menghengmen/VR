//
//  NickyPhotoPreviewController.m
//  NickyLocalImagePicker
//
//  Created by NickyTsui on 15/12/30.
//  Copyright © 2015年 com.nickyTsui. All rights reserved.
//

#import "NickyPhotoPreviewController.h"
#import "NickyCategoryTools.h"

static NSString *const NickyPreviewCellIdentifier = @"NickyPreviewCellIdentifier";

@protocol NickyPhotoPreviewCellDelegate;

@interface NickyPhotoPreviewCell : UICollectionViewCell <UIScrollViewDelegate>

@property (strong,nonatomic)UIScrollView        *scrollView;

@property (strong,nonatomic)UIImageView         *previewImageView;

@property (strong,nonatomic)UIImage             *image;


@property (weak,nonatomic)id <NickyPhotoPreviewCellDelegate> delegate;





@end

@protocol NickyPhotoPreviewCellDelegate <NSObject>

- (void)TapHiddenPhotoView:(NickyPhotoPreviewCell*)cell;

@end

@implementation NickyPhotoPreviewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self.contentView addSubview:self.scrollView];
        [self.scrollView addSubview:self.previewImageView];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [UIView animateWithDuration:.2 animations:^{
        _scrollView.frame = self.contentView.bounds;
        /** 设置imageview的frame */
        self.previewImageView.frame = [self calFrame:self.previewImageView.image];
    }];
}
#pragma mark 设置大图
- (void)setImage:(UIImage *)image{
    _image = image;
    [UIView animateWithDuration:.2 animations:^{
        /** 设置imageview的frame */
        self.previewImageView.frame = [self calFrame:image];
        
    }];
}
-(CGRect)calFrame:(UIImage *)targetImage{
    CGFloat radio = targetImage.size.width/ScreenWidth;
    CGSize size = CGSizeMake(targetImage.size.width/radio, targetImage.size.height/radio);
    
    CGFloat w = size.width;
    CGFloat h = size.height;
    
    CGRect superFrame = [UIScreen mainScreen].bounds;
    CGFloat superW =superFrame.size.width ;
    CGFloat superH =superFrame.size.height;
    
    CGFloat calW = superW;
    CGFloat calH = superW;
    
    if (w>=h) {
        if(w> superW){
            CGFloat scale = superW / w;
            calW = w * scale;
            calH = h * scale;
            
        }else if(w <= superW){
            
            calW = w;
            calH = h;
        }
        
    }else if(w<h){
        
        CGFloat scale1 = superH / h;
        CGFloat scale2 = superW / w;
        
        BOOL isFat = w * scale1 > superW;
        
        CGFloat scale =isFat ? scale2 : scale1;
        
        if(h> superH){
            calW = w * scale;
            calH = h * scale;
            
        }else if(h <= superH){
            if(w>superW){
                calW = w * scale;
                calH = h * scale;
            }else{
                calW = w;
                calH = h;
            }
            
        }
    }
    CGPoint screenCenter = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    CGFloat x = screenCenter.x - w *.5f;
    CGFloat y = screenCenter.y - h * .5f;
    CGRect frame = (CGRect){CGPointMake(x, y),CGSizeMake(w, h)};
    return frame;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    if(scrollView.zoomScale <=1) scrollView.zoomScale = 1.0f;
    
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    [self.previewImageView setCenter:CGPointMake(xcenter, ycenter)];
}



#pragma mark - 缩放大小获取方法
-(CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    zoomRect.size.height = [_scrollView frame].size.height/scale;
    zoomRect.size.width = [_scrollView frame].size.width/scale;
    zoomRect.origin.x = center.x - zoomRect.size.width/2;
    zoomRect.origin.y = center.y - zoomRect.size.height/2;
    return zoomRect;
}



- (UIScrollView *)scrollView{
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.maximumZoomScale = 3.0;
        _scrollView.minimumZoomScale = 1;
        _scrollView.delegate = self;
        _scrollView.bounces = YES;
        _scrollView.delaysContentTouches = YES;
        _scrollView.contentMode = UIViewContentModeScaleToFill;
    }
    return _scrollView;
}
#pragma mark - 图片的点击，touch事件
-(void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.numberOfTapsRequired == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(TapHiddenPhotoView:)]){
            [self.delegate TapHiddenPhotoView:self];
        }
    }
}

-(void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.numberOfTapsRequired == 2) {
        if(_scrollView.zoomScale == 1){
            float newScale = [_scrollView zoomScale] *2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [_scrollView zoomToRect:zoomRect animated:YES];
        }else{
            float newScale = [_scrollView zoomScale]/2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [_scrollView zoomToRect:zoomRect animated:YES];
        }
    }
}

-(void)handleTwoFingerTap:(UITapGestureRecognizer *)gestureRecongnizer{
    float newScale = [_scrollView zoomScale]/2;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecongnizer locationInView:gestureRecongnizer.view]];
    [_scrollView zoomToRect:zoomRect animated:YES];
}

//2.重新确定缩放完后的缩放倍数
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    [scrollView setZoomScale:scale+0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}
- (UIImageView *)previewImageView
{
    if (!_previewImageView){
        _previewImageView = [[UIImageView alloc]init];
        _previewImageView.contentMode = UIViewContentModeScaleAspectFit;
        _previewImageView.layer.masksToBounds = YES;
        _previewImageView.userInteractionEnabled = YES;
        
        //添加手势
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
        
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        doubleTap.numberOfTapsRequired = 2;
        twoFingerTap.numberOfTouchesRequired = 2;
        
        [_previewImageView addGestureRecognizer:singleTap];
        [_previewImageView addGestureRecognizer:doubleTap];
        [_previewImageView addGestureRecognizer:twoFingerTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];
        
    }
    return _previewImageView;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.previewImageView;
}

@end

@interface NickyPhotoPreviewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,NickyPhotoPreviewCellDelegate>
@property (strong,nonatomic) UICollectionView                            *collectionView;

@property (strong,nonatomic) UICollectionViewFlowLayout                  *collectionViewLayout;

@property (strong,nonatomic) UIView                                      *bottomView;

@property (strong,nonatomic) UIButton                                    *originalButton;

@property (strong,nonatomic) UIButton                                    *finishButton;

@property (strong,nonatomic) UIButton                                    *selectButton;

@property (assign,nonatomic) BOOL                                        originalPhoto;

@property (strong,nonatomic) NSMutableArray                             *selectedArray;
@end

@implementation NickyPhotoPreviewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateSelectionStatus];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self didRotateFromInterfaceOrientation:self.interfaceOrientation];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    
    if (self.currentPage){
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    if (self.isSelectedMode){
        UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc]initWithCustomView:self.selectButton];
        self.navigationItem.rightBarButtonItem = rightbutton;
        [self scrollViewDidEndDecelerating:self.collectionView];
    }
    // Do any additional setup after loading the view.
}
- (void)finish:(NSArray *)callBackArray{
    if (self.naviController.pickerDelegate && [self.naviController.pickerDelegate respondsToSelector:@selector(nickyImagePicker:didSelectedImages:)]){
        [self.naviController.pickerDelegate nickyImagePicker:self.naviController didSelectedImages:callBackArray];
    }
    [self.naviController dismissViewControllerAnimated:YES completion:nil];
}
- (void)finishAction:(UIButton *)button{
    __block int i = 0;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        NSMutableArray *callbackArray = [[NSMutableArray alloc]init];
        for (NickyPhotoAlAssetModel *assetModel in self.selectedArray) {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
            [library assetForURL:assetModel.photoURL resultBlock:^(ALAsset *asset) {
                i++;
                if (self.originalPhoto){ //使用原图
                    [callbackArray addObject:[UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage]];
                }
                else{ //使用压缩图
                    [callbackArray addObject:[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage]];
                }
                if (i==(self.selectedArray.count)){
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        [self finish:callbackArray];
                    });
                }
            } failureBlock:^(NSError *error) {
                i++;
                if (i==(self.selectedArray.count)){
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        [self finish:callbackArray];
                    });
                }
            }];
        }
        
    });

}
#pragma mark 更新 状态
- (void)updateSelectionStatus{
    self.selectedArray = [[NSMutableArray alloc]init];
    BOOL isSelected = NO;
    NSInteger selectedNumber = 0;
    for (NickyPhotoAlAssetModel *assetModel in self.photoArray) {
        if (assetModel.selected){
            selectedNumber++;
            [self.selectedArray addObject:assetModel];
        }
    }
    isSelected = selectedNumber;
    self.finishButton.enabled = isSelected;
    [self.finishButton setTitle:[NSString stringWithFormat:@"完成( %zd )",selectedNumber] forState:UIControlStateNormal];
}
#pragma mark 使用原图
- (void)useOriginalAction:(UIButton *)button{
    self.originalPhoto = !self.originalPhoto;
}
#pragma mark 设置原图
- (void)setOriginalPhoto:(BOOL)originalPhoto{
    _originalPhoto = originalPhoto;
    [self.collectionView reloadData];
    if (!self.originalPhoto){
        [self.originalButton setTitle:@"原图" forState:UIControlStateNormal];
        [self.originalButton setTitleColor:[UIColor colorWithHexString:@"#121212"] forState:UIControlStateNormal];
        self.originalButton.frame = ({
            CGRect frame = self.originalButton.frame;
            frame.size.width = 40;
            frame;
        });
    }
    else{
        [self.originalButton setTitleColor:[UIColor colorWithHexString:@"#09BB07"] forState:UIControlStateNormal];
    }
}
- (void)selectAction:(UIButton *)button{
    if (self.selectedArray.count>=PHOTOMAX_NUMBER) {
        UIAlertController*alertController=[UIAlertController alertControllerWithTitle:NSLocalizedString(@"最多只能选四张呦~", @"") message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *oklAction=[UIAlertAction actionWithTitle:NSLocalizedString(@"确定", @"") style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:oklAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    NSIndexPath *index = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset];
    NickyPhotoAlAssetModel *model = self.photoArray[index.item];
    model.selected = !model.selected;
    
    self.selectButton.selected = model.isSelected;
    [self updateSelectionStatus];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSIndexPath *index = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset];
    NickyPhotoAlAssetModel *model = self.photoArray[index.item];
    self.currentPage = index.item;
    self.selectButton.selected = model.isSelected;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NickyPhotoPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NickyPreviewCellIdentifier forIndexPath:indexPath];
    NickyPhotoAlAssetModel *assetModel = self.photoArray[indexPath.item];
    cell.delegate = self;
    cell.scrollView.zoomScale = 1;
    [cell.previewImageView loadLibraryBigImage:assetModel.photoURL placeImage:assetModel.thumbsImage finishBlock:^(UIImage *image, NSInteger imageSize) {
        // 把大图的image传递过去触发修改imageview frame的方法
        cell.image = image;
        if (self.originalPhoto){ //选择原图模式
            NSString *titleString = [NSString stringWithFormat:@"原图(%.2lfMB)",imageSize/1024.0/1024.0];
            [self.originalButton setTitle:titleString forState:UIControlStateNormal];
            CGFloat width = [titleString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.originalButton.titleLabel.font} context:NULL].size.width;
            self.originalButton.frame = ({
                CGRect frame = self.originalButton.frame;
                frame.size.width = width+12;
                frame;
            });
        }
    }];

    return cell;
}
#pragma mark 单击图片时触发
- (void)TapHiddenPhotoView:(NickyPhotoPreviewCell *)cell{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.navigationController.navigationBarHidden){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration:.2 animations:^{
            self.bottomView.frame = ({
                CGRect frame = self.bottomView.frame;
                frame.origin.y =self.view.bounds.size.height;
                frame;
            });
        }];
    }
    else{
        [UIView animateWithDuration:.2 animations:^{
            self.bottomView.frame = ({
                CGRect frame = self.bottomView.frame;
                frame.origin.y = self.view.bounds.size.height-44;
                frame;
            });
        }];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.bounds.size;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UICollectionView *)collectionView{
    if (!_collectionView){
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[NickyPhotoPreviewCell class] forCellWithReuseIdentifier:NickyPreviewCellIdentifier];
        _collectionView.pagingEnabled = YES;
    }
    return _collectionView;
}
- (UICollectionViewFlowLayout *)collectionViewLayout{
    if (!_collectionViewLayout){
        _collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionViewLayout.scrollDirection = 1;
    }
    return _collectionViewLayout;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)bottomView{
    if (!_bottomView){
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
        _bottomView.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA" alpha:.9];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _bottomView.bounds.size.width, .5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#C0C0C0"];
        [_bottomView addSubview:line];
        [_bottomView addSubview:self.originalButton];
        [_bottomView addSubview:self.finishButton];
    }
    return _bottomView;
}
- (UIButton *)finishButton{
    if (!_finishButton){
        _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishButton.frame = CGRectMake(_bottomView.bounds.size.width-60-10, 0, 60, 44);
        _finishButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
        [_finishButton setTitleColor:[UIColor colorWithHexString:@"#09BB07"] forState:UIControlStateNormal];
        [_finishButton setTitleColor:[UIColor colorWithHexString:@"#cfcfcf"] forState:UIControlStateHighlighted];
        [_finishButton setTitleColor:[UIColor colorWithHexString:@"#cfcfcf"] forState:UIControlStateDisabled];
        [_finishButton addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishButton;
}
- (UIButton *)originalButton{
    if (!_originalButton){
        _originalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _originalButton.frame = CGRectMake(10, 0, 40, 44);
        _originalButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_originalButton setTitle:@"原图" forState:UIControlStateNormal];
        [_originalButton setTitleColor:[UIColor colorWithHexString:@"#121212"] forState:UIControlStateNormal];
        [_originalButton addTarget:self action:@selector(useOriginalAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _originalButton;
}
- (UIButton *)selectButton{
    if (!_selectButton){
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectButton.frame = CGRectMake(0, 0, 20,20);
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"my_choice"] forState:UIControlStateNormal];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"my_pitch on"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [UIView animateWithDuration:.2 animations:^{
        
        self.collectionView.frame = self.view.bounds;
        
        self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44);
        self.finishButton.frame = CGRectMake(_bottomView.bounds.size.width-60-10, 0, 60, 44);
        self.originalButton.frame = CGRectMake(10, 0, 40, 44);
        
    }];
    [self.collectionView reloadData];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}
@end


