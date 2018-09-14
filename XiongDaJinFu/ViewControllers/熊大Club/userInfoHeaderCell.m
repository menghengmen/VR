//
//  userInfoHeaderCell.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/7.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "userInfoHeaderCell.h"

@implementation userInfoHeaderCell
- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.bgImageView];
        [self.bgImageView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.iconImageView.superview);
            make.left.equalTo(self.iconImageView.mas_left).mas_offset(80);
            
        }];
        
    
    }
    return self;
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [self.bgImageView setFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    
   
   
    
    // [self.userNameLabel setFrame:CGRectMake(10, 0, self.frame.size.width - 10, self.frame.size.height)];


}
#pragma mark - Getter
- (UILabel *) titleLabel
{
    if (_userNameLabel == nil) {
        _userNameLabel = [[UILabel alloc] init];
        [_userNameLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_userNameLabel setTextColor:[UIColor blackColor]];
    }
    return _userNameLabel;
}
- (UIImageView*)bgImageView{
    if (_bgImageView==nil) {
        _bgImageView = [[UIImageView alloc] init];
        
        _bgImageView.backgroundColor = [UIColor grayColor];
    }

    return _bgImageView;
}
- (UIImageView*)iconImageView{
    if (_iconImageView ==nil) {
        _iconImageView = [UIImageView new];
        _iconImageView.backgroundColor = [UIColor greenColor];
        _iconImageView.layer.cornerRadius =100;
    }

    return _iconImageView;

}

@end
