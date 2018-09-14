//
//  YJPersonInfoCell.m
//  WalkTogether
//
//  Created by boding on 15/5/12.
//  Copyright (c) 2015年 GYJ. All rights reserved.
//

#import "YJPersonInfoCell.h"


@interface YJPersonInfoCell()<UITextFieldDelegate>

@end

@implementation YJPersonInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)personInfoCellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"YJPersonInfoCell";
    YJPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[YJPersonInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.text.enabled = NO;
    }
    cell.text.enabled=NO;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *name = [[UILabel alloc] init];
        [self.contentView addSubview:name];
        self.name = name;
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView).offset(15);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(110);
        }];
        
        UIImageView *jiantou = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_more"]];
        [self.contentView addSubview:jiantou];
        
        [jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(10);
            make.width.mas_equalTo(4.5);
        }];
        
        UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(100, 7, SCREENWIDTH - 140, 30)];
        [self.contentView addSubview:text];
        [text addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventAllEvents];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(name.mas_right).offset(20);
            make.right.mas_equalTo(jiantou.mas_left).offset(-10);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        UIView *line = [[UIView alloc]init];
        self.line = line;
        line.backgroundColor = [UIColor colorWithHex:0xe5e5e5];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right);
            make.height.mas_equalTo(0.5);
        }];
        
        text.textAlignment = NSTextAlignmentRight;
        text.enabled = NO;
        text.delegate =self;
        self.text = text;
        self.text.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        self.name.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];

        [self.name setTextColor:[UIColor colorWithHexString:@"#666666"] ];
        [self.text setTextColor:[UIColor colorWithHexString:@"#666666"] ];
        

    }
    return self;
}

-(void)valueChanged:(UITextField *)text{
    if ([self.delegate respondsToSelector:@selector(personInfoChange:andCell:)]) {
        [self.delegate personInfoChange:text.text andCell:self];
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    if ([self.delegate respondsToSelector:@selector(personInfoChange:andCell:)]) {
//        [self.delegate personInfoChange:textField.text andCell:self];
//    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(personInfoBeginEdit:andCell:)]) {
        [self.delegate personInfoBeginEdit:textField andCell:self];
    }
}
@end
