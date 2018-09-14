//
//  CityPickView.m
//  cityPickView
//
//  Created by room Blin on 2017/3/6.
//  Copyright © 2017年 digirun. All rights reserved.
//
#import "CityPickView.h"
#import "UIPickerView+mhPickerView.h"
@implementation CityPickView
{
    UIPickerView *_cityPickView;
    NSDictionary *_dicInfo; //存储的是整个dic
    NSDictionary *_provinceDic;//选中某个省后，从dicinfo里取出放在这个里面
    NSDictionary *_cityDic;     //选中某个市后，从provinceDic中取出放在这里;
    NSArray *_provinceNameArray;    //所有省市的名字数组
    NSArray *_cityNameArray;        //城市数组
    NSArray *_townNameArray;        //城镇array
    
    UIView *_toolsView; //上方的确定取消工具栏

    NSString *path;

}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        
       
        
        _cityPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40,self.frame.size.width,self.frame.size.height-40)];
        _cityPickView.delegate = self;
        _cityPickView.dataSource = self;
       
        [_cityPickView clearSpearatorLine];
        [self addSubview:_cityPickView];
        
        
        _toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        _toolsView.layer.borderWidth = 0.5;
        _toolsView.layer.borderColor = [UIColor clearColor].CGColor;
        [self addSubview:_toolsView];
        
       
        
        
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height-frame.size.height)];
        self.backGroundView = back;
        back.backgroundColor = [UIColor blackColor];
        back.alpha = 0.5;
        UITapGestureRecognizer *tap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [back addGestureRecognizer:tap1];
        [[UIApplication sharedApplication].keyWindow addSubview:back];
        
        

        
        
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-60, 0, 50, 40)];
        //button.backgroundColor = [UIColor lightGrayColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectIt) forControlEvents:UIControlEventTouchUpInside];
        [_toolsView addSubview:button];
        
        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 50, 40)];
        //button.backgroundColor = [UIColor lightGrayColor];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button2 setTitle:@"取消" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(cancelIt) forControlEvents:UIControlEventTouchUpInside];
        [_toolsView addSubview:button2];

    }
    return self;
}
- (void)setContentPath:(NSString*)content
{

    _dicInfo = [NSDictionary dictionaryWithContentsOfFile:content];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (int i = 0; i < _dicInfo.allKeys.count; i++) {
        NSDictionary *dic = [_dicInfo objectForKey:[@(i) stringValue]];
        
        [temp addObject:dic.allKeys[0]];
    }
    _provinceNameArray = temp;//省份数组
    
    //取第1个省,先取第1个，在用省份名字取
    _provinceDic = [[_dicInfo objectForKey:[@(0) stringValue]] objectForKey:_provinceNameArray[0]];
    _cityNameArray = [self getNameforProvince:0];//城市名字数组
    _townNameArray = [[_provinceDic objectForKey:@"0"] objectForKey:_cityNameArray[0]];
    
    
    _province = _provinceNameArray[0];
    _city = _cityNameArray[0];
    _area = _townNameArray[0];


}
-(void)tap{
    [self removeFromSuperview];
    [self.backGroundView removeFromSuperview];

}
- (void)selectIt{
   // self.confirmblock(_province,_city,_area);
    [self.backGroundView removeFromSuperview];

    self.doneBlock(_province,_city,_area);
}
- (void)cancelIt{
    [self.backGroundView removeFromSuperview];

    self.cancelblock();
}

- (void)setToolshidden:(BOOL)toolshidden{
    _toolshidden = toolshidden;
    if (_toolshidden) {
        _toolsView.hidden = YES;
    }
}

#pragma mark pickView-delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _provinceNameArray.count;
    }
    else if (component == 1){
        return _cityNameArray.count;
    }else if (component == 2){
        return _townNameArray.count;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    //去除分割线
    [pickerView clearSpearatorLine];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/3.0, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        label.text = _provinceNameArray[row];
    }else if (component == 1){
        label.text = _cityNameArray[row];
    }else if (component == 2){
        label.text = _townNameArray[row];
    }
    
    return label;
}

//三级联动从这里开始
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //这里是选中了省-然后根据省获取城市--在根据城市
    if (component == 0 ) {
        _cityNameArray = [self getNameforProvince:row];
        _townNameArray = [[_provinceDic objectForKey:@"0"] objectForKey:_cityNameArray[0]];
        [_cityPickView reloadComponent:1];
        [_cityPickView selectRow:0 inComponent:1 animated:YES];
        [_cityPickView reloadComponent:2];
        [_cityPickView selectRow:0 inComponent:2 animated:YES];
        
        _province = _provinceNameArray[row];
        _city = _cityNameArray[0];
        _area = _townNameArray[0];
    }else if (component == 1){  //这里是选中市的时候发生的变化
        _townNameArray = [[_provinceDic objectForKey:[@(row) stringValue]] objectForKey:_cityNameArray[row]];
        [_cityPickView reloadComponent:2];
        [_cityPickView selectRow:0 inComponent:2 animated:YES];
        
        
        _city = _cityNameArray[row];
        _area = _townNameArray[0];
    }else if (component == 2){
        _area = _townNameArray[row];
    }
    
    self.confirmblock(_province,_city,_area);
}

- (NSArray *)getNameforProvince:(NSInteger)row{
    _provinceDic = [[_dicInfo objectForKey:[@(row) stringValue]] objectForKey:_provinceNameArray[row]];
    
    NSMutableArray *temp2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < _provinceDic.allKeys.count; i++) {
        NSDictionary *dic = [_provinceDic objectForKey:[@(i) stringValue]];
        [temp2 addObject:dic.allKeys[0]];
    }
    
    return temp2;
}

- (void)setAddress:(NSString *)address{
    if (address) {
        NSArray *array = [address componentsSeparatedByString:@"-"];
        _province = array[0];
        _city = array[1];
        _area = array[2];
        
        //根据省份查找在第几个，
        NSInteger provinceIndex = [_provinceNameArray indexOfObject:_province]; //获取在第几个
        [_cityPickView reloadComponent:0];
        [_cityPickView selectRow:provinceIndex inComponent:0 animated:YES];
        
        _cityNameArray = [self getNameforProvince:provinceIndex];//城市名字数组
        [_cityPickView reloadComponent:1];
        
        NSInteger cityIndex = [_cityNameArray indexOfObject:_city];
        [_cityPickView selectRow:cityIndex inComponent:1 animated:YES];
        
        _townNameArray = [[_provinceDic objectForKey:[@(cityIndex) stringValue]] objectForKey:_city];
        [_cityPickView reloadComponent:2];
        [_cityPickView selectRow:[_townNameArray indexOfObject:_area] inComponent:2 animated:YES];
        
        
    }
}


@end
