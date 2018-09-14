//
//  peopleTableViewCell.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "peopleTableViewCell.h"


@implementation peopleTableViewCell


-(UIImageView*)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        
        _iconImageView.alpha = 0;
     
    }
    
    return _iconImageView;
    
}

-(UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"小明";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    }
    
    return _nameLabel;
    
}
-(labelview*)labelView{
    if (!_labelView) {

        _labelView = [[labelview alloc]init];
    }
  return _labelView;

}

-(UIImageView*)sexImageView{
    if (!_sexImageView) {
        _sexImageView = [[UIImageView alloc] init];
        //_sexImageView.image = [UIImage imageNamed:@"person_icon_nan"];
    }
    
    return _sexImageView;
    
}
-(UILabel*)birthdayLabel{
    if (!_birthdayLabel) {
        _birthdayLabel = [[UILabel alloc] init];
        _birthdayLabel.backgroundColor = [UIColor colorWithHexString:@"#51b2e2"];
        _birthdayLabel.clipsToBounds = YES;
        _birthdayLabel.layer.cornerRadius =7.5;
        _birthdayLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _birthdayLabel.font = [UIFont systemFontOfSize:10];
        _birthdayLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
    return _birthdayLabel;
    
}
-(UILabel*)placeLabel{
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc] init];
        _placeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _placeLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        _placeLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    
    return _placeLabel;
    
}

-(UILabel*)universityLabel{
    if (!_universityLabel) {
        _universityLabel = [[UILabel alloc] init];
        _universityLabel.text = @"利物浦约翰莫里斯大学";
        _universityLabel.textAlignment = NSTextAlignmentCenter;
        _universityLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _universityLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:16];
    }
    
    return _universityLabel;
    
}

