//
//  XYCommentTableVCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/29.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYCommentTableVCell.h"

@implementation XYCommentTableVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIButton *)headerImageView{
    if (!_headerImageView) {
//        image.backgroundColor = [UIColor colorWithRandomColor];
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(15, 15, 57, 57);
        layer.backgroundColor = [UIColor clearColor].CGColor;
        layer.shadowOffset = CGSizeMake(0, 0);
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOpacity = 0.35;
        layer.cornerRadius = 57/2.0f;
        
        //这里self表示当前自定义的view
        [self.layer addSublayer:layer];
        
        _headerImageView = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerImageView.frame =CGRectMake(15, 15, 57, 57);
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.layer.cornerRadius = 57/2.0f;
        [_headerImageView addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerImageView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(83, 25, 100, 30)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textColor = [UIColor colorWithHex:0x29a7e1];
        _nameLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    return _nameLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxY(self.nameLabel.frame), 15, self.frame.size.width - CGRectGetMaxY(self.nameLabel.frame) - 15, 30)];
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _timeLabel;
}

-(UILabel *)desLabel{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 90, SCREEN_MAIN.width - 30 - 15, 999)];
        _desLabel.textColor = [UIColor blackColor];
        _desLabel.numberOfLines = 0;
//        _desLabel.lineBreakMode =NSLineBreakByCharWrapping;
        _desLabel.font = [UIFont systemFontOfSize:15];
    }
    return _desLabel;
}

-(ESCommpicsViewG *)picsView{
    if (!_picsView) {
        _picsView = [[ESCommpicsViewG alloc]initWithFrame:CGRectMake(30, 0, SCREEN_MAIN.width -45, 10)];
    }
    return _picsView;
}

-(UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.desLabel];
    [self.contentView addSubview:self.picsView];
    [self.contentView addSubview:self.deleteButton];
}


-(void)setModel:(XYCommentModel *)model{
    _model = model;
    self.nameLabel.text = model.comment_obj.nick_name;
    [self.headerImageView setImage:[UIImage imageNamed:@"Yosemite00"] forState:UIControlStateNormal];
    self.timeLabel.text = model.created_time;
    self.desLabel.text = model.content;
//    CGSize size = [self.desLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.desLabel.font,NSFontAttributeName, nil]];
    CGSize size = [self.desLabel.text boundingRectWithSize:CGSizeMake(self.desLabel.frame.size.width, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.desLabel.font,NSFontAttributeName, nil] context:nil].size;
    self.desLabel.frame = CGRectMake(30, 90, size.width, size.height);
    
    NSArray *pics = model.images;
    self.picsView.picsPathArray = pics;
    CGFloat picWidth = (SCREEN_MAIN.width -45 -5*2)/3;
    self.picsView.frame = CGRectMake(30, CGRectGetMaxY(self.desLabel.frame), pics.count>3?SCREEN_MAIN.width -45:picWidth,pics.count ==0?0:((pics.count - 1)/3 +1)*picWidth +(pics.count -1)/3 *5);
    
//    NSDictionary *dict = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
    self.deleteButton.frame = CGRectMake(SCREEN_MAIN.width - 15 -40, CGRectGetMaxY(self.picsView.frame), 40, 20);
}

-(CGFloat)getTableViewCellHeight:(XYCommentModel *)model{
    CGFloat picWidth = (SCREEN_MAIN.width -45 -5*2)/3;
    if (model.content && model.content.length>0) {
        CGSize size = [model.content boundingRectWithSize:CGSizeMake(self.desLabel.frame.size.width, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.desLabel.font,NSFontAttributeName, nil] context:nil].size;
        if (model.images.count == 0) {
            return 90 +size.height+20+15;
        }
        return 90 +size.height+20+15 +((model.images.count-1)/3 +1)*picWidth +5*(model.images.count-1)/3;
    }else{
        return 90 +((model.images.count-1)/3 +1)*picWidth +5*(model.images.count-1)/3 +20 +15;
    }
}

-(void)deleteBtnClick:(UIButton *)sender{
    if (self.deleteBtnClickBlock) {
        self.deleteBtnClickBlock();
    }
}

-(void)headerClick:(UIButton *)sender{
    if (self.headerClickBlock) {
        self.headerClickBlock();
    }
}

@end
