//
//  XYHourseSiftTableView.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/6.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYHourseSiftTableView.h"
#import "XYAddressModel.h"
#import "XYSiftButton.h"
#import "XYSiftPriceTableViewCell.h"
#import "XYSiftUnivTableViewCell.h"
#import "XYSiftHourseNumTableVCell.h"
#import "XYHourseSiftHeader.h"
@interface XYHourseSiftTableView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UILabel *universityLabel;
@property (nonatomic,strong)XYHourseSiftHeader *header;
@property (nonatomic,assign)NSInteger segmentIndex;

@property (nonatomic,strong)NSMutableArray *sectionDataArray;//所有按钮数据（没分组之前）
@property (nonatomic,strong)NSMutableArray *sectionArray;//分组数据（分组了）
@property (nonatomic,strong)NSMutableArray *sectionBtnArray;//按钮分组数据（分组了）
@property (nonatomic,strong)NSMutableArray *universitiesArray;//大学数据
@property (nonatomic,strong)NSArray *stayArray;
@property (nonatomic,assign)BOOL isOpen;

@property (nonatomic,strong)NSMutableArray *UKHotArray;//英国
@property (nonatomic,strong)NSMutableArray *USAHotArray;

@end

@implementation XYHourseSiftTableView
{
    NSInteger _currentSelectSection;//当前选中的组
    NSInteger _currentSelectIndex;
    NSString *_countryId;
    NSString *_cityId;
    NSString *_universityId;
    NSString *_minPrice;
    NSString *_maxPrice;
    NSString *_hourseNum;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _currentSelectSection = 9999;
        _currentSelectIndex = 9999;
        [self creatUI];
        self.segmentIndex = 0;
        self.isOpen = false;
    }
    return self;
}

-(NSMutableArray *)UKHotArray{
    if (!_UKHotArray) {
//        _UKHotArray = [NSMutableArray arrayWithArray:@[@"4",@"6",@"15",@"14",@"118",@"20",@"35",@"9",@"10"]];
        _UKHotArray = [NSMutableArray arrayWithArray:@[@"伦敦",@"曼彻斯特",@"利物浦",@"谢菲尔德",@"伯明翰",@"纽卡斯尔",@"考文垂",@"格拉斯哥",@"诺丁汉"]];
    }
    return  _UKHotArray;
}

-(NSMutableArray *)USAHotArray{
    if (!_USAHotArray) {
//        _USAHotArray = [NSMutableArray arrayWithArray:@[@"94",@"61",@"69",@"68",@"75",@"78",@"63"]];
        _USAHotArray = [NSMutableArray arrayWithArray:@[@"波士顿",@"纽约",@"洛杉矶",@"费城",@"旧金山",@"西雅图",@"芝加哥"]];
    }
    return  _USAHotArray;
}

-(NSMutableArray *)universitiesArray{
    if (!_universitiesArray) {
        _universitiesArray = [NSMutableArray array];
        NSDictionary *university = [NSDictionary dictionaryWithContentsOfFile:[XDCommonTool getFilePath:@"allUniversity.plist"]];
        NSArray *universities = university[@"result"];
        for (NSDictionary *dict in universities) {
            XYUnivModel *model = [XYUnivModel yy_modelWithDictionary:dict];
            [_universitiesArray addObject:model];
        }
        
    }
    return _universitiesArray;
}


-(NSMutableArray *)sectionDataArray{
    if (!_sectionDataArray) {
        _sectionDataArray = [NSMutableArray array];
    }
    return _sectionDataArray;
}

-(NSMutableArray *)sectionBtnArray{
    if (!_sectionBtnArray) {
        _sectionBtnArray = [NSMutableArray array];
    }
    return _sectionBtnArray;
}

-(NSMutableArray *)sectionArray{
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

-(XYHourseSiftHeader *)header{
    if (!_header) {
        _header = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([XYHourseSiftHeader class]) owner:nil options:nil][0];
        self.universityLabel = _header.areaLabel;
    }
    return _header;
}

-(void)setSegmentIndex:(NSInteger)segmentIndex{
    if (segmentIndex !=_segmentIndex) {
        
    }else{
        
    }
    _segmentIndex = segmentIndex;
    if (segmentIndex == 0) {
        _countryId = @"1";
    }else if (segmentIndex == 1){
        _countryId = @"50";
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[XDCommonTool getFilePath:@"allAddress.plist"]];
    
    NSArray *array = dict[@"result"];
    
    if (array.count>0) {
        [self.sectionDataArray removeAllObjects];
        if (segmentIndex == 0) {
            [self detailOrginalDataWithWegmentIndex:segmentIndex andArray:array];
        }else if (segmentIndex == 1 && array.count ==2){
            [self detailOrginalDataWithWegmentIndex:segmentIndex andArray:array];
        }
        self.isOpen = false;
        self.header.isOpen = self.isOpen;
    }else{
        [MBProgressHUD showError:@"获取城市信息失败"];
    }

}

