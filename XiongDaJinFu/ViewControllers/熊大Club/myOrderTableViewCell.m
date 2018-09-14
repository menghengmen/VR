//
//  myOrderTableViewCell.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/7.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "myOrderTableViewCell.h"

@implementation myOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    NSMutableAttributedString *remind = [[NSMutableAttributedString alloc] initWithString:@"客服热线: \n18701843882"];
    [remind addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#999999"] range:NSMakeRange(0, 4)];
    [remind addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0,4)];
    
    
    [remind addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#333333"] range:NSMakeRange(5, remind.length-5)];
    [remind addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(5,remind.length-5)];

    [self.keFuPhone setAttributedText:remind];
    self.keFuPhone.numberOfLines = 0;
    
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"客服邮箱: \ninfo@blinroom.com"];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#999999"] range:NSMakeRange(0, 4)];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0,4)];
    
    
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#333333"] range:NSMakeRange(5, attributeStr.length-5)];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(5,attributeStr.length-5)];
    
    [self.keFuMail setAttributedText:attributeStr];
    self.keFuMail.numberOfLines = 0;
    
//    self.cancleBtn.hidden = true;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setOModel:(orderModel *)oModel{
    _oModel = oModel;
    self.topView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.orderNumberLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:10];

    
    self.orderNumberLabel.text = [NSString stringWithFormat:@"订单号：%@",oModel.order_no];

    [self.orderNumberLabel setTextColor:[UIColor colorWithHexString:@"#999999"]];
    
    

    [self.orderNamelabel setTextColor:[UIColor colorWithHexString:@"#333333"]];
    self.orderNamelabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
    self.orderNamelabel.text = oModel.name ;
    
    [self.orderState setTextColor:[UIColor colorWithHexString:@"#ef8157"]];
    self.orderState.font = [UIFont fontWithName:@"PingFang-SC-Light" size:11];

    self.keFuPhone.font = [UIFont fontWithName:@"PingFang-SC-Light" size:11];
    self.keFuMail.font = [UIFont fontWithName:@"PingFang-SC-Light" size:11];

   
    [self.cancleBtn setTintColor:[UIColor colorWithHexString:@"#28a8e0"]];
    self.cancleBtn.layer.cornerRadius=5;
    self.cancleBtn.layer.borderWidth = 1;
    self.cancleBtn.layer.borderColor = [[UIColor colorWithHexString:@"#28a8e0"] CGColor];
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://oe7fx58st.bkt.clouddn.com/20170320175922.jpg"]];


}
-(void)setApartMentModel:(apartmentModel *)apartMentModel{

    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:apartMentModel.title_image] placeholderImage:[UIImage imageNamed:@"main_default_img"]];

}

- (IBAction)cancleBtn:(UIButton *)sender {
    if (self.cancleBtnClick) {
        self.cancleBtnClick(0);
    }
    
    
    if ([self.delegate respondsToSelector:@selector(didCancleBtn)]&&self.delegate) {
        [self.delegate didCancleBtn];
    }

}

@end
