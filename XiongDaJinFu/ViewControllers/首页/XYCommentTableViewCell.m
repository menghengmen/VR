//
//  XYCommentTableViewCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/24.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYCommentTableViewCell.h"
#import "XYCommentCollectionCell.h"
@implementation XYCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.picsCollectionView.delegate = self;
    self.picsCollectionView.dataSource = self;
    
    //图片处理布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    CGFloat width = (SCREEN_MAIN.width - 83 -44 -10)/3.0f;
    layout.itemSize = CGSizeMake(width , width );
    [self.picsCollectionView setCollectionViewLayout:layout];
    [self.picsCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ XYCommentCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([XYCommentCollectionCell class])];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setModel:(XYCommentModel *)model{
    _model = model;
    
    self.nameLabel.text = model.comment_obj.nick_name;
    
    [self.headerIamgeView sd_setImageWithURL:[NSURL URLWithString:model.comment_obj.icon] placeholderImage:[UIImage imageNamed:@"room_default_img"]];
    
//    self.timeLabel.text = model.created_time;
    
    self.desLabel.text = model.content;
    
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    [dateFormatter1 setDateFormat:@"yyyy"];
    self.yeaLabel.text = [dateFormatter1 stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.created_time integerValue]/1000]];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    [dateFormatter2 setDateFormat:@"MM.dd"];
    self.timeLabel.text = [dateFormatter2 stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.created_time integerValue]/1000]];
    
    //删除按钮
    NSDictionary *dict = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
    
    if ([[NSString stringWithFormat:@"%ld",[dict[@"id"] integerValue]] isEqualToString:model.comment]) {
        self.deleteBtnHeight.constant = 23;
        self.deleteBtn.hidden = false;
    }else{
        self.deleteBtnHeight.constant = 0;
        self.deleteBtn.hidden = true;
    }
    
//    CGFloat width = (SCREEN_MAIN.width - 83 -44 -10)/3.0f ;
//    NSInteger lines = model.images.count/3 + (model.images.count %3 == 0?0:1) ;
    
//    CGFloat height = lines *width +(lines -1) *5;
    if (model.images.count == 0 || !model.images) {
//        self.picCollectionViewHeight.constant = 0;
        self.picsCollectionView.hidden = true;
    }else{
//        self.picCollectionViewHeight.constant = height;
        self.picsCollectionView.hidden = false;
    }
    [self.picsCollectionView reloadData];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.images.count;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYCommentCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XYCommentCollectionCell class]) forIndexPath:indexPath];
    [cell.commentImageView sd_setImageWithURL:[NSURL URLWithString:self.model.images[indexPath.item]] placeholderImage:[UIImage imageNamed:@"room_default_img"]];
    @weakify(cell);
    cell.imageClickBlock = ^(){
        @strongify(cell);
        if (self.imageClickBlock1) {
            self.imageClickBlock1(indexPath.item,[self.picsCollectionView convertRect:cell.frame toView:self.contentView]);
        }
    };
    return cell;
}


- (IBAction)deleteBtnClick:(UIButton *)sender {
    if (self.deleteBtnCLickBlock) {
        self.deleteBtnCLickBlock();
    }
}
@end
