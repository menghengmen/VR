//
//  searchView.m
//  DCWebPicScrollView
//
//  Created by room Blin on 2017/3/7.
//  Copyright © 2017年 name. All rights reserved.
//

#import "searchView.h"
#import "city.h"


@interface searchView()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView  * tableView;
}





/**
 *  搜索框
 */
@property (nonatomic, strong) UISearchBar *searchBar;
/*
 *  城市数据，可在Getter方法中重新指定
 */
@property (nonatomic, strong) NSMutableArray *cityDatas;

/**
 *  搜索城市表头
 */

@property (nonatomic, strong) NSMutableArray *arraySection;
/**
 *  搜索城市列表
 */
@property (nonatomic, strong) NSMutableArray *searchCities;
/**
 *  记录所有城市信息，用于搜索
 */
@property (nonatomic, strong) NSMutableArray *recordCityData;
/**
 *  是否是search状态
 */
@property(nonatomic, assign) BOOL isSearch;

@end
@implementation searchView
- (NSMutableArray *) recordCityData
{
    if (_recordCityData == nil) {
        _recordCityData = [[NSMutableArray alloc] init];
    }
    return _recordCityData;
}

- (NSMutableArray*)arraySection{
    if (!_arraySection) {
        _arraySection = [[NSMutableArray alloc] init];
    }

    return _arraySection;
}

- (NSMutableArray *) searchCities
{
    if (_searchCities == nil) {
        _searchCities = [[NSMutableArray alloc] init];
    }
    return _searchCities;
}



- (NSMutableArray*)cityDatas{

    if (_cityDatas == nil) {
        
        NSString  * STR =  [[NSBundle mainBundle] pathForResource:@"CityData" ofType:@"plist"];
        _cityDatas = [[NSMutableArray alloc] init];

        NSArray  * arr = [NSArray arrayWithContentsOfFile:STR];
    
        for (NSDictionary  * groupDict in arr) {
            CityGroup  * group = [[CityGroup alloc] init];
            group.groupName = [groupDict objectForKey:@"initial"];
           
            for (NSDictionary  * dict in [groupDict objectForKey:@"citys"]) {
                city  * city1 = [[city alloc] init];
                
                city1.cityID = [dict objectForKey:@"city_key"];
                city1.cityName = [dict objectForKey:@"city_name"];
                city1.pinyin = [dict objectForKey:@"pinyin"];
                city1.shortName = [dict objectForKey:@"short_name"];
                city1.initials = [dict objectForKey:@"initials"];
           
                [group.arrayCitys addObject:city1];
                [self.recordCityData addObject:city1];

            }
           
            [self.arraySection addObject:group.groupName];

            [_cityDatas addObject:group];
        }
        [tableView reloadData];
    }
    return _cityDatas;
}



- (void)initViewWithData:(NSArray*)dataArray{

   // self.automaticallyAdjustsScrollViewInsets = NO;

    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44.0f)];
    self.searchBar.delegate     = self;
    self.searchBar.placeholder  = @"搜索";
    [self.searchBar setBarTintColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
    [self.searchBar.layer setBorderWidth:0.5f];
    [self.searchBar.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    [self addSubview:self.searchBar];


    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
   


}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    if (self.isSearch) {
        return 1;
    }
    return self.cityDatas.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.isSearch) {
        return self.searchCities.count;
    }
    
    CityGroup *group = [self.cityDatas objectAtIndex:section];
    return group.arrayCitys.count;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
  
    if (self.isSearch) {
        return nil;
    }
    UILabel*label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    label.backgroundColor = [UIColor grayColor];
    label.text = [self.arraySection objectAtIndex:section];
    return label;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
   
    if (self.isSearch) {
        city *city =  [self.searchCities objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        [cell.textLabel setText:city.cityName];
        [cell.textLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];

        return cell;
    }
    
    
    CityGroup *group = [self.cityDatas objectAtIndex:indexPath.section];
    city *city =  [group.arrayCitys objectAtIndex:indexPath.row];
    [cell.textLabel setText:city.cityName];
    [cell.textLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    if (self.isSearch) {
        return 0;
    }
    
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.isSearch) {
      city  * city1 =  [self.searchCities objectAtIndex:indexPath.row];
        [self.delegate didSelectCity:city1];
        [self removeFromSuperview];
        return;
    }
    CityGroup *group = [self.cityDatas objectAtIndex:indexPath.section ];
    city  * city1=  [group.arrayCitys objectAtIndex:indexPath.row];
    [self.delegate didSelectCity:city1];
    [self removeFromSuperview];
}
# pragma mark -
# pragma mark 右边的索引
- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.isSearch) {
        return nil;
    }
    
    return self.arraySection;
}



# pragma mark -
# pragma mark UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    [self.searchCities removeAllObjects];
    if ([searchText isEqualToString:@""]) {
        self.isSearch = NO;
        [tableView reloadData];
    }
    else{
    
        self.isSearch = YES;
    
        for (city *city in self.recordCityData){
            NSRange chinese = [city.cityName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange  letters = [city.pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange  initials = [city.initials rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (chinese.location != NSNotFound || letters.location != NSNotFound || initials.location != NSNotFound) {
                [self.searchCities addObject:city];
            }
    
    
    
    }


        [tableView reloadData];
    }
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{

    searchBar.text = @"";
    [searchBar resignFirstResponder];
    self.isSearch = NO;
    [tableView reloadData];

}



- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{

    //[searchBar resignFirstResponder];

}                       // called when text ends editing

@end
