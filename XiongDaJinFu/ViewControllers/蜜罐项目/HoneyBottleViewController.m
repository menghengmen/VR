
//
//  HoneyBottleViewController.m
//  XiongDaJinFu
//
//  Created by blinRoom on 16/10/13.
//  Copyright © 2016年 blinRoom. All rights reserved.
//

#import "HoneyBottleViewController.h"
#import "UniversityListTableViewCell.h"
#import "MHUniversityDetailViewController.h"
#import "UniversityModel.h"
#import "MJExtension.h"
#import "zhiXunModel.h"
#import "ActivityTableViewCell.h"
@interface HoneyBottleViewController ()
{
    NSInteger currentPage;
    NSInteger totalPage;
}
@property (nonatomic,strong) NSMutableDictionary *parameters;

@property (nonatomic,strong)  NSMutableArray  * dataArray;

@end

@implementation HoneyBottleViewController
- (NSMutableArray*)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray  alloc] init];
    }
    
    return _dataArray;
}


- (NSMutableDictionary*)parameters{
    if (!_parameters) {
        _parameters  = [[NSMutableDictionary alloc] init];
    }

    return _parameters;

}



- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf0f0f0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:18],
    
    NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]}];

}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
//    [self setNeedsStatusBarAppearanceUpdate];
//
    
    currentPage = 1;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        currentPage = 1;
        [self getData];
    }];
    
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        currentPage ++;
//        [self getData];
//    }];

//    [self getData];
    
    [self.tableView.mj_header beginRefreshing];
    [self  setUpUI];
   
}
- (void)setUpUI{
//    typeof (self)WeakSelf = self;
//   
//    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [WeakSelf headFresh];
//        
//    }];
//    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        ;
//        [WeakSelf footFresh];
//    }];

    
    
   // self.automaticallyAdjustsScrollViewInsets = NO;
   // [self.tableView registerNib:[UINib nibWithNibName:@"UniversityListTableViewCell" bundle:nil] forCellReuseIdentifier:@"daxueListCell"];

    self.tableView.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"daxueListCell"];
    



}

-(void)headFresh{
    
    currentPage = 1;
    
    [self.dataArray removeAllObjects];

    [self getData];
}

- (void)footFresh{

    //currentPage+=1;
    //[self getData];
   
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 320*SCREENHEIGHT/1334;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    if (self.dataArray.count ==0) {
//        return 3;
//    }
//    else{
    return self.dataArray.count;

     //  }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        ActivityTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"daxueListCell" forIndexPath:indexPath];
       cell.uModel = self.dataArray.count>0 ?self.dataArray[indexPath.row]:nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MHUniversityDetailViewController  * univerDetail = [MHUniversityDetailViewController  new];
    
    UniversityModel  * model = self.dataArray[indexPath.row];
    univerDetail.univ_id = model.ID;
    
    [self.navigationController pushViewController:univerDetail animated:YES];
}
- (void)getData{
      [self.parameters setObject:[NSNumber numberWithBool:YES] forKey:@"have_video"];
    [[NetworkClient sharedClient] POST:URL_UNIVERSITYLIST dict:self.parameters succeed:^(id data) {
       LRLog(@"%@",data);
        if (currentPage == 1) {
            [self.dataArray removeAllObjects];
        }
        if ([data[@"error_code"] isEqualToNumber:[NSNumber numberWithInt:40003]]){
            [XDCommonTool alertWithMessage:@"服务器错误"];
            return ;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NSArray  * dataArr = [data objectForKey:@"result"];
        [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UniversityModel  * uModel = [UniversityModel mj_objectWithKeyValues:(NSDictionary*)obj];
            [self.dataArray addObject:uModel];
            
          
        }];
        
  
        [self.tableView reloadData];
    } failure:^(NSError *error) {
       LRLog(@"%@",error);
   }];
}
@end
