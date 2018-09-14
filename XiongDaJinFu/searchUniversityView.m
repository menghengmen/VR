//
//  searchUniversityView.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/11.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "searchUniversityView.h"
#import "UniversityModel.h"
#import "majorModel.h"
@interface searchUniversityView()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

{
    UITableView  * tableView;
}
//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *indexArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@property (nonatomic, strong) NSMutableArray *searchDataSource;
@property (nonatomic, strong) UITableView *tableview;
/*
 *  城市数据，可在Getter方法中重新指定
 */
@property (nonatomic, strong) NSMutableArray *cityDatas;
/**
 *  是否是search状态
 */
@property(nonatomic, assign) BOOL isSearch;

@end
@implementation searchUniversityView
+(searchUniversityView*)shareInstance{
    static  searchUniversityView  * searView = nil;

    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        searView = [[self alloc] init];
        searView.backgroundColor = [UIColor whiteColor];
    });
    return searView;

}

-(NSMutableArray*)cityDatas{
    if (!_cityDatas) {
        _cityDatas = [NSMutableArray new];
       
    }


    return _cityDatas;
}

-(void)setUI{

    
//    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.frame.size.width-(SCREENWIDTH-60), [UIApplication sharedApplication].keyWindow.frame.size.height)];
//    self.backgroundView = back;
//    back.backgroundColor = [UIColor blackColor];
//    back.alpha = 0.5;
//    UITapGestureRecognizer *tap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
//    [back addGestureRecognizer:tap1];
//    [[UIApplication sharedApplication].keyWindow addSubview:back];
    

    
    
    UIButton  * sureBtn =  [XDCommonTool newButtonWithType:UIButtonTypeCustom frame:CGRectMake(0, 300, 100, 100) normalImage:nil buttonTitle:@"确 定" target:self action:@selector(btnClick:)];
    [self addSubview:sureBtn];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"#28a8e0"];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 6;
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCREEN_MAIN.height-65);
        make.right.equalTo(sureBtn.superview.mas_right).offset(-8);
        make.left.equalTo(self.mas_centerX).offset(2);
        make.height.mas_equalTo(35);
        
    }];
    
    
    UIButton  * cancleBtn =  [XDCommonTool newButtonWithType:UIButtonTypeCustom frame:CGRectMake(0, 300, 100, 100) normalImage:nil buttonTitle:@"取 消" target:self action:@selector(btnClick:)];
    [self addSubview:cancleBtn];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    cancleBtn.layer.borderColor = [[UIColor colorWithHexString:@"#28a8e0"] CGColor];
    cancleBtn.layer.borderWidth =0.5;
    cancleBtn.layer.cornerRadius = 6;
    cancleBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [cancleBtn setTitleColor:[UIColor colorWithHexString:@"#28a8e0"] forState:UIControlStateNormal];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCREEN_MAIN.height-65);
        make.left.equalTo(cancleBtn.superview.mas_left).offset(8);
        make.right.equalTo(self.mas_centerX).offset(-2);
        make.height.mas_equalTo(35);
    }];
    





}
-(void)tap{
    [self removeFromSuperview];
    [self.backgroundView removeFromSuperview];
}
-(void)btnClick:(UIButton*)btnClick{
    [self.backgroundView removeFromSuperview];

//    [self removeFromSuperview];
    if (self.finishBlock) {
        self.finishBlock();
    }
}
-(void)getData{
    [self.cityDatas removeAllObjects];
    NSDictionary  * universityDict = [NSDictionary dictionaryWithContentsOfFile:[XDCommonTool getFilePath:@"allUniversity.plist"]];
    
    NSArray  * arr = [universityDict objectForKey:@"result"];
    NSMutableArray  * arrM = [NSMutableArray new];
    for (NSDictionary  * dict in arr) {
        UniversityModel  * uModel = [UniversityModel mj_objectWithKeyValues:dict];
        [arrM addObject:uModel];
        
    }
    self.cityDatas = arrM;
   
    //根据Person对象的 name 属性 按中文 对 Person数组 排序
    dispatch_queue_t queue = dispatch_queue_create("universitySequence", DISPATCH_QUEUE_SERIAL);
    //异步执行线程队列
    dispatch_async(queue, ^{

        //在多线程中执行的代码
        if (self.indexArray.count == 0 || self.letterResultArr.count == 0) {
            
            self.indexArray = [BMChineseSort IndexWithArray:self.cityDatas Key:@"name_zh"];
            self.letterResultArr = [BMChineseSort sortObjectArray:self.cityDatas Key:@"name_zh"];
           
            //异步返回主线程     dispatch_get_main_queue() 返回主线程的方法
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.tableview) {
                    [self.tableview reloadDataAnimateWithWave:RightToLeftWaveAnimation];

                }
            });
        }
        
    });
    

}
-(void)getMajorData{

    NSDictionary  * universityDict = [NSDictionary dictionaryWithContentsOfFile:[XDCommonTool getFilePath:@"allDictionary.plist"]];
    NSDictionary  * dict = [[universityDict objectForKey:@"result"] objectAtIndex:9];
    NSArray * arr =   [dict  objectForKey:@"child"];
    
    NSMutableArray  * arrM = [NSMutableArray new];
    for (NSDictionary  * dict in arr) {
        majorModel  * uModel = [majorModel mj_objectWithKeyValues:dict];
        [arrM addObject:uModel];
        
    }
    self.cityDatas = arrM;
    
    
    //根据Person对象的 name 属性 按中文 对 Person数组 排序
    self.indexArray = [BMChineseSort IndexWithArray:self.cityDatas Key:@"name_zh"];
    self.letterResultArr = [BMChineseSort sortObjectArray:self.cityDatas Key:@"name_zh"];



}



