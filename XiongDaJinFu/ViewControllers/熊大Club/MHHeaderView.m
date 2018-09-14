//
//  MHHeaderView.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/30.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "MHHeaderView.h"
#import "labelview.h"

@interface MHHeaderView()

@property(nonatomic,strong)  UIImageView   * iconImageView;

@property(nonatomic,strong)  UILabel   *  nameLabel;
@property(nonatomic,strong)  UIImageView   * sexImageView;
@property(nonatomic,strong)  UILabel   * birthdayLabel;

@property(nonatomic,strong)  UILabel   *  placeLabel;

@property(nonatomic,strong)  labelview   *  labelView;

@property(nonatomic,strong)  UILabel   *  universityLabel;
@property(nonatomic,strong)  UILabel   *  majorLabel;


@end


@implementation MHHeaderView

-(UIImageView*)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-40, -40, 80, 80)];
   
        _iconImageView.image = [UIImage imageNamed:@"002.jpg"];
        _iconImageView.userInteractionEnabled = YES;
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.borderWidth = 1;
        _iconImageView.layer.borderColor =[[UIColor colorWithHexString:@"#ffffff"] CGColor];
        _iconImageView.layer.cornerRadius = 43;

       _iconImageView.layer.shadowColor = [UIColor colorWithHexString:@"#000000"].CGColor;
        _iconImageView.layer.shadowRadius = 10;
        [self addSubview:_iconImageView];
    }

    return _iconImageView;

}

-(UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _universityLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    
    }
    
    return _nameLabel;
    
}
-(UIImageView*)sexImageView{
    if (!_sexImageView) {
        _sexImageView = [[UIImageView alloc] init];
        _sexImageView.image = [UIImage imageNamed:@"person_icon_nan"];
    }
    
    return _sexImageView;
    
}
-(UILabel*)birthdayLabel{
    if (!_birthdayLabel) {
        _birthdayLabel = [[UILabel alloc] init];
        //_birthdayLabel.text = @"1991.07.13";
        _birthdayLabel.backgroundColor = [UIColor colorWithHexString:@"#51b2e2"];
        _birthdayLabel.clipsToBounds = YES;
        _birthdayLabel.layer.cornerRadius =10;
        _birthdayLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _birthdayLabel.font = [UIFont systemFontOfSize:10];
        _birthdayLabel.textAlignment = NSTextAlignmentCenter;

    }
    
    return _birthdayLabel;
    
}
-(UILabel*)placeLabel{
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc] init];
        _placeLabel.text = @"江苏 南京";
        _placeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _placeLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        _placeLabel.textAlignment = NSTextAlignmentCenter;

   
    }
    
    return _placeLabel;
    
}

//-(labelview*)labelView{
//    if (!_labelView) {

//        _labelView = [labelview alloc]initWithFrame:CGRectMake(0, 0, 0, 0) dataArr:self;
//   }
//  return _labelView;
//
//}
-(UILabel*)universityLabel{
    if (!_universityLabel) {
        _universityLabel = [[UILabel alloc] init];
       //_universityLabel.text = @"利物浦约翰莫里斯大学";
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

-(id)initWithdataArray:(NSDictionary *)dataArray{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GlobalImageUrl,dataArray[@"icon"] ]]];
        self.nameLabel.text = [dataArray objectForKey:@"name"];
    self.birthdayLabel.text = [dataArray objectForKey:@"birthday"];
    
     NSMutableArray  * universityArr = [XDCommonTool queryUniversityDataWithID:[NSString stringWithFormat:@"%@",dataArray[@"univ_id"]]withType:@"id"];
    self.universityLabel.text = universityArr.firstObject;
    
    
    //专业
    NSMutableArray  * mojorArr = [XDCommonTool queryPeiZhiWithKey:@"subject" withIdOrName:dataArray[@"major_id"] withType:@"id"];
    self.majorLabel.text = mojorArr.firstObject;

    
    
    [self addSubview:self.iconImageView];

    [self addSubview:self.nameLabel];
    [self addSubview:self.sexImageView];
    [self addSubview:self.birthdayLabel];
    [self addSubview:self.placeLabel];

    [self addSubview:self.universityLabel];
    [self addSubview:self.majorLabel];

    //兴趣爱好（个人标签）
    NSArray  * labelArr = [dataArray objectForKey:@"label"];
    NSMutableArray  * nameLabelArr = [NSMutableArray new];
    
    for (int i = 0; i <labelArr.count ; i++) {
        NSMutableArray  * idArr =    [XDCommonTool queryPeiZhiWithKey:@"grbq" withIdOrName:labelArr[i] withType:@"id"];
        [nameLabelArr addObject:idArr.firstObject];
    }
    
    
   // if (self.labelView!=nil) {
        self.labelView = [[labelview alloc]initWithFrame:CGRectMake(200, 0,SCREENWIDTH-100,0) dataArr:nameLabelArr];

    //}
    [self addSubview:self.labelView];

    
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@40);
        make.height.equalTo(@20);

    }];
   
  
    [self.sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(5);
        make.bottom.equalTo(self.nameLabel.mas_bottom);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        
    }];
    
    [self.birthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sexImageView.mas_right).offset(7);
        make.bottom.equalTo(self.nameLabel.mas_bottom);
        make.width.equalTo(@70);
        make.height.equalTo(@20);
        
    }];
    
    
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(6);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
        
    }];
    
    [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.placeLabel.mas_bottom).offset(-5);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@350);
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

    
    
    
    return self;
}

@end
