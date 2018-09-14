//
//  MHHouseListTableViewController.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/2/23.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "MHHouseListTableViewController.h"
#import "RoomTableViewCell.h"
#import "MHHouseDetailTableViewController.h"

@interface MHHouseListTableViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)  UITableView  * tableview;
@property(nonatomic,strong)  UIButton  * backTopButton;
@property (nonatomic,strong)  NSMutableArray  * dataArray;

@end

@implementation MHHouseListTableViewController


- (NSMutableArray*)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray  alloc] init];
    }
    
    return _dataArray;
}


- (UITableView*)tableview{

    if (!_tableview) {
        _tableview = [[UITableView alloc] init];
    }
    return _tableview;

}
- (UIButton*)backTopButton{
    
    if (!_backTopButton) {
        _backTopButton = [[UIButton  alloc] init];
    }
    
    return _backTopButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self getDataHouse];
    [self setUpNewNai:@"返回" Title:@"国际公寓"];

    
    [self setUpUI];

    


}
- (void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
     self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
    self.tableview.dataSource=self;
    self.tableview.delegate=self;
    [self.tableview registerNib:[UINib nibWithNibName:@"RoomTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableview];

   
    
    typeof (self)weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf headRefresh];
    }];
    
    
    
    
    UIButton  * topButton = [XDCommonTool newButtonWithType:UIButtonTypeCustom frame:CGRectMake(SCREENWIDTH-100, SCREENHEIGHT-100, 100, 100) normalImage:nil buttonTitle:@"回到顶部" target:self action:@selector(backTop)];
    [topButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.backTopButton = topButton;
    [self.view addSubview:topButton];


}
- (void)headRefresh{


    [self getDataHouse];
    [self getData];
   

}


- (void)backToHome{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

# pragma mark -
# pragma mark 回到顶部
- (void)backTop{

    [self.tableview setContentOffset:CGPointMake(0, 0) animated:YES];
   
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // return self.dataArray.count;
    return 10;


}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString  * indentify = @"cell";
    
    
    RoomTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (!cell) {
        cell = [[RoomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
    }

    //cell.HModel = self.dataArray[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 273;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[MHHouseDetailTableViewController new] animated:YES];

}

- (void)getData{
    [[NetworkClient sharedClient] POST:URL_APARTMENTLIST dict:nil succeed:^(id data) {
        LRLog(@"%@",data);
    
    
          //NSArray *returnArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
    } failure:^(NSError *error) {
        LRLog(@"%@",error);
    }];
    
    
}

//海外住宅
- (void)getDataHouse{
    [[NetworkClient sharedClient] POST:URL_GETCOMMENT dict:nil succeed:^(id data) {
        [self.tableview.mj_header endRefreshing];
        
        NSArray * dataArr = [data objectForKey:@"result"];
//        for (NSDictionary * dict in dataArr) {
//            houseModel  * hmodel =  [houseModel mj_objectWithKeyValues:dict];
//            [self.dataArray addObject:hmodel];
//            
//        }
       
        [self.tableview reloadData];
        
        LRLog(@"%@",data);
    } failure:^(NSError *error) {
        LRLog(@"%@",error);
    }];
    
    
}


@end