- (void)initViewWithData:(NSArray*)dataArray{
   
    
//    //背景
//    UIView *background =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    background.backgroundColor =[UIColor blackColor];
//    background.alpha =0.0f;
//    self.userInteractionEnabled = true;
//    background.userInteractionEnabled = true;
//    self.hidden = true;
//    self.backGroundView =background;
//    [self addSubview:background];
//
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];

    
    [self.typeStr isEqualToString:@"大学"]?[self getData]:[self getMajorData];
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width, 44.0f)];
    self.searchBar.delegate     = self;
    self.searchBar.placeholder  = @"搜索";
    [self.searchBar setBarTintColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
    [self.searchBar.layer setBorderWidth:0.5f];
    [self.searchBar.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    [self.typeStr isEqualToString:@"大学"]?[self addSubview:self.searchBar]:nil;

    
    
    if ([self.typeStr isEqualToString:@"大学"]) {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.frame.size.width, self.frame.size.height)];

    }else{
    
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height)];

    }
   
    
    tableView.contentInset=UIEdgeInsetsMake(0, 0, 50, 0);

    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    self.tableview = tableView;
    self.tableview.tableFooterView = [UIView new];
    [self addSubview:tableView];
    [self setUI];


    
}

-(void)showView{
  [UIView animateWithDuration:0.6 animations:^{
      self.backgroundView.alpha =0.6f;
      self.hidden = false;
  }];


}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_isSearch==YES) {
        return 1;
    }
    return [self.indexArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_isSearch == YES) {
        return self.searchDataSource.count;
    }
    return [[self.letterResultArr objectAtIndex:section] count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (_isSearch == YES) {
        return nil;
    }
    return [self.indexArray objectAtIndex:section];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *view = [UILabel new];
    view.font = [UIFont systemFontOfSize:12];
    view.backgroundColor = [UIColor colorWithHex:0xf0f0f0];
    if (_isSearch == YES) {
        return nil;
    }else{
    view.text = [NSString stringWithFormat:@"     %@",[self.indexArray objectAtIndex:section]];
    }
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
   

    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    if ([self.typeStr isEqualToString:@"专业"]) {
        majorModel  * p2 = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.textLabel.text = p2.name_zh;
       
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        cell.textLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        return cell;
    }
    
    
    
    
    if (_isSearch == YES) {
        UniversityModel  * p1 = [self.searchDataSource objectAtIndex:indexPath.row];
               cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@",p1.name_zh,p1.name_en];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        cell.textLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        cell.textLabel.numberOfLines = 0;
  
       
    return cell;
    }
    
    //获得对应的Person对象<替换为你自己的model对象>
    UniversityModel *p = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@",p.name_zh,p.name_en];
      cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    cell.textLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.isSearch) {
        return 0;
    }
    
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.backgroundView removeFromSuperview];
  
    if ([self.typeStr isEqualToString:@"专业"]) {
        majorModel  * major =  [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [self.delegate didSelectMajor:major];
        [self removeFromSuperview];
        return;
    }
    
    if (self.isSearch) {
        UniversityModel  * city1 =  [self.searchDataSource objectAtIndex:indexPath.row];
        [self.delegate didSelectUniversity:city1];
        self.isSearch = NO;
       [self removeFromSuperview];
        return;
    }
    UniversityModel  * city2 = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [self.delegate didSelectUniversity:city2];

   [self removeFromSuperview];





}
# pragma mark -
# pragma mark 右边的索引
- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_isSearch == YES) {
        return nil;
    }
    return self.indexArray;

}



# pragma mark -
# pragma mark UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ([searchText isEqualToString:@""]) {
        _isSearch = NO;
        [self.tableview reloadData];
    }
    else{
    self.searchDataSource = (NSMutableArray *)[XDCommonTool searchWithFieldArray:@[@"name_zh",@"name_en"] inputString:searchText inArray:self.cityDatas];
        
        _isSearch = YES;
        [self.tableview reloadData];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    [searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    self.isSearch = NO;
    [tableView reloadData];
    
}
@end
