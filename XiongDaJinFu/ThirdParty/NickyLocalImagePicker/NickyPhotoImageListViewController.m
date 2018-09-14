//
//  NickyPhotoImageListViewController.m
//  NickyLocalImagePicker
//
//  Created by NickyTsui on 15/12/30.
//  Copyright © 2015年 com.nickyTsui. All rights reserved.
//

#import "NickyPhotoImageListViewController.h"
#import "NickyPhotoPreviewController.h"

#define imageListCellHeight (self.view.bounds.size.width-20)/4

static NSString *const photoCellIdentifier = @"photoCellIdentifier";

@protocol  NickyPhotoImageListCellDelegate ;
@interface NickyPhotoImageListCell : UICollectionViewCell

@property (strong,nonatomic)UIImageView             *thumbImageView;

@property (strong,nonatomic)UIButton                *selectButton;

@property (weak  ,nonatomic)id<NickyPhotoImageListCellDelegate>     delegate;

@property (strong,nonatomic)NickyPhotoAlAssetModel    *assetModel;
@end

@protocol NickyPhotoImageListCellDelegate <NSObject>

- (void)nickyPhotoListCellDidSelected:(NickyPhotoImageListCell*)cell;

@end

@implementation NickyPhotoImageListCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self.contentView addSubview:self.thumbImageView];
        [self.contentView addSubview:self.selectButton];
    }
    return self;
}
- (void)selectAction:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(nickyPhotoListCellDidSelected:)]){
        [self.delegate nickyPhotoListCellDidSelected:self];
    }
}
- (void)setAssetModel:(NickyPhotoAlAssetModel *)assetModel{
    _assetModel = assetModel;
    self.thumbImageView.image = assetModel.thumbsImage;
    self.selectButton.selected = assetModel.isSelected;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _thumbImageView.frame = self.contentView.frame;
    _selectButton.frame = CGRectMake(self.contentView.frame.size.width-25, 5, 20, 20);
}
- (UIImageView *)thumbImageView{
    if (!_thumbImageView){
        _thumbImageView = [[UIImageView alloc]init];
        _thumbImageView.contentMode = UIViewContentModeScaleAspectFill;
        _thumbImageView.layer.masksToBounds = YES;
    }
    return _thumbImageView;
}
- (UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"my_choice"] forState:UIControlStateNormal];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"my_pitch on"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}


@end

@interface NickyPhotoImageListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,NickyPhotoImageListCellDelegate>

@property (strong,nonatomic) UICollectionViewFlowLayout                 *flowLayout;

@property (strong,nonatomic) UICollectionView                           *collectionView;

@property (strong,nonatomic) NSMutableArray                             *thumbsImageArray;

@property (strong,nonatomic) UIView                                     *bottomView;

@property (strong,nonatomic) UIButton                                   *previewButton;

@property (strong,nonatomic) UIButton                                   *finishButton;

@property (strong,nonatomic) NSMutableArray                             *selectedArray;
@end

