//
//  XYHouresDetailInfotableViewCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/13.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYHouresDetailInfotableViewCell.h"

@implementation XYHouresDetailInfotableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

-(void)setModel:(XYFlatListModel *)model{
    _model = model;
    
    //入住时间
    
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.check_in_time integerValue]/1000];
    self.timeLabel.text = [dataFormatter stringFromDate:date];
    
    if (model.check_in_time ==0) {
        self.timeLabel.text = @"----/--/--";
    }
    
    //最短入住时长
    self.timeLength.text = [NSString stringWithFormat:@"%@%@",model.shortest_lease,model.shortest_lease_unit];
    
    if (model.shortest_lease.length == 0) {
        self.timeLength.text = @"-/-";
    }
    
    //房型
    self.hourseTypelabel.text = [XDCommonTool getDictValueWithSectionKey:@"bzfjlx" andKey:model.type_id];
    if (model.type_id.length == 0) {
        self.hourseTypelabel.text = @"-";
    }
    
    //最多入住人数
    if (!(model.max_people.length > 0)) {
        model.max_people = @"-";
    }
    self.peopleNumLabel.text = [NSString stringWithFormat:@"%@人",model.max_people];
    
    //价格
    self.priceLabel.text = model.price;
    if (model.price.length == 0) {
        self.priceLabel.text = @"-";
    }
    
    //单位
    self.unitLable.text = [NSString stringWithFormat:@"%@/%@", [XDCommonTool getDictValueWithSectionKey:@"hbdw" andKey:model.currency],[XDCommonTool getDictValueWithSectionKey:@"dateUnit" andKey:model.date_unit]];
    if (model.currency.length == 0 || model.charge_unit.length == 0) {
        self.unitLable.text = @"-/-";
    }
    
//    LxDBAnyVar([XDCommonTool getDictValueWithSectionKey:@"dateUnit" andKey:model.date_unit]);
//    LxDBAnyVar([XDCommonTool getDictValueWithSectionKey:@"hbdw" andKey:model.currency]);
    
    //费用包含
    NSMutableString *freed = [NSMutableString string];
    if (model.include_cost && model.include_cost.count >0) {
        for (NSString *str in model.include_cost) {
            [freed appendString:[NSString stringWithFormat:@" %@",[XDCommonTool getDictValueWithSectionKey:@"bhfy" andKey:str]]];
        }
        self.noteLabel.text = [NSString stringWithFormat:@"包含：%@",freed];
    }else{
        self.noteLabel.text = @"";
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)scheduleBtnClick:(UIButton *)sender {
    if (self.scheduleBtnClickBlock) {
        self.scheduleBtnClickBlock();
    }
}
@end
