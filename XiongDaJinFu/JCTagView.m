//
//  JCTagView.m
//  JCLabel
//
//  Created by room Blin on 2017/3/6.
//  Copyright © 2017年 digirun. All rights reserved.
//


#import "JCTagView.h"

#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING   3.0f
#define LABEL_MARGIN       10.0f
#define BOTTOM_MARGIN      10.0f

///随机颜色
#define RandomColor  [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];

@interface JCTagView ()
{
    CGRect _previousFrame;
    int _totalHeight;
    UIButton *_tag;
   
   //能最大选择的数目
    NSInteger max_select;

    //当前选择的数目
    NSInteger selectCount;

}

@end

@implementation JCTagView



- (NSMutableArray*)selectNameArray{
    
    if (!_selectNameArray) {
        _selectNameArray = [[NSMutableArray alloc] init];
    }
    
    return _selectNameArray;
}



//初始化方法
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setBtn];
        
//        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.frame.size.width-frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height)];
//        self.backgroundView = back;
//        back.backgroundColor = [UIColor blackColor];
//        back.alpha = 0.5;
//        UITapGestureRecognizer *tap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
//        [back addGestureRecognizer:tap1];
//        [[UIApplication sharedApplication].keyWindow addSubview:back];
    
    }
    
    return self;
}

-(void)tap{

    [self.backgroundView removeFromSuperview];
    [self removeFromSuperview];
    

}
//设置 标签数组
- (void)setArrayTagWithLabelArray:(NSArray *)array withMaxSelected:(NSInteger)maX
 {
   

     max_select = maX;
     //[self setBtn];
    //设置frame
    _previousFrame = CGRectMake(0, 44, self.width, 44);

     [array enumerateObjectsUsingBlock:^(NSString*str, NSUInteger idx, BOOL *stop) {
    [self setupBtnWithNSString:str];
    }];
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self setupBtnWithNSString:obj];
//        
//    }];
    ///设置整个View的背景
    if(_JCbackgroundColor){
        
        self.backgroundColor = _JCbackgroundColor;
        LRLog(@"--------%@",_JCbackgroundColor);
    }else{
        self.backgroundColor=[UIColor whiteColor];
    }
    LRLog(@"---+++++-----%@",_JCbackgroundColor);
}


- (void)setBtn{
    
    
    UILabel*label = [UILabel new];
    [label setTextColor:[UIColor colorWithHexString:@"#cfcfcf"]];
    label.text = @"选择属性标签，有助于找到好室友哦！ (最多四个)";
    label.font = [UIFont systemFontOfSize:10];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.superview.mas_top).offset(60);
        make.left.equalTo(label.superview.mas_left).offset(10);
    }];
    
    
    UIButton  * sureBtn =  [XDCommonTool newButtonWithType:UIButtonTypeCustom frame:CGRectMake(0, 300, 100, 100) normalImage:nil buttonTitle:@"确定" target:self action:@selector(btnClick:)];
   [self addSubview:sureBtn];
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    sureBtn.layer.cornerRadius = 3;

    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.bottom.equalTo(sureBtn.superview.mas_bottom).offset(-10);
       make.right.equalTo(sureBtn.superview.mas_right).offset(-8);
        make.left.equalTo(self.mas_centerX).offset(2);

  
    }];
   

    UIButton  * cancleBtn =  [XDCommonTool newButtonWithType:UIButtonTypeCustom frame:CGRectMake(0, 300, 100, 100) normalImage:nil buttonTitle:@"取消" target:self action:@selector(btnClick:)];
    [self addSubview:cancleBtn];
    cancleBtn.layer.borderColor = [[UIColor colorWithHexString:@"#29a7e1"] CGColor];
    cancleBtn.layer.borderWidth =0.5f;
    cancleBtn.layer.cornerRadius = 3;
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    cancleBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [cancleBtn setTitleColor:[UIColor colorWithHexString:@"#29a7e1"] forState:UIControlStateNormal];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cancleBtn.superview.mas_bottom).offset(-10);
        make.left.equalTo(cancleBtn.superview.mas_left).offset(8);
        make.right.equalTo(self.mas_centerX).offset(-2);
        
    }];



}

