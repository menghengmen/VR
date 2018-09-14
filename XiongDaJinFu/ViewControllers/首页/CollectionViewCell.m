
//
//  CollectionViewCell.m
//  Blinroom
//
//  Created by Blinroom on 16/8/11.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.idTitle.textColor = [UIColor colorWithHexString:@"#666666"];
   // self.idTitle.font = [UIFont fontWithName:@"Ping-Fang-SC-Regular" size:13];
    self.imageview.contentMode = UIViewContentModeScaleAspectFill;
    self.imageview.clipsToBounds = YES;
    
    
    self.price3.textColor = [UIColor colorWithHexString:@"#ffffff"];
    
    self.prie1.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.price2.textColor = [UIColor colorWithHexString:@"#ffffff"];

    
    self.prie1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    self.price3.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    
    self.price2.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:19];
    

    
    self.bgview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
   
}
- (void)setModel:(zhiXunModel *)model{
    _model = model;
    self.idTitle.text = model.subtitle;
    self.prie1.text = model.title;
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GlobalImageUrl,model.title_image]]placeholderImage:[UIImage imageNamed:@"main_default_img"]];




}
- (void)setHotHouseModel:(hotHouse *)hotHouseModel{

    
    _hotHouseModel = hotHouseModel;
    self.price2.text = [NSString stringWithFormat:@"%@",hotHouseModel.price];
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:hotHouseModel.title_image]placeholderImage:[UIImage imageNamed:@"main_default_img"]];
    self.idTitle.text = hotHouseModel.name;
    
   // self.price3.text = [NSString stringWithFormat:@"/%@",[self queryWithStr:hotHouseModel.charge_unit].firstObject ];
   //货币单位
   NSMutableArray  * hbdwArr = [XDCommonTool queryPeiZhiWithKey:@"hbdw" withIdOrName:hotHouseModel.currency withType:@"id"];
    self.prie1.text = hbdwArr.firstObject;
    self.price3.text = [NSString stringWithFormat:@"/%@ 起",[XDCommonTool getDictValueWithSectionKey:@"dateUnit" andKey:hotHouseModel.date_unit] ];
    //self.price3.text = [self queryWithStr:hotHouseModel.charge_unit].firstObject ;
}
-(NSMutableArray*)queryWithStr:(NSString*)idStr{

    NSMutableArray  * dataArr = [NSMutableArray new];
    
    NSArray *unitArray = [XDCommonTool getSettingInfoWithKey:@"jjdw"];//时间单位数组

   [unitArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       if ([idStr isEqualToString:[obj objectForKey:@"alias"]]) {
           [dataArr addObject:[obj objectForKey:@"name_zh"]];
            
       }
   }];
    
    return dataArr;
}
@end
