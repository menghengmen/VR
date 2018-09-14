//
//  XYSiftTableView.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/14.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYSiftTableView.h"
#import "XYSiftButton.h"
@implementation XYSiftTableView

-(instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(SCREEN_MAIN.width/2.0f - 100, 0, SCREEN_MAIN.width/2.0f + 100, SCREEN_MAIN.height -64 -40);
        self.backgroundColor =[UIColor whiteColor];
        [self creatBtnAndTableView];
    }
    return self;
}

#pragma mark -- lazyload
-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

-(NSMutableArray *)cityArray{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
        [_cityArray addObjectsFromArray:@[@"伦敦",@"曼切斯顿",@"爱丁堡",@"利物浦"]];
    }
    return _cityArray;
}

-(NSMutableArray *)universityArray{
    if (!_universityArray) {
        _universityArray = [NSMutableArray array];
        [_universityArray addObjectsFromArray:@[@"剑桥大学",@"牛津大学",@"帝国理工学院",@"圣安德鲁斯大学",@"耶鲁大学"]];
    }
    return _universityArray;
}

-(NSMutableArray *)priceArray{
    if (!_priceArray) {
        _priceArray = [NSMutableArray array];
        [_priceArray addObjectsFromArray:@[@"£0 - £1000",@"£1000 - £2000",@"£2000 - £4000",@"£4000 - £5000",@"£5000 - £6000",@"自定义价格"]];
    }
    return _priceArray;
}

-(void)creatBtnAndTableView{
    self.siftCondition = XYSiftConditionCity;
    //按钮
    NSArray *arr =@[@"城市",@"大学",@"价格"];
    for (int i = 0; i<3; i++) {
        XYSiftButton *btn = [[XYSiftButton alloc]init];
        [self addSubview:btn];
        btn.frame = CGRectMake(15, 15 + i*(30 + 15), 70, 30);
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.isSelectOnly = false;
        btn.tag = 200 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:btn];
    }
    
    //tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(100, 0, self.width - 100 +1, self.height - 60) style:UITableViewStylePlain];
    [self addSubview:tableView];
    self.tableView = tableView;
    self.tableView.layer.borderColor = [UIColor blackColor].CGColor;
    self.tableView.layer.borderWidth = 1;
    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    //确定重置按钮
    NSArray *arr1 =@[@"确定",@"重置"];
    for (int i =0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview: btn];
        CGFloat btnWidth = self.width /5.0f;
        btn.frame = CGRectMake(btnWidth + i*(btnWidth +btnWidth), self.height - 30- 15, btnWidth, 30);
        [btn setTitle:arr1[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.cornerRadius = 5;
        [btn addTarget:self action:@selector(dealBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)dealBtnClick:(UIButton *)sender{
    
}

-(void)btnClick:(XYSiftButton *)sender{
    XYSiftButton *btn =(XYSiftButton *)[self viewWithTag:sender.tag];
    if (!btn.isSelectOnly) {
        btn.isSelectOnly = !btn.isSelectOnly;
    }
    
    switch (sender.tag) {
            case 200:
                self.siftCondition = XYSiftConditionCity;
            break;
            case 201:
                self.siftCondition = XYSiftConditionUniversity;
            break;case 202:
                self.siftCondition = XYSiftConditionPrice;
            break;
        default:
            break;
    }
    
    
    for (int i = 0; i<self.btnArray.count; i++) {
        if (i != sender.tag - 200) {
            XYSiftButton *btnOther = (XYSiftButton *)[self viewWithTag:200 +i];
            btnOther.isSelectOnly = false;
        }
    }
}

-(void)setSiftCondition:(XYSiftCondition)siftCondition{
    _siftCondition = siftCondition;
    [self.tableView reloadData];
}

#pragma mark -- tableView dalegata and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (self.siftCondition) {
            case XYSiftConditionCity:
                return self.cityArray.count;
            break;
            case XYSiftConditionUniversity:
                return self.universityArray.count;
            break;
            case XYSiftConditionPrice:
                return self.priceArray.count;
            break;
        default:
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text =[NSString stringWithFormat:@"第%ld行",indexPath.row];
    switch (self.siftCondition) {
            case XYSiftConditionCity:
                cell.textLabel.text =[NSString stringWithFormat:@"%@",self.cityArray[indexPath.row]];
            break;
            case XYSiftConditionUniversity:
                cell.textLabel.text =[NSString stringWithFormat:@"%@",self.universityArray[indexPath.row]];
            break;
            case XYSiftConditionPrice:
                cell.textLabel.text =[NSString stringWithFormat:@"%@",self.priceArray[indexPath.row]];
            break;
        default:
            break;
    }
//    cell.contentView.backgroundColor =[UIColor colorWithRandomColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


@end