//处理原始数据
-(void)detailOrginalDataWithWegmentIndex:(NSInteger)index andArray:(NSArray *)array{
    
    //获取当前国家的城市
    NSArray *arr = array[index][@"child"];
    for (NSDictionary *dic in arr) {
        XYAddressModel *model = [XYAddressModel yy_modelWithDictionary:dic];
        model.isSelectSection = false;
//        if (model.hot && [model.hot integerValue]>0) {
            [self.sectionDataArray addObject:model];
//        }
    }
    
    self.sectionDataArray = [self sequenceDataArray:index];
    self.stayArray = [NSArray arrayWithArray:self.sectionDataArray];
    
    //处理分组信息
    [self reloadBtnAndSectionArray];
}

//数据根据热度排序
-(NSMutableArray *)sequenceDataArray:(NSInteger)index{
    NSMutableArray *array = [NSMutableArray array];
    if (index == 0) {//英国
        [self sequenceWithHot:self.UKHotArray andArray:array];
    }else if (index == 1){//美国
        [self sequenceWithHot:self.USAHotArray andArray:array];
    }
    return array;
}

-(void)sequenceWithHot:(NSArray *)array andArray:(NSMutableArray *)dataArray{
    
    for (NSString *str in array) {
        for (XYAddressModel *model in self.sectionDataArray) {
            if ([str isEqualToString:model.name_zh]) {
                [dataArray addObject:model];
                break;
            }
        }
    }
    
    NSInteger count = array.count;
    NSArray *arr = [NSArray arrayWithArray:dataArray];
    for (XYAddressModel *model in self.sectionDataArray) {
        NSInteger i = 0;
        for (XYAddressModel *model1 in arr) {
            if (![model.addressId isEqualToString:model1.addressId]) {
                i++;
                if (i == count) {
                    [dataArray addObject:model];
                }
            }
        }
    }
}





-(void)areaBtnClick:(UIButton *)sender{
    for (int i = 0; i<self.sectionDataArray.count; i++) {
        XYAddressModel *model = self.sectionDataArray[i];
        if (i == sender.tag -1000) {
            if (!model.isSelectSection) {
                model.isSelectSection = true;
                _cityId = model.addressId;
                _universityId = @"";
            }else{
                
            }
        }else{
            if (model.isSelectSection) {
                model.isSelectSection = false;
            }
        }
    }
    
    XYAddressModel *model = self.sectionDataArray[sender.tag -1000];
    _currentSelectSection = [self getSectionWithId:model.addressId];
    _currentSelectIndex = sender.tag -1000;
    //TODO:刷新
    [self.tableView reloadData];//按钮刷新
    self.universityLabel.text = model.name_zh;
    //大学刷新
    if (!model.univs) {
        NSMutableArray *univ = [NSMutableArray array];
        //全部
        XYUnivModel *model1 = [[XYUnivModel alloc]init];
        model1.name_zh = @"全部";
        model1.isSelected = true;
        [univ addObject:model1];
        
        for (XYUnivModel *unModel in self.universitiesArray) {
            if ([unModel.address_id isEqualToString:model.addressId]) {
                unModel.isSelected =false;
                [univ addObject:unModel];
            }
        }
        model.univs = univ;
    }
    [self.tableView reloadData];
}

-(NSInteger)getSectionWithId:(NSString *)index{
    for (int i = 0; i<self.sectionArray.count; i++) {
        NSArray *arr =self.sectionArray[i];
        for (int j = 0; j<arr.count; j++) {
            XYAddressModel *model = arr[j];
            if ([index isEqualToString: model.addressId]) {
                return i;
            }
        }
    }
    return 0;
}

-(void)setIsOpen:(BOOL)isOpen{
    _isOpen = isOpen;
    if (isOpen) {
        self.sectionDataArray = [NSMutableArray arrayWithArray:self.stayArray];
    }else{
        if (_segmentIndex == 0) {//英国
            self.sectionDataArray = [NSMutableArray arrayWithArray:[self.stayArray subarrayWithRange:NSMakeRange(0, self.stayArray.count>=self.UKHotArray.count?self.UKHotArray.count:self.stayArray.count)]];

        }else if (_segmentIndex == 1){
            self.sectionDataArray = [NSMutableArray arrayWithArray:[self.stayArray subarrayWithRange:NSMakeRange(0, self.stayArray.count>=self.USAHotArray.count?self.UKHotArray.count:self.stayArray.count)]];

        }
    }
    [self reloadBtnAndSectionArray];
    [self.tableView reloadData];
}

