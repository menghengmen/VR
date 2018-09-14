//
//  XYFlatListTableViewCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/14.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYFlatListTableViewCell.h"
#import "XYSettingInfoModel.h"
@implementation XYFlatListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //标签半角
    
    self.priceLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    self.priceLabel.clipsToBounds = true;
    self.priceLabel.layer.cornerRadius = 5.0f;
    
    self.labelBtn.layer.borderColor = [UIColor colorWithHex:0x29a7e1].CGColor;
    self.labelBtn.layer.borderWidth = 0.5f;
    self.labelBtn.layer.cornerRadius = 3.0f;
    self.backgroundColor = [UIColor clearColor];
    
    self.labelBtn2.layer.borderColor = [UIColor colorWithHex:0x29a7e1].CGColor;
    self.labelBtn2.layer.borderWidth = 0.5f;
    self.labelBtn2.layer.cornerRadius = 3.0f;
    self.backgroundColor = [UIColor clearColor];
    
    self.showdownView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.showdownView.layer.shadowOffset = CGSizeMake(0, -0.5);
    self.showdownView.layer.shadowOpacity = 0.25f;
    self.showdownView.layer.shadowRadius = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)favouriteBtnClick:(id)sender{
    if (self.likeBtnClickBlock) {
        self.likeBtnClickBlock(!self.model.like);
    }
}

-(void)setModel:(XYFlatListModel *)model{
    _model = model;
    self.flatNameLabel.text = model.name;
    self.desLabel.text = model.address;
    [self.flatImageView sd_setImageWithURL:[NSURL URLWithString:model.title_image] placeholderImage:[UIImage imageNamed:@"main_default_img"]];
    
    if (model.like) {
        [self.favouriteBtn setBackgroundImage:[UIImage imageNamed:@"shoucang_icon_xin_-pre"] forState:UIControlStateNormal];
    }else{
        [self.favouriteBtn setBackgroundImage:[UIImage imageNamed:@"shoucang_icon_xin"] forState:UIControlStateNormal];
    }
    
    if (model.price.length == 0) {
        model.price = @"-";
    }
    
    
    NSString *currency;
    if (model.currency.length == 0) {
        currency = [self.country isEqualToString:@"1"]?@"£":@"$";
    }
    
    NSString *chare;
    if (model.charge_unit.length == 0) {
        chare = [self.country isEqualToString:@"1"]?@"周":@"月";
    }
    
    NSString *charge =self.settingDict?[XYToolCategory getInfoFormDict:self.settingDict andPropertyKey:@"hbdw" privateKey:model.currency?model.currency:@""]: [XDCommonTool getDictValueWithSectionKey:@"hbdw" andKey:model.currency?model.currency:@""];
    NSString *unit =self.settingDict?[XYToolCategory getInfoFormDict:self.settingDict andPropertyKey:@"dateUnit" privateKey:model.date_unit?model.date_unit:@""]: [XDCommonTool getDictValueWithSectionKey:@"dateUnit" andKey:model.date_unit?model.date_unit:@""];
    
    NSString *price = [NSString stringWithFormat:@"%@%@/%@ 起",model.currency.length == 0?currency:charge,model.price,model.charge_unit.length == 0?chare:unit];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:price];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(model.charge_unit.length == 0?1:charge.length, model.price.length)];
    self.priceLabel.attributedText = attStr;
    
    if (model.label && model.label.count >0) {
        if (model.label.count == 1) {
            NSString *label = self.settingDict?[XYToolCategory getInfoFormDict:self.settingDict andPropertyKey:@"tsbq" privateKey:model.label[0]]:[XDCommonTool getDictValueWithSectionKey:@"tsbq" andKey:model.label[0]];
            if (label.length >0) {
                self.labelBtn.hidden = false;
                [self.labelBtn setTitle:label forState:UIControlStateNormal];
            }else{
                [self.labelBtn setTitle:@"" forState:UIControlStateNormal];
                self.labelBtn.hidden = true;
            }
            self.labelBtn2.hidden = true;
            [self.labelBtn2 setTitle:@"" forState:UIControlStateNormal];
        }else{
            NSString *label = self.settingDict?[XYToolCategory getInfoFormDict:self.settingDict andPropertyKey:@"tsbq" privateKey:model.label[0]]:[XDCommonTool getDictValueWithSectionKey:@"tsbq" andKey:model.label[0]];
            NSString *label2 =self.settingDict?[XYToolCategory getInfoFormDict:self.settingDict andPropertyKey:@"tsbq" privateKey:model.label[1]]: [XDCommonTool getDictValueWithSectionKey:@"tsbq" andKey:model.label[1]];
            if (label.length == 0 && label2.length != 0) {
                self.labelBtn.hidden = true;
                self.labelBtn2.hidden = false;
                [self.labelBtn setTitle:@"" forState:UIControlStateNormal];
                [self.labelBtn2 setTitle:label2 forState:UIControlStateNormal];
            }else if (label2.length == 0 && label.length != 0){
                self.labelBtn.hidden = false;
                self.labelBtn2.hidden = true;
                [self.labelBtn setTitle:label forState:UIControlStateNormal];
                [self.labelBtn2 setTitle:@"" forState:UIControlStateNormal];
            }else{
                self.labelBtn.hidden = false;
                self.labelBtn2.hidden = false;
                [self.labelBtn setTitle:label forState:UIControlStateNormal];
                [self.labelBtn2 setTitle:label2 forState:UIControlStateNormal];
            }
        }
    }else{
        self.labelBtn.hidden = true;
        self.labelBtn2.hidden = true;
        [self.labelBtn setTitle:@"" forState:UIControlStateNormal];
        [self.labelBtn2 setTitle:@"" forState:UIControlStateNormal];
        
    }
}

