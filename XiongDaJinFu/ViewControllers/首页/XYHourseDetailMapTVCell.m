//
//  XYHourseDetailMapTVCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYHourseDetailMapTVCell.h"
#import <AFNetworking.h>
@implementation XYHourseDetailMapTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

-(void)tap:(UITapGestureRecognizer *)atp{
    if (self.mapTapBlock) {
        self.mapTapBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(XYFlatListModel *)model{
    _model = model;
    NSString *mapUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/staticmap?center=%@,%@&zoom=%@&size=%@&format=%@&maptype=%@&markers=size:mid|color:red|%@,%@&sensor=false",model.lat,model.lng,@"12",[NSString stringWithFormat:@"%dx%@&scale=2",(int)SCREEN_MAIN.width,@"190"],@"mobile",@"roadmap",model.lat,model.lng];
    
    NSString*url=[NSString stringWithFormat:@"%@?http=%@",@"http://relay-hk.blinroom.com:8080/common/forward",mapUrl];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.mapImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"map_default_img"]];
    self.addressLabel.text = model.address;
}

@end