-(void)reloadBtnAndSectionArray{
    [self.sectionArray removeAllObjects];
    [self.sectionBtnArray removeAllObjects];
    //处理分组信息
    NSMutableArray *arr1 = [NSMutableArray arrayWithArray:self.sectionDataArray];
    CGFloat beforeBtnMaxX = 5;
    NSInteger currentIndex = 0;//当前组的第一个元素的下标
    //        CGFloat currentBtnMaxX = 15;//要放的按钮的最大坐标
    NSMutableArray *btnArray = [NSMutableArray array];
    for (int i = 0; i<self.sectionDataArray.count; i++) {
        XYAddressModel *model = self.sectionDataArray[i];
        XYSiftButton *button = [[XYSiftButton alloc]init];
        button.isSelectOnly = model.isSelectSection;
        [button setTitle:model.name_zh forState:UIControlStateNormal];
        [btnArray addObject:button];
        button.tag = 1000 +i;
        model.tag = 1000 +i;
        [button addTarget:self action:@selector(areaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        CGSize size =[button.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:button.titleLabel.font,NSFontAttributeName, nil]];
        CGRect rect =CGRectMake(beforeBtnMaxX +10, 5, size.width +20, 30);//将要放的按钮的坐标
        if (CGRectGetMaxX(rect) >= self.frame.size.width ) {//不够放
            beforeBtnMaxX = 15;
            button.frame = CGRectMake(beforeBtnMaxX, 5, size.width +30, 30);
            NSMutableArray *arr2 = [NSMutableArray arrayWithArray:[arr1 subarrayWithRange:NSMakeRange(currentIndex, i-currentIndex)]];
            NSMutableArray *arr3 = [NSMutableArray arrayWithArray:[btnArray subarrayWithRange:NSMakeRange(currentIndex, i-currentIndex)]];
            [self.sectionArray addObject:arr2];
            [self.sectionBtnArray addObject:arr3];
            currentIndex = i;
            
        }else{//够放
            button.frame = rect;
            beforeBtnMaxX = CGRectGetMaxX(button.frame);
            if (i == self.sectionDataArray.count -1) {
                NSMutableArray *arr2 = [NSMutableArray arrayWithArray:[arr1 subarrayWithRange:NSMakeRange(currentIndex, i-currentIndex +1)]];
                NSMutableArray *arr3 = [NSMutableArray arrayWithArray:[btnArray subarrayWithRange:NSMakeRange(currentIndex, i-currentIndex +1)]];
                [self.sectionArray addObject:arr2];
                [self.sectionBtnArray addObject:arr3];
            }
        }
        beforeBtnMaxX = CGRectGetMaxX(button.frame);
    }
}

-(void)creatUI{
    
    //tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height -20) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    self.tableView = tableView;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0);
    tableView.tableHeaderView = self.header;
    @weakify(self);
    self.header.segmentClickBlock = ^(NSInteger index){
        @strongify(self);
        self.segmentIndex = index;
        [self.tableView reloadData];
    };
    
    self.header.openBtnClickBlock = ^(BOOL isOpen){
        @strongify(self);
        self.isOpen = isOpen;
    };
    self.header.isOpen = false;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYSiftPriceTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYSiftPriceTableViewCell class])];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYSiftUnivTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYSiftUnivTableViewCell class])];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYSiftHourseNumTableVCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYSiftHourseNumTableVCell class])];
    [self addSubview:tableView];
    
    NSArray *arr = @[@"重置",@"确认"];
    UIColor *blinColour = [UIColor colorWithHex:0x29a7e1];
    CGFloat btnWidth = (self.frame.size.width -25)/2.0f;
    for (int i = 0; i<arr.count; i++) {
        if (i == 0) {
            UIButton *button = [UIButton buttonWithTitle:arr[i] titleColour:blinColour image:nil backgroundImage:nil target:self action:@selector(btnClick:) borderColour:blinColour borderWidth:1 cornerRadius:5 backgroundColour:[UIColor whiteColor]];
            button.frame = CGRectMake(10 +i*(btnWidth +5), self.frame.size.height - 45, btnWidth, 35);
            button.tag = 700 +i;
            [self addSubview:button];
        }else if (i == 1){
            UIButton *button = [UIButton buttonWithTitle:arr[i] titleColour:[UIColor whiteColor] image:nil backgroundImage:nil target:self action:@selector(btnClick:) borderColour:blinColour borderWidth:1 cornerRadius:5 backgroundColour:blinColour];
            button.tag = 700 +i;
            button.frame = CGRectMake(10 +i*(btnWidth +5), self.frame.size.height - 45, btnWidth, 35);
            [self addSubview:button];
        }
    }
}