- (void)btnClick:(UIButton*)sender{
    [self.backgroundView removeFromSuperview];
    if ([sender.titleLabel.text isEqualToString:@"确定"]) {
        [self.delegate tagClick:self.selectNameArray];
        return;
    }
    [self dismiss];
    
}

//初始化按钮

- (void)setupBtnWithNSString:(NSString *)str {
    //初始化按钮
    _tag = [UIButton buttonWithType:UIButtonTypeCustom];
    //_tag.frame = CGRectZero;
    if (_JCSignalTagColor) {
        _tag.backgroundColor = _JCSignalTagColor;
    }else {
        _tag.backgroundColor = RandomColor;
    }
    //设置内容水平居中
    _tag.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_tag setTitle:str forState:UIControlStateNormal];
    //设置字体的大小
    _tag.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    _tag.layer.cornerRadius = 3.0f;
    _tag.layer.masksToBounds = YES;
    //设置字体的颜色
    [_tag setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateNormal];
    //设置方法
    [_tag addTarget:self action:@selector(clickHandle:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
    CGSize StrSize = [str sizeWithAttributes:attribute];
    StrSize.height = 25;
    StrSize.width += HORIZONTAL_PADDING * 2;
    StrSize.height += VERTICAL_PADDING *2;
    ///新的 SIZE
    CGRect  NewRect = CGRectZero;
    
    if (_previousFrame.origin.x + _previousFrame.size.width + StrSize.width + LABEL_MARGIN > self.bounds.size.width) {
        
        NewRect.origin = CGPointMake(10, _previousFrame.origin.y + StrSize.height + BOTTOM_MARGIN);
        _totalHeight += StrSize.height + BOTTOM_MARGIN;
    }else {
        NewRect.origin = CGPointMake(_previousFrame.origin.x + _previousFrame.size.width + LABEL_MARGIN, _previousFrame.origin.y);
    }
    NewRect.size = StrSize;
    [_tag setFrame:NewRect];
    _previousFrame = _tag.frame;
  //  [self setHight:self andHight:_totalHeight + StrSize.height + BOTTOM_MARGIN];
    [self setHight:self andHight:SCREENHEIGHT];
   
    [self addSubview:_tag];
    ///设置背景 颜色
   

}

-(void)dismiss{
 
//  [UIView animateWithDuration:0.6 animations:^{
//      
//  } completion:^(BOOL finished) {
//      self.frame = CGRectMake(SCREENWIDTH, 0, 1, SCREENHEIGHT);
//      [self removeFromSuperview];
//
//  }];
    
    if (self.finshBlock) {
        self.finshBlock();
    }

}

#pragma mark-改变控件高度
- (void)setHight:(UIView *)view andHight:(CGFloat)hight
{
    CGRect tempFrame = view.frame;
    tempFrame.size.height = hight;
    view.frame = tempFrame;
}


#pragma mark==========按钮的处理方法

///按钮的处理方法
- (void)clickHandle:(UIButton *)sender{

   
    if (sender.selected ==YES) {
        selectCount--;
        sender.selected = NO;
        sender.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
        
        [sender setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateNormal];

        [self.selectNameArray removeObject:sender.titleLabel.text];
    
    }
    else{
    
        if (selectCount<max_select) {
            selectCount++;
           
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            sender.selected = YES;
            sender.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
            [self.selectNameArray addObject:sender.titleLabel.text];
        }
    
        else{
       
            [XDCommonTool alertWithMessage:[NSString stringWithFormat:@"超过最大选择数目%ld个",(long)max_select]];
          
        }
  
    
    }

}

@end
