//
//  CollectionViewCell.h
//  Blinroom
//
//  Created by Blinroom on 16/8/11.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zhiXunModel.h"
#import "hotHouse.h"
@protocol CollectionViewCellDelegate

- (void)didSelectItem:(NSIndexPath*)indexPath;
@end
@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *idTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UILabel *prilabel;
@property (weak, nonatomic) IBOutlet UILabel *prie1;
@property (weak, nonatomic) IBOutlet UILabel *price2;
@property (weak, nonatomic) IBOutlet UILabel *price3;
    @property (weak, nonatomic) IBOutlet UIView *bgview;


@property   (nonatomic,strong)   hotHouse  * hotHouseModel;

@property   (nonatomic,strong)   zhiXunModel  * model;

@property(weak)id<CollectionViewCellDelegate>delegate;

@end