-(void)btnClick:(UIButton *)sender{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"country"] = _countryId;
    dict[@"city"] = _cityId;
    dict[@"univ"] = _universityId;
    dict[@"min_price"] = _minPrice;
    dict[@"max_price"] = _maxPrice;
    dict[@"house_type"] = _hourseNum;
    
    if (sender.tag == 700) {//重置
        for (XYAddressModel *address in self.sectionDataArray) {
            address.isSelectSection = false;
            for (XYUnivModel *un in address.univs) {
                un.isSelected = false;
            }
        }
        self.stayArray = [NSArray arrayWithArray:self.sectionDataArray];
        _countryId = [NSString stringWithFormat:@"%ld",self.segmentIndex +1];
        _cityId = @"";
        _universityId = @"";
        _minPrice = @"";
        _maxPrice = @"";
        _currentSelectSection = 9999;
        self.universityLabel.text = @"";
        [self.tableView reloadData];
    }else{//确认
        if (self.btnClickeBlock) {
            self.btnClickeBlock(sender,dict);
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.hourseType == XYHourseTypeFlat) {
        return self.sectionArray.count +1;
    }else{
        return self.sectionArray.count +2;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section >= self.sectionArray.count) {
        return 1;
    }
    if (section == _currentSelectSection) {
        XYAddressModel *model = self.sectionDataArray[_currentSelectIndex];
        return model.univs.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section >= self.sectionArray.count) {
        return 0.1f;
    }
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.sectionArray.count) {
        return 75;
    }else if (indexPath.section == self.sectionArray.count +1){
        return 115;
    }
    return 35;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section >= self.sectionArray.count) {
        return nil;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = self.sectionBtnArray[section];
    for (int i = 0;i<arr.count;i++) {
        XYSiftButton *bt = arr[i];
        XYAddressModel *model = self.sectionDataArray[bt.tag -1000];
        XYSiftButton *button = [[XYSiftButton alloc]init];
        button.frame = bt.frame;
        button.isSelectOnly = model.isSelectSection;
        if (_currentSelectSection == 9999) {
            button.isOpen = false;
        }else if(model.isSelectSection && _currentSelectSection!= 9999){
            button.isOpen = true;
        }
        [button setTitle:model.name_zh forState:UIControlStateNormal];
        button.tag = bt.tag;
        [button addTarget:self action:@selector(areaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.sectionArray.count) {//价格cell
        XYSiftPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYSiftPriceTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.minPriceTextField.text = _minPrice;
        cell.maxPriceTextField.text = _maxPrice;
        cell.university = self.segmentIndex;
        cell.textDidChangedBlock = ^(UITextField *textField){
            if (textField == cell.minPriceTextField) {
                _minPrice = textField.text;
            }else if (textField == cell.maxPriceTextField){
                _maxPrice = textField.text;
            }
        };
        return cell;
    }
    if (indexPath.section == self.sectionArray.count +1) {//房间数
        XYSiftHourseNumTableVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYSiftHourseNumTableVCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.btnClickBlock = ^(XYSiftButton *btn){
            NSArray *array = @[@"oneflat",@"twoflat",@"threeflat",@"fourflat",@"fiveflat"];
            _hourseNum = array[btn.tag -600];
        };
        return cell;
    }
    
    XYSiftUnivTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYSiftUnivTableViewCell class])];
    XYAddressModel *model = self.sectionDataArray[_currentSelectIndex];
    XYUnivModel *univ = model.univs[indexPath.row];
    cell.model= univ;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section <self.sectionArray.count) {
        //改变label内容
        XYAddressModel *model = self.sectionDataArray[_currentSelectIndex];
        if (indexPath.row == 0) {
            self.universityLabel.text = model.name_zh;
            _universityId = @"";
            for (int i = 0; i<model.univs.count; i++) {
                XYUnivModel *univ = model.univs[i];
                if (i == indexPath.row) {
                    univ.isSelected = true;
//                    self.universityLabel.text = univ.name_zh;
                }else{
                    univ.isSelected = false;
                }
            }
        }else{
            for (int i = 0; i<model.univs.count; i++) {
                XYUnivModel *univ = model.univs[i];
                if (i == indexPath.row) {
                    univ.isSelected = true;
                    _universityId = univ.univId;
                    self.universityLabel.text = univ.name_zh;
                }else{
                    univ.isSelected = false;
                }
            }
        }
        
        //收起大学
        _currentSelectSection = 9999;
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
