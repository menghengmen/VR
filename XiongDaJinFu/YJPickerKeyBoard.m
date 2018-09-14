//
//  YJPickerKeyBoard.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/2/23.
//  Copyright © 2017年 digirun. All rights reserved.
//


#import "YJPickerKeyBoard.h"

@interface YJPickerKeyBoard () <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSString *changed;
    NSMutableArray  * dataArray;

}



@property (nonatomic, weak) UIPickerView *picker;

@end

@implementation YJPickerKeyBoard
+(YJPickerKeyBoard*)shareInstance {
    static  YJPickerKeyBoard  * pickBoard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pickBoard = [[YJPickerKeyBoard alloc] init];
    });
    
    return pickBoard;

}



- (instancetype)initWithFrame:(CGRect)frame
{
   
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        [self addSubview:view];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 60, 5, 50, 30)];
        btn.titleLabel.textAlignment = NSTextAlignmentRight;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        self.btn = btn;
  
    
        UIButton  * cancleBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom frame:CGRectMake(10, 5, 50, 30) normalImage:nil buttonTitle:@"取消" target:self action:@selector(cancle)];
        cancleBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
       
        [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [view addSubview:cancleBtn];

        self.cancleBtn = cancleBtn;
        
    
   
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height-frame.size.height)];
        self.backGroundView = back;
        back.backgroundColor = [UIColor blackColor];
        back.alpha = 0.5;
        UITapGestureRecognizer *tap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewDismiss)];
        [back addGestureRecognizer:tap1];
        [[UIApplication sharedApplication].keyWindow addSubview:back];
        
        

    
    
    
    }
    return self;
}

- (void)setContents:(NSArray *)contents
{
    _contents = contents;
    
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 40)];
    
    
    [self addSubview:picker];
    picker.delegate = self;
    picker.dataSource = self;
    self.picker = picker;
}


-(void)viewDismiss{
    [self.backGroundView removeFromSuperview];
    [self removeFromSuperview];

}

- (void)finish
{    [self.backGroundView removeFromSuperview];

    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(pickerBoardFinish:withData:)]) {
        [self.delegate pickerBoardFinish:changed withData:self.contents];
    }
}

- (void)cancle{
    [self removeFromSuperview];
    [self.backGroundView removeFromSuperview];


}




- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.contents.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *subArray = self.contents[component];
    return [subArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.contents[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    changed = self.contents[component][row];
}

@end
