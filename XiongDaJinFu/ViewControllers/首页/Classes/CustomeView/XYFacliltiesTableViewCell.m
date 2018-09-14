//
//  XYFacliltiesTableViewCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/12.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYFacliltiesTableViewCell.h"
#import "XYFailitiesCollectionCell.h"
@interface XYFacliltiesTableViewCell()
@property (nonatomic,strong)NSMutableArray *facArray;
@end

@implementation XYFacliltiesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGFloat itemWidth = (SCREEN_MAIN.width -63/2.0 *2 * SCREEN_MAIN.width/414.0 -128/2.0*3 *SCREEN_MAIN.width/414.0)/4;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(itemWidth, itemWidth+30);
    layout.minimumInteritemSpacing =SCREEN_MAIN.width/414.0*64;
    layout.minimumLineSpacing = 10;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView setCollectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XYFailitiesCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([XYFailitiesCollectionCell class])];
    
    
    [self.moreBtn setImage:[UIImage imageNamed:@"jiantou_up"] forState:UIControlStateNormal];
    [self.moreBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:0];
}

-(NSMutableArray *)facArray{
    if (!_facArray) {
        _facArray = [NSMutableArray array];
    }
    return _facArray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(XYFlatListModel *)model{
    _model = model;
    
    if (model.facility.count <= 8) {
        self.moreBtnHeight.constant = 0;
        self.moreBtn.hidden = true;
    }else{
        self.moreBtnHeight.constant = 27;
        self.moreBtn.hidden = false;
    }
    self.facArray = [NSMutableArray arrayWithArray:model.facility];
    [self.collectionView reloadData];
}

-(void)setIsOpen:(BOOL)isOpen{
    _isOpen = isOpen;
    if (isOpen) {
        [self.moreBtn setTitle:@"收起更多" forState:UIControlStateNormal];
        [self.moreBtn setImage:[UIImage imageNamed:@"jiantou_up"] forState:UIControlStateNormal];
       self.facArray = [NSMutableArray arrayWithArray:self.model.facility];
    }else if(self.facArray.count >= 8){
       self.facArray = [NSMutableArray arrayWithArray:[self.model.facility subarrayWithRange:NSMakeRange(0, 8)]];
        [self.moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [self.moreBtn setImage:[UIImage imageNamed:@"jiantou_down"] forState:UIControlStateNormal];
    }else{
        self.facArray = [NSMutableArray arrayWithArray:self.model.facility];
    }
    [self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.facArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYFailitiesCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XYFailitiesCollectionCell class]) forIndexPath:indexPath];
//    cell.nameLabel.text =@"bingxiang";
    cell.model = self.facArray[indexPath.item];
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,SCREEN_MAIN.width/414.0* 31.5, 20, SCREEN_MAIN.width/414.0*31.5);
}

- (IBAction)moreBtnClick:(UIButton *)sender {
//    self.isOpen =!self.isOpen;
//    [self.collectionView reloadData];
    if (self.moreBtnClickBlock) {
        self.moreBtnClickBlock(!self.isOpen);
    }
}
@end
