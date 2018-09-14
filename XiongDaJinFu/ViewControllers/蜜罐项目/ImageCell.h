//
//  ImageCell.h
//  WalkTogether2
//
//  Created by gw on 16/3/30.
//  Copyright © 2016年 GYJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageCell;

@protocol ImageCellDelegate <NSObject>

- (void)imageCell:(ImageCell *)cell withIndexPath:(NSIndexPath *)indexPath;

@end

@interface ImageCell : UICollectionViewCell

@property (nonatomic, weak) id<ImageCellDelegate> delegate;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
