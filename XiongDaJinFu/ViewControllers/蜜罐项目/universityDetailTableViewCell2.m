//
//  universityDetailTableViewCell2.m
//  Blinroom
//
//  Created by room Blin on 2016/10/17.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "universityDetailTableViewCell2.h"

@implementation universityDetailTableViewCell2

-(UILabel*)introduceLabel{

    if (!_introduceLabel) {
        _introduceLabel = [[UILabel alloc] init];
        
    }
    return _introduceLabel;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    

    //为透明度设置渐变效果
   self.yinYingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    self.yinYingView.userInteractionEnabled = NO;
    UIColor *colorOne = [UIColor colorWithRed:0  green:0  blue:0  alpha:0.4f];
    UIColor *colorTwo = [UIColor colorWithRed:0  green:0  blue:0  alpha:0];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(0, 1);
    gradient.colors = colors;
    gradient.frame = CGRectMake(0, 0,SCREENWIDTH, 80);
    [self.yinYingView.layer insertSublayer:gradient atIndex:0];
    [self addSubview:self.yinYingView];
    
    [self bringSubviewToFront:self.universityNameView];
   
    
    
    //播放
    UIButton  * boFangBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"boFang" buttonTitle:nil target:self action:@selector(btnClick:)];
    boFangBtn.tag =104;
    [self addSubview:boFangBtn];
    [boFangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@65);
        make.height.equalTo(@65);

    }];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
   
    self.universityNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
    self.universityEnLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    
    
    
    self.universityNameLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.universityEnLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];

   
    self.contentView1.backgroundColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.5f];
    [self.shareBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:2];
    [self.commentBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
    [self.houseBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];


    self.universityIntroduceView.backgroundColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.5f];
    self.introduceTitleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    self.introduceTitleLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];

    self.introduceView.backgroundColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.5f];
    
    self.introduceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    self.introduceLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.introduceLabel.numberOfLines = 0;
     self.introduceLabel.text = @"剑桥大学（英文：University of Cambridge）坐落于英国剑桥，与牛津大学、伦敦大学学院、帝国理工学院、伦敦政治经济学院同属“G5超级精英大学”。剑桥大学是英国本土历史最悠久的高等学府之一在学校800多年的历史中，涌现出牛顿、达尔文等一批引领时代的科学巨匠。";
    
  self.universityNameLabel.text = @"剑桥大学（英文：University of Cambridge";


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)detailCell2WithTableView:(UITableView *)tableView{
    
    static NSString *identity = @"universityDetailCell2";
    universityDetailTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"universityDetailTableViewCell2" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }
    return cell;
    
}

- (void)setModel:(UniversityModel *)model{
    model = model;
    self.universityNameLabel.text = model.name_zh;
    self.universityEnLabel.text = model.name_en;
    
    
    self.introduceLabel.text = [NSString stringWithFormat:@"      %@",model.intro_zh];


}

- (IBAction)btnClick:(UIButton *)sender {
      if ([self.delegate respondsToSelector:@selector(detailCell:didSelectBnt:)]&&self.delegate) {
      
          [self.delegate detailCell:self didSelectBnt:sender.tag];
    
      }


}

@end