-(UILabel*)majorLabel{
    if (!_majorLabel) {
        _majorLabel = [[UILabel alloc] init];
        _majorLabel.text = @"计算机科学";
        _majorLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        _majorLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _majorLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    
    return _majorLabel;
    
}

-(void)setPeopleModel:(peopleModel *)peopleModel{
    _peopleModel = peopleModel;
    self.nameLabel.text = peopleModel.nick_name;
   
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    [dateFormatter2 setDateFormat:@"yyyy.mm.dd"];
    //NSString *birthdayStr =[dateFormatter2 stringFromDate:[NSDate dateWithTimeIntervalSince1970:[peopleModel.birthday integerValue]]];
    
    NSString * birthdayStr = [peopleModel.birthday stringByReplacingOccurrencesOfString:@"-" withString:@"."];
                           

    
    //生日
    self.birthdayLabel.text = peopleModel.birthday==nil ?@"未设置":birthdayStr;
    
    if (peopleModel.birthday ==nil) {
       // self.birthdayLabel.alpha = 0;
        LRLog(@"没生日");
    }
    
    //性别
    if ([peopleModel.sex isEqualToNumber:@0]) {
        _sexImageView.image = [UIImage imageNamed:@"person_icon_nan"];

    } else{
    
        _sexImageView.image = [UIImage imageNamed:@"person_icon_nv"];

    }

    
    self.placeLabel.text = peopleModel.be_from==nil ?@"未设置":peopleModel.be_from;
    if (peopleModel.be_from == nil) {
       // [self.placeLabel removeFromSuperview];
    }
   
    
    //我的标签
    
    NSMutableArray  * nameLabelArr = [NSMutableArray new];
    
    for (int i = 0; i <peopleModel.label.count ; i++) {
        NSMutableArray  * idArr =[XDCommonTool queryPeiZhiWithKey:@"grbq" withIdOrName:peopleModel.label[i] withType:@"id"];
        [nameLabelArr addObject:idArr.firstObject];
    }
    self.labelView.dataArray = nameLabelArr;
   
    if (self.labelView.dataArray.count == 0) {
        LRLog(@"没有标签");
    }
    
    
    //大学
    NSMutableArray  * universityArr = [XDCommonTool queryUniversityDataWithID:peopleModel.univ_id withType:@"id"];
    NSString   * univerStr =  universityArr.firstObject==nil?@"未设置":universityArr.firstObject;
    self.universityLabel.text = univerStr;
    //专业
    NSMutableArray  * mojorArr = [XDCommonTool queryPeiZhiWithKey:@"subject" withIdOrName:peopleModel.major_id withType:@"id"];
    NSString   * majorStr =  mojorArr.firstObject==nil?@"未设置":mojorArr.firstObject;

    
    self.majorLabel.text = majorStr;


//
    //名字
    self.nameLabelG.text = peopleModel.nick_name;
    
    //性别
    if ([peopleModel.sex isEqualToNumber:@0]) {
        _sexIamgeViewG.image = [UIImage imageNamed:@"person_icon_nan"];
        
    } else{
        
        _sexIamgeViewG.image = [UIImage imageNamed:@"person_icon_nv"];
        
    }
    
    //地址
    self.placeLabelG.text = peopleModel.be_from==nil ?@"":peopleModel.be_from;
    
    //生日
    NSString * birthdayStrG = [peopleModel.birthday stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    self.birthdayLabelG.text = peopleModel.birthday==nil ?@"":[NSString stringWithFormat:@"  %@  ",birthdayStrG];
    
    //标签
    NSMutableArray  * nameLabelArrG = [NSMutableArray new];
    
    for (int i = 0; i <peopleModel.label.count ; i++) {
        NSMutableArray  * idArr =[XDCommonTool queryPeiZhiWithKey:@"grbq" withIdOrName:peopleModel.label[i] withType:@"id"];
        [nameLabelArrG addObject:idArr.firstObject];
    }
    
    if (nameLabelArrG.count ==3) {
        self.label4Space.constant = 0;
        self.lable3Space.constant = 5;
        self.label2Space.constant = 5;
    }else if (nameLabelArrG.count == 2){
        self.label4Space.constant = 0;
        self.lable3Space.constant = 0;
        self.label2Space.constant = 5;
    }else if (nameLabelArrG.count == 1){
        self.label4Space.constant = 0;
        self.lable3Space.constant = 0;
        self.label2Space.constant = 0;
    }
    
    if (peopleModel.label.count <=4 && peopleModel.label.count>0) {
        self.labelViewHeight.constant = 20;
        for (int i = 0; i<4 - peopleModel.label.count; i++) {
            [nameLabelArrG addObject:@""];
        }
        
        NSString *str1 = nameLabelArrG[0];
        self.label1.text = str1.length >0?[NSString stringWithFormat:@" %@ ",str1]:@"";
        
        NSString *str2 = nameLabelArrG[1];
        self.label2.text = str2.length >0?[NSString stringWithFormat:@" %@ ",str2]:@"";
        
        NSString *str3 = nameLabelArrG[2];
        self.label3.text = str3.length >0?[NSString stringWithFormat:@" %@ ",str3]:@"";
        
        NSString *str4 = nameLabelArrG[3];
        self.label4.text = str4.length >0?[NSString stringWithFormat:@" %@ ",str4]:@"";
        
    }else{
        self.labelViewHeight.constant = 0;
        self.label1.text = @"";
        self.label2.text = @"";
        self.label3.text = @"";
        self.label4.text = @"";
    }
    
    //大学
    NSMutableArray  * universityArrG = [XDCommonTool queryUniversityDataWithID:peopleModel.univ_id withType:@"id"];
    NSString   * univerStrG =  universityArrG.firstObject==nil?@"":universityArrG.firstObject;
    self.universityLabelG.text = univerStrG;
    //专业
    NSMutableArray  * mojorArrG = [XDCommonTool queryPeiZhiWithKey:@"subject" withIdOrName:peopleModel.major_id withType:@"id"];
    NSString   * majorStrG =  mojorArrG.firstObject==nil?@"":mojorArrG.firstObject;
    self.majorLabelG.text = majorStrG;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.label1.layer.borderColor = [UIColor colorWithHex:0xef5de1].CGColor;
    self.label2.layer.borderColor = [UIColor colorWithHex:0xf7ce53].CGColor;
    self.label3.layer.borderColor = [UIColor colorWithHex:0x39bdfa].CGColor;
    self.label4.layer.borderColor = [UIColor colorWithHex:0xf78153].CGColor;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.sexImageView];
        [self addSubview:self.birthdayLabel];
        [self addSubview:self.placeLabel];
        [self addSubview:self.universityLabel];
        [self addSubview:self.majorLabel];
       
        if (self.labelView!=nil) {
            [self.labelView.itemBtn removeFromSuperview];
        }
        [self addSubview:self.labelView];

        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImageView.superview.mas_top).offset(-43);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@86);
            make.height.equalTo(@86);
            
        }];
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@40);
            make.height.equalTo(@20);
        }];
        
        
        [self.sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).offset(5);
            make.bottom.equalTo(self.nameLabel.mas_bottom);
            make.width.equalTo(@15);
            make.height.equalTo(@15);
            
        }];
        
        [self.birthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sexImageView.mas_right).offset(7);
            make.bottom.equalTo(self.nameLabel.mas_bottom);
            make.width.equalTo(@70);
            make.height.equalTo(@15);
            
        }];
        
        
        [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@140);
            make.height.equalTo(@20);
            
        }];
        
       
        
        [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.placeLabel.mas_bottom).offset(-5);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@200);
            make.height.equalTo(@30);
            
        }];
        
        
        
        [self.universityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labelView.mas_bottom).offset(5);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@200);
            make.height.equalTo(@20);
            
        }];
       
        [self.majorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.universityLabel.mas_bottom).offset(2);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@200);
            make.height.equalTo(@15);
            
        }];
        
        
        
        
        UILabel *btn = [UILabel new];
        btn.clipsToBounds = true;
        btn.layer.masksToBounds = true;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 5;
        btn.backgroundColor = [UIColor whiteColor];

    }
    
    
    return self;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