@implementation NickyPhotoImageListViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
    [self updateSelectionStatus];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.albumName;
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    // Do any additional setup after loading the view.
}
- (void)finish:(NSArray *)callBackArray{
    if (self.naviController.pickerDelegate && [self.naviController.pickerDelegate respondsToSelector:@selector(nickyImagePicker:didSelectedImages:)]){
        [self.naviController.pickerDelegate nickyImagePicker:self.naviController didSelectedImages:callBackArray];
    }
    [self.naviController dismissViewControllerAnimated:YES completion:nil];
}
- (void)previewAction:(UIButton *)button{
    NickyPhotoPreviewController *previewController = [[NickyPhotoPreviewController alloc]init];
    previewController.selectedMode = YES;
    previewController.photoArray = self.selectedArray;
    [self.naviController pushViewController:previewController animated:YES];
}
- (void)finishAction:(UIButton *)button{
    __block int i = 0;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        NSMutableArray *callbackArray = [[NSMutableArray alloc]init];
        for (NickyPhotoAlAssetModel *assetModel in self.selectedArray) {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
            [library assetForURL:assetModel.photoURL resultBlock:^(ALAsset *asset) {
                i++;
                [callbackArray addObject:[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage]];
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
- (void)updateSelectionStatus{
    self.selectedArray = [[NSMutableArray alloc]init];
    BOOL isSelected = NO;
    NSInteger selectedNumber = 0;
    for (NickyPhotoAlAssetModel *assetModel in self.model.photoArray) {
        if (assetModel.selected){
            selectedNumber++;
            [self.selectedArray addObject:assetModel];
        }
    }
    isSelected = selectedNumber;
    self.previewButton.enabled = isSelected;
    self.finishButton.enabled = isSelected;
    [self.finishButton setTitle:[NSString stringWithFormat:@"完成( %zd )",selectedNumber] forState:UIControlStateNormal];
}

- (void)nickyPhotoListCellDidSelected:(NickyPhotoImageListCell *)cell{
    
    if (!cell.assetModel.selected && self.selectedArray.count>=PHOTOMAX_NUMBER) {

        UIAlertController*alertController=[UIAlertController alertControllerWithTitle:NSLocalizedString(@"最多只能选四张呦~", @"") message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *oklAction=[UIAlertAction actionWithTitle:NSLocalizedString(@"确定", @"") style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:oklAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;

    }
    cell.assetModel.selected = !cell.assetModel.selected;
    [self.collectionView reloadData];
    [self updateSelectionStatus];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NickyPhotoPreviewController *previewController = [[NickyPhotoPreviewController alloc]init];
    previewController.selectedMode = YES;
    previewController.photoArray = self.model.photoArray;
    previewController.currentPage = indexPath.item;
    [self.naviController pushViewController:previewController animated:YES];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NickyPhotoImageListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCellIdentifier forIndexPath:indexPath];
    NickyPhotoAlAssetModel *model = self.model.photoArray[indexPath.item];
    cell.assetModel = model;
    cell.delegate = self;
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.photoArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(imageListCellHeight,imageListCellHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2.5;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[NickyPhotoImageListCell class] forCellWithReuseIdentifier:photoCellIdentifier];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.contentInset = UIEdgeInsetsMake(64, 0, self.bottomView.bounds.size.height, 0);
        _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
        _collectionView.alwaysBounceVertical = YES;
        
    }
    return _collectionView;
}
- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout){
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    }
    return _flowLayout;
}
- (NSMutableArray *)thumbsImageArray{
    if (!_thumbsImageArray){
        _thumbsImageArray = [[NSMutableArray alloc]init];
    }
    return _thumbsImageArray;
}
- (UIView *)bottomView{
    if (!_bottomView){
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
        _bottomView.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA" alpha:.96];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _bottomView.bounds.size.width, .5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#C0C0C0"];
        [_bottomView addSubview:line];
        [_bottomView addSubview:self.previewButton];
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
- (UIButton *)previewButton{
    if (!_previewButton){
        _previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _previewButton.frame = CGRectMake(10, 0, 40, 44);
        _previewButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_previewButton setTitle:@"预览" forState:UIControlStateNormal];
        [_previewButton setTitleColor:[UIColor colorWithHexString:@"#121212"] forState:UIControlStateNormal];
        [_previewButton setTitleColor:[UIColor colorWithHexString:@"#cfcfcf"] forState:UIControlStateHighlighted];
        [_previewButton setTitleColor:[UIColor colorWithHexString:@"#cfcfcf"] forState:UIControlStateDisabled];
        [_previewButton addTarget:self action:@selector(previewAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _previewButton;
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [UIView animateWithDuration:.2 animations:^{
        
        self.collectionView.frame = self.view.bounds;
        
        self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44);
        
        self.finishButton.frame = CGRectMake(_bottomView.bounds.size.width-60-10, 0, 60, 44);
        self.previewButton.frame = CGRectMake(10, 0, 40, 44);
        
    }];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.navigationController.navigationBar.frame), 0,  self.bottomView.bounds.size.height, 0);
    self.collectionView.scrollIndicatorInsets = self.collectionView.contentInset;
    [self.collectionView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
