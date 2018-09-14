//
//  XYPublishCommentPicCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/28.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYPublishCommentPicCell.h"
#import "XYPublishCommentPicCollectionCell.h"
@interface XYPublishCommentPicCell()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic,strong)NSMutableArray *picArray;//处理完的图片数组
@end

@implementation XYPublishCommentPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    CGFloat width = (SCREEN_MAIN.width -43)/3.0f;
    layout.itemSize = CGSizeMake(width, width);
    self.collectionView.scrollEnabled = false;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XYPublishCommentPicCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([XYPublishCommentPicCollectionCell class])];
    [self.collectionView setCollectionViewLayout:layout];
    
    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handlelongGesture:)];
    [self.contentView addGestureRecognizer:longGes];
}

-(NSMutableArray *)picArray{
    if (!_picArray) {
        _picArray = [NSMutableArray array];
    }
    return _picArray;
}

-(void)setArray:(NSArray *)array{
    _array = array;
    self.picArray = [NSMutableArray arrayWithArray:array];
    [self.picArray addObject:[UIImage imageNamed:@"addPic"]];
    
    [self.collectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count ==9 ? 9:self.array.count +1;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 10, 10);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYPublishCommentPicCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XYPublishCommentPicCollectionCell class]) forIndexPath:indexPath];
    UIImage *image =self.picArray[indexPath.item];
    cell.commentPic.image = image;
    if (indexPath.item == self.picArray.count -1) {
        cell.picType = 2;
    }else{
        cell.picType = 1;
    }
    @weakify(self);
    cell.deleteBtnClickBlock = ^(){
        @strongify(self);
        if (self.deleteBlock) {
            self.deleteBlock(indexPath.item);
        }
    };
    
    cell.picClickBlock = ^(){
        @strongify(self);
        if (self.getPicBlock) {
            self.getPicBlock();
        }
    };
    return cell;
}

#pragma mark -- 移动图片的方法
- (void)handlelongGesture:(UILongPressGestureRecognizer *)longPress{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
//        [self action:longPress];
    } else {
        [self iOS9_Action:longPress];
    }
}

#pragma mark - iOS9 之后的方法
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == self.picArray.count -1 && self.array.count <9) {
        return NO;
    }
    // 返回YES允许row移动
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //取出移动row数据
    id color = self.picArray[sourceIndexPath.row];
    //从数据源中移除该数据
    [self.picArray removeObject:color];
    //将数据插入到数据源中的目标位置
    [self.picArray insertObject:color atIndex:destinationIndexPath.row];
}

- (void)iOS9_Action:(UILongPressGestureRecognizer *)longPress
{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
        { //手势开始
            //判断手势落点位置是否在row上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
            if (indexPath == nil) {
                break;
            }
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            [self bringSubviewToFront:cell];
            //iOS9方法 移动cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
        { // 手势改变
            // iOS9方法 移动过程中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:self.collectionView]];
        }
            break;
        case UIGestureRecognizerStateEnded:
        { // 手势结束
            // iOS9方法 移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            if (self.imageSequenceBlock) {
                self.imageSequenceBlock([self.picArray subarrayWithRange:NSMakeRange(0, self.picArray.count-1)]);
            }
        }
            break;
        default: //手势其他状态
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
