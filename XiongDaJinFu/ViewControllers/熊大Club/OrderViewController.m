//
//  OrderViewController.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/27.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "OrderViewController.h"
#import "orderModel.h"
#import "myOrderTableViewCell.h"
#import "noDataTableViewCell.h"
#import "XYUniversityDetailBaseVC.h"
#import "apartmentModel.h"
@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,cancleOrderDelegate,pushListDelegate>
@property(nonatomic,strong)  NSMutableArray  * shoucnagArray;

@property(nonatomic,strong)  NSMutableArray  * apartMentArray;

@property(nonatomic,strong)  UITableView  * shoucnagTableview;

@end

@implementation OrderViewController
- (NSMutableArray  *)shoucnagArray{
    if (!_shoucnagArray) {
        _shoucnagArray = [[NSMutableArray alloc] init];
    }
    
    return _shoucnagArray;
    
}
- (NSMutableArray  *)apartMentArray{
    if (!_apartMentArray) {
        _apartMentArray = [[NSMutableArray alloc] init];
    }
    
    return _apartMentArray;
    
}
- (UITableView *)shoucnagTableview{
    if (!_shoucnagTableview) {
        _shoucnagTableview = [[UITableView alloc] init];
    }
    
    return _shoucnagTableview;
}
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewInfo) name:LOGINOUT_SUCCESS object:nil];

    
    
    self.navigationController.navigationBar.hidden = YES;
    [self getOrderData];

}
-(void)viewWillDisappear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = NO;
}
-(void)getNewInfo{
    [ self getOrderData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kGoTopNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leave) name:kLeaveTopNotificationName object:nil];
    
    
    [self setUpUI];
    
}
-(void)acceptMsg:(NSNotification*)noti{
    self.shoucnagTableview.scrollEnabled = YES;
    self.shoucnagTableview.scrollsToTop = NO;
    self.shoucnagTableview.userInteractionEnabled = YES;
    
    
    
}
-(void)leave{
    self.shoucnagTableview.scrollEnabled = NO;
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset = scrollView.contentOffset.y;  // 偏移的y值
    
    if (yOffset<0) {
        self.shoucnagTableview.scrollEnabled = NO;
        
    }
}
- (void)setUpUI{
    
    self.shoucnagTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) ];
    self.shoucnagTableview.contentInset=UIEdgeInsetsMake(0, 0, 150, 0);

    self.shoucnagTableview.scrollEnabled = NO;
    self.shoucnagTableview.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    self.shoucnagTableview.tableFooterView = [[UIView alloc] init];
    self.shoucnagTableview.dataSource  = self;
    self.shoucnagTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shoucnagTableview.delegate  = self;
    [self.shoucnagTableview registerNib:[UINib nibWithNibName:@"noDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"noDataTableViewCell"];
    
        [self.shoucnagTableview registerNib:[UINib nibWithNibName:@"myOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"orderCell"];
        
    [self.view addSubview:self.shoucnagTableview];
    
    
    
}
# pragma mark UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.shoucnagArray.count==0) {
        return 340*SCREENHEIGHT/1334;
        
    }

    return 450*SCREENHEIGHT/1334;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (self.shoucnagArray.count ==0) {
        return 1;
    }
    else{
        return self.shoucnagArray.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    noDataTableViewCell* nocell = [tableView dequeueReusableCellWithIdentifier:@"noDataTableViewCell" ];
    [nocell.noDataBtn setTitle:@"总有一套公寓适合你" forState:UIControlStateNormal];
    nocell.delegate =self;
    nocell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (!nocell) {
        nocell = [[noDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"noDataTableViewCell"];
    }
    if (self.shoucnagArray.count ==0) {
        return nocell;
    }
    
    
    
    
    myOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell" ];
   
    cell.delegate = self;
    if (!cell) {
        cell = [[myOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderCell"];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    orderModel *model = self.shoucnagArray[indexPath.row];
    cell.oModel = model;
    cell.apartMentModel = self.apartMentArray[indexPath.row];
    
    cell.cancleBtnClick = ^(NSInteger index) {
        TDAlertItem *item1 = [[TDAlertItem alloc] initWithTitle:@"取消"];
        TDAlertItem *item2 = [[TDAlertItem alloc] initWithTitle:@"确定" andHandle:^{
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"id"] = model.ID;
            
            [MBProgressHUD showIndicatorMessage:@"删除订单中" toView:self.navigationController.view];
            [[ESWebService sharedWebService].flat deleteOrderWithParameter:dict success:^(id jsonData) {
                [MBProgressHUD hideHUDForView:self.navigationController.view];
                [MBProgressHUD showMessage:@"删除成功"];
                [self.apartMentArray removeObjectAtIndex:indexPath.row];
                [self.shoucnagTableview reloadData];
                
            } failure:^(NSString *error, NSString *errorCode) {
                
                [MBProgressHUD hideHUDForView:self.navigationController.view];
                [MBProgressHUD showError:error];
            }];
        }];
        item2.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
        item2.titleColor = [UIColor colorWithHexString:@"fffefe"];
        TDAlertView *alert = [[TDAlertView alloc] initWithTitle:@"提示" message:@"确定删除该订单吗？" items:@[item1,item2] delegate:nil];
        alert.hideWhenTouchBackground = NO;
        
        [alert show];
    };
    
    return cell;
}
-(void)didPushListBtn{

    XYUniversityDetailBaseVC *un =[[XYUniversityDetailBaseVC alloc]init];
    un.hourseType = XYHourseTypeFlat;
    [self.navigationController pushViewController:un animated:YES];

}

-(void)getOrderData{
    
   
    [[NetworkClient sharedClient] POST:URL_MYORDER dict:nil succeed:^(id data) {
        LRLog(@"%@",data);
        [self.apartMentArray removeAllObjects];
        [self.shoucnagArray removeAllObjects];
        if ([data[@"error_code"] isEqualToNumber:[NSNumber numberWithInt:40004]]){
            //发出通知，清理登录信息残留
            [[NSNotificationCenter defaultCenter ] postNotificationName:LOGIN_EXPIRE object:self ];
            [self.shoucnagTableview reloadData];
            return ;
        }
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            
            NSArray  * dataArr = [data objectForKey:@"result"];
            for (NSDictionary  * dict in dataArr) {
                orderModel  * uModel = [orderModel mj_objectWithKeyValues:dict];
                [self.shoucnagArray addObject:uModel];
                if ([uModel.type isEqualToNumber:[NSNumber numberWithInt:1]]) {
                    apartmentModel  * apartMo = [apartmentModel mj_objectWithKeyValues:uModel.apartment_house_type];
                    [self.apartMentArray addObject:apartMo];
                }
                else{
                    apartmentModel  * apartMo = [apartmentModel mj_objectWithKeyValues:uModel.house];
                    [self.apartMentArray addObject:apartMo];
                
                }
              
            }
            [self.shoucnagTableview reloadData];
        }
    } failure:^(NSError *error) {
        
       
    }];
}

# pragma mark -
# pragma mark cancleOrderDelegate
-(void)didCancleBtn{
    
//    [XDCommonTool alertWithMessage:@"取消订单" withLittleMessage:@"你确定要取消订单吗"];
    
    
    
}


@end
