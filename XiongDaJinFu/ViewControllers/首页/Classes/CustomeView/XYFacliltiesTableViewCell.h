//
//  XYFacliltiesTableViewCell.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/12.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYFlatListModel.h"
@interface XYFacliltiesTableViewCell : UITableViewCell<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moreBtnHeight;

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (nonatomic,strong) XYFlatListModel *model;
@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic,copy) void(^moreBtnClickBlock)(BOOL isOpen);
- (IBAction)moreBtnClick:(UIButton *)sender;
@end
