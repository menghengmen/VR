//
//  selectHeaderView.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/8.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "selectHeaderView.h"
// 选择器的宽度
#define Home_Seleted_Item_W 100
#define DefaultMargin       10

@interface selectHeaderView()

@property (nonatomic, weak)UIView *underLine;

@property (nonatomic, strong)UIButton *selectedBtn;
@property (nonatomic, weak)UIButton *peopleBtn;


@end

@implementation selectHeaderView
- (UIView *)underLine
{
    if (!_underLine) {
        UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-2, SCREENWIDTH/2 , 2)];
        underLine.backgroundColor = [UIColor colorWithHexString:@"#28a8e0"];
        [self addSubview:underLine];
        _underLine = underLine;
    }
    return _underLine;
}



- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.dataArray = [NSArray new];

        [self setup];
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }

    return self;
}

- (void)setup
{
    
    UIView  * topView = [UIView new];
    topView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.left.right.equalTo(self);
       make.height.equalTo(@4);
   }];
    
    
    
    UIButton *collectionBtn = [self createBtn:[NSString stringWithFormat:@"我的收藏.(%@)",@"1"] tag:HomeTypeCollection];
    UIButton *billBtn = [self createBtn:[NSString stringWithFormat:@"我的订单.(%@)",@"1"] tag:HomeTypeBill];
    [self addSubview:collectionBtn];
    [self addSubview:billBtn];
    
    [collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(DefaultMargin * 4));
        make.centerY.equalTo(self);
        make.width.equalTo(@Home_Seleted_Item_W);
    }];
    [billBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-DefaultMargin * 4));
        make.centerY.equalTo(self);
        make.width.equalTo(@Home_Seleted_Item_W);
    }];
   
    
    //中间的分割线
    UIView  * view  = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    [self addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
        make.height.equalTo(@20);
        make.width.equalTo(@2);
    }];

    
    // 默认选中最热
    [self click:collectionBtn];
}
- (UIButton *)createBtn:(NSString *)title tag:(HOMETYPE)tag
{
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[[UIColor grayColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#28a8e0"] forState:UIControlStateSelected];
    btn.tag = tag;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)setSelectedType:(HOMETYPE)selectedType
{
    _selectedType = selectedType;
    self.selectedBtn.selected = NO;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.tag == selectedType) {
            self.selectedBtn = (UIButton *)view;
            ((UIButton *)view).selected = YES;
        }
    }
    
}

// 点击事件
- (void)click:(UIButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.underLine.x = btn.tag*SCREENWIDTH/2;
    }];
    
    if (self.selectedBlock) {
        self.selectedBlock(btn.tag);
    }

}

@end
