//
//  XYHourseDetailFacilitiesTBCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYHourseDetailFacilitiesTBCell.h"
@implementation XYHourseDetailFacilitiesTBCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModelsArray:(NSArray *)modelsArray{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.facilitieArray = modelsArray;
        [self creatUI:modelsArray];
    }
    return self;
}

-(void)creatUI:(NSArray *)modelsArray{
    //标题
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 150, 30)];
    title.textColor = [UIColor cyanColor];
    title.font = [UIFont systemFontOfSize:12];
    title.text = @"配套设施";
    [self.contentView addSubview:title];
    
    
    if (modelsArray.count <= foldLine *itemsInLine ) {//不要折叠按钮
        [self creatLabelButton:modelsArray.count andTitle:title];
    }else if (!self.isFold){
        [self creatLabelButton:itemsInLine*foldLine andTitle:title];
        [self creatFoldBtn:60 + 15 +2*btnWidth +20 +15];
    }else{
        [self creatLabelButton:modelsArray.count andTitle:title];
        [self creatFoldBtn:(modelsArray.count/itemsInLine -1)*20 + modelsArray.count/itemsInLine *btnWidth +2*15 +60];
    }
}

-(void)creatLabelButton:(NSInteger)btnNumber andTitle:(UILabel *)title{
    //设施标签
//    CGFloat btnWidth = (SCREEN_MAIN.width - 2*15 - (itemsInLine -1)*widthInButtons)/itemsInLine;//标签宽度
    for (int i = 0; i <btnNumber; i++) {
        UIButton * labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        labelBtn.frame = CGRectMake(15 + i%itemsInLine *(btnWidth +widthInButtons),CGRectGetMaxY(title.frame) +i/itemsInLine *(btnWidth +widthInButtons) , btnWidth, btnWidth);
        [self.contentView addSubview:labelBtn];
        [labelBtn setImage:[UIImage imageNamed:@"button_tianjia@3x"] forState:UIControlStateNormal];
    }
}

-(void)creatFoldBtn:(CGFloat)maxY{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, maxY, SCREEN_MAIN.width, 30);
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.contentView addSubview:btn];
    if (self.isFold) {
        [btn setTitle:@"合上" forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"展开" forState:UIControlStateNormal];
    }
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setIsFold:(BOOL)isFold{
    _isFold = isFold;
}

-(void)btnClick:(UIButton *)sender{
    _isFold = !self.isFold;
    if (self.foldBtnClickBlock) {
        self.foldBtnClickBlock(_isFold);
    }
}

-(CGFloat)getCellHeightWithArray:(NSArray *)modelsArray{
//    CGFloat btnWidth = (SCREEN_MAIN.width - 2*15 - (itemsInLine -1)*widthInButtons)/itemsInLine;//标签宽度
    if (modelsArray.count <= foldLine *itemsInLine ) {//不要折叠按钮
        return (modelsArray.count/itemsInLine -1)*20 + modelsArray.count/itemsInLine *btnWidth +2*15 +60 + 60;
    }else if (!self.isFold){
        return 60 + 15 +2*btnWidth +20 +15 +30;
    }else{
        return (modelsArray.count/itemsInLine -1)*20 + modelsArray.count/itemsInLine *btnWidth +2*15 +60 +30;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
