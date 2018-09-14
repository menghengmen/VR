//
//  topicPublishCell.m
//  WalkTogether2
//
//  Created by gw on 16/3/30.
//  Copyright © 2016年 GYJ. All rights reserved.
//

#import "topicPublishCell.h"
#import "ImageCell.h"
#import "AddImageCell.h"


@interface topicPublishCell () <UICollectionViewDelegate, UICollectionViewDataSource,ImageCellDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTips;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation topicPublishCell

- (void)awakeFromNib
{
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ImageCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AddImageCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AddImageCell"];
    
    self.inputContent.delegate = self;
}

- (NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
 
    if (self.imageArr.count == kMaxImageCount) {
        return self.imageArr.count;
    }
    
    return self.imageArr.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.row == self.imageArr.count && self.imageArr.count < kMaxImageCount) {
        AddImageCell *addImageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddImageCell" forIndexPath:indexPath];
        return addImageCell;
    }
    ImageCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    imageCell.indexPath = indexPath;
    imageCell.delegate = self;
    imageCell.image = self.imageArr[indexPath.row];
    return imageCell;
    
   
}


#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.imageArr.count && self.imageArr.count < kMaxImageCount) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(itemClickWithIndex:)]) {
            [self.delegate itemClickWithIndex:indexPath];
        }
        
    }
}

#pragma mark -ImageCellDelegate
- (void)imageCell:(ImageCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    [self.imageArr removeObjectAtIndex:indexPath.row];
    [self.collectionView reloadData];
    if (self.imageArr.count < kMaxImageCount && self.imageArr.count > 2) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.imageArr.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

#pragma mark -UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        self.lblTips.hidden = YES;
    }
    else
    {
        self.lblTips.hidden = NO;
    }
}

#pragma mark -refreshCollectionView
- (void)refreshCollectionView:(NSMutableArray *)arr
{
    self.imageArr = arr;
    [self.collectionView reloadData];
    if (arr.count < kMaxImageCount && self.imageArr.count > 2) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:arr.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

@end