-(void)setApartModel:(apartModel *)apartModel{
    _apartModel = apartModel;
    XYLikeApartmentModel *model1 = apartModel.be_liked_apartment;
    self.flatNameLabel.text = model1.name;
    self.desLabel.text = model1.address;
    [self.flatImageView sd_setImageWithURL:[NSURL URLWithString:model1.title_image] placeholderImage:[UIImage imageNamed:@"main_default_img"]];
    
//    if (model.like) {
        [self.favouriteBtn setBackgroundImage:[UIImage imageNamed:@"shoucang_icon_xin_-pre"] forState:UIControlStateNormal];
//    }else{
//        [self.favouriteBtn setBackgroundImage:[UIImage imageNamed:@"shoucang_icon_xin"] forState:UIControlStateNormal];
//    }
    
    if (model1.price.length == 0) {
        model1.price = @"-";
    }
    
    
    NSString *currency;
    if (model1.currency.length == 0) {
        currency = [self.country isEqualToString:@"1"]?@"£":@"$";
    }
    
    NSString *chare;
    if (model1.charge_unit.length == 0) {
        chare = [self.country isEqualToString:@"1"]?@"周":@"月";
    }
    
    NSString *charge = [XDCommonTool getDictValueWithSectionKey:@"hbdw" andKey:model1.currency];
    NSString *unit = [XDCommonTool getDictValueWithSectionKey:@"dateUnit" andKey:model1.date_unit];
    
    NSString *price = [NSString stringWithFormat:@"%@%@/%@ 起",model1.currency.length == 0?currency:charge,model1.price,model1.charge_unit.length == 0?chare:unit];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:price];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(model1.charge_unit.length == 0?1:charge.length, model1.price.length)];
    self.priceLabel.attributedText = attStr;
    
    if (model1.label && model1.label.count >0) {
        if (model1.label.count == 1) {
            NSString *label = [XDCommonTool getDictValueWithSectionKey:@"tsbq" andKey:model1.label[0]];
            if (label.length >0) {
                self.labelBtn.hidden = false;
                [self.labelBtn setTitle:label forState:UIControlStateNormal];
            }else{
                [self.labelBtn setTitle:@"" forState:UIControlStateNormal];
                self.labelBtn.hidden = true;
            }
            self.labelBtn2.hidden = true;
            [self.labelBtn2 setTitle:@"" forState:UIControlStateNormal];
        }else{
            NSString *label = [XDCommonTool getDictValueWithSectionKey:@"tsbq" andKey:model1.label[0]];
            NSString *label2 = [XDCommonTool getDictValueWithSectionKey:@"tsbq" andKey:model1.label[1]];
            if (label.length == 0 && label2.length != 0) {
                self.labelBtn.hidden = true;
                self.labelBtn2.hidden = false;
                [self.labelBtn setTitle:@"" forState:UIControlStateNormal];
                [self.labelBtn2 setTitle:label2 forState:UIControlStateNormal];
            }else if (label2.length == 0 && label.length != 0){
                self.labelBtn.hidden = false;
                self.labelBtn2.hidden = true;
                [self.labelBtn setTitle:label forState:UIControlStateNormal];
                [self.labelBtn2 setTitle:@"" forState:UIControlStateNormal];
            }else{
                self.labelBtn.hidden = false;
                self.labelBtn2.hidden = false;
                [self.labelBtn setTitle:label forState:UIControlStateNormal];
                [self.labelBtn2 setTitle:label2 forState:UIControlStateNormal];
            }
        }
    }else{
        self.labelBtn.hidden = true;
        self.labelBtn2.hidden = true;
        [self.labelBtn setTitle:@"" forState:UIControlStateNormal];
        [self.labelBtn2 setTitle:@"" forState:UIControlStateNormal];
        
    }
}

@end
