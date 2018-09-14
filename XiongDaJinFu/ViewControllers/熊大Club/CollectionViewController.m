//
//  CollectionViewController.m
//  Blinroom
//
//  Created by room Blin on 16/8/1.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "CollectionViewController.h"
#import "RoomTableViewCell.h"
#import "shouCangFangyuan.h"
#import "MHHouseDetailTableViewController.h"
#import "shouCangFangyuan.h"
#import "orderModel.h"
#import "loginViewController.h"
#import "myOrderTableViewCell.h"
#import "noDataTableViewCell.h"
#import "XYHourseDetailTableVC.h"
#import "apartModel.h"
#import "XYAbroadResidenceViewController.h"
#import "XYUniversityDetailBaseVC.h"
#import "XYFlatListTableViewCell.h"
//static  const char  associateKey;
//static  const char  associateButtonKey;
@interface CollectionViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,deleBtnClick,pushListDelegate,TDAlertViewDelegate>
{
    UISegmentedControl *segment;
    UIScrollView *scrollview;
    NSInteger _deleteIndex;
}
@property(nonatomic,strong)  NSMutableArray  * shoucnagArray;

@property(nonatomic,strong)  NSMutableArray  * apartmentArray;

@property(nonatomic,strong)  UITableView  * shoucnagTableview;

@end

@implementation CollectionViewController


- (NSMutableArray  *)shoucnagArray{
    if (!_shoucnagArray) {
        _shoucnagArray = [[NSMutableArray alloc] init];
    }

    return _shoucnagArray;

}
-(NSMutableArray*)apartmentArray{

    if (!_apartmentArray) {
        _apartmentArray = [NSMutableArray new];
    }

    return _apartmentArray;
}

- (UITableView *)shoucnagTableview{
    if (!_shoucnagTableview) {
        _shoucnagTableview = [[UITableView alloc] init];
    }

    return _shoucnagTableview;
}

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewInfo) name:LOGINOUT_SUCCESS object:nil];
    

    [self getdata];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;

}
-(void)getNewInfo{
    [self getdata];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kGoTopNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leave) name:kLeaveTopNotificationName object:nil];

    [self setUpUI];
}
- (void)setUpUI{
    self.shoucnagTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) ];

    //    self.shoucnagTableview.tableHeaderView = [UIView new];
//    self.shoucnagTableview.tableFooterView = [UIView new];
//
    self.shoucnagTableview.contentInset=UIEdgeInsetsMake(0, 0, 150, 0);

    self.shoucnagTableview.scrollEnabled = YES;
    self.shoucnagTableview.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    self.shoucnagTableview.dataSource  = self;
    self.shoucnagTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shoucnagTableview.delegate  = self;
    [self.shoucnagTableview registerNib:[UINib nibWithNibName:@"noDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"noDataTableViewCell"];
          [self.shoucnagTableview registerNib:[UINib nibWithNibName:@"RoomTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.shoucnagTableview registerNib:[UINib nibWithNibName:NSStringFromClass([XYFlatListTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYFlatListTableViewCell class])];
    [self.view addSubview:self.shoucnagTableview];
    
}
# pragma mark UITableViewDataSource
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset = scrollView.contentOffset.y;  // 偏移的y值

    if (yOffset<0) {
        self.shoucnagTableview.scrollEnabled = NO;
        
    }
//
//    if (yOffset>220) {
//        self.shoucnagTableview.scrollEnabled = YES;
//        self.shoucnagTableview.userInteractionEnabled = YES;
//        
//        LRLog(@"达到要求了");
//    }
//    
//    else{
//        
//
//    }

}
-(void)acceptMsg:(NSNotification*)noti{
    self.shoucnagTableview.scrollEnabled = YES;
    self.shoucnagTableview.scrollsToTop = NO;
    self.shoucnagTableview.userInteractionEnabled = YES;
    

    
}
-(void)leave{
    self.shoucnagTableview.scrollEnabled = NO;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    if (self.shoucnagArray.count==0) {
        return 1;
    }
    else{
    return self.shoucnagArray.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
       
    noDataTableViewCell* nocell = [tableView dequeueReusableCellWithIdentifier:@"noDataTableViewCell" ];
    nocell.selectionStyle = UITableViewCellSelectionStyleNone;
        [nocell.noDataBtn setTitle:@"收藏一个喜欢的屋子" forState:UIControlStateNormal];
   
    nocell.delegate = self;
    if (!nocell) {
            nocell = [[noDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"noDataTableViewCell"];
        }
        if (self.shoucnagArray.count ==0) {
            return nocell;
        }
        
//    RoomTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
//    if (!cell) {
//            cell = [[RoomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        }
//        
//    cell.apartModel = self.apartmentArray[indexPath.row];
    
    XYFlatListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYFlatListTableViewCell class])];
    apartModel *model = self.shoucnagArray[indexPath.row];
    cell.apartModel =model;
    cell.likeBtnClickBlock = ^(BOOL like) {
        _deleteIndex = indexPath.row;
        TDAlertItem *item1 = [[TDAlertItem alloc] initWithTitle:@"取消"];
        TDAlertItem *item2 = [[TDAlertItem alloc] initWithTitle:@"确定"];
        item2.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
        item2.titleColor = [UIColor colorWithHexString:@"fffefe"];
        TDAlertView *alert = [[TDAlertView alloc] initWithTitle:@"取消收藏" message:@"确定要取消收藏吗？" items:@[item1,item2] delegate:self];
        alert.hideWhenTouchBackground = NO;
        
        [alert show];
    };
        return cell;
}
-(void)didPushListBtn{
    
    [MobClick event:@"ToFlatList" attributes:@{@"type":@"mine"}];
    XYUniversityDetailBaseVC *un =[[XYUniversityDetailBaseVC alloc]init];
    un.hourseType = XYHourseTypeFlat;
    [self.navigationController pushViewController:un animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
   
        if (self.shoucnagArray.count==0) {
            return 340*SCREENHEIGHT/1334;
            
        }
        
    return 255;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    if (self.shoucnagArray.count ==0) {
    
        return;
    }
    
    
    apartModel  * shouCang = self.shoucnagArray[indexPath.row];
    if ([shouCang.type isEqualToString:@"1"]) {
        XYHourseDetailTableVC *detail = [[XYHourseDetailTableVC alloc]init];
        detail.faltId = shouCang.be_liked;
        detail.title = @"公寓详情";
        detail.likeBtnClickBlock = ^(BOOL like) {
            XYFlatListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.favouriteBtn setBackgroundImage:[UIImage imageNamed:(like && like ==true) ?@"shoucang_icon_xin_-pre":@"shoucang_icon_xin"] forState:UIControlStateNormal];
            shouCang.like = like;
        };
        [self.navigationController pushViewController:detail animated:YES];
        

    }
    else{
        XYAbroadResidenceViewController  * boardvc = [XYAbroadResidenceViewController new];
        boardvc.likeBtnClickBlock = ^(BOOL like) {
            XYFlatListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.favouriteBtn setBackgroundImage:[UIImage imageNamed:(like && like ==true) ?@"shoucang_icon_xin_-pre":@"shoucang_icon_xin"] forState:UIControlStateNormal];
            shouCang.like = like;
        };
        boardvc.hourseId = shouCang.be_liked ;
        [self.navigationController pushViewController:boardvc animated:YES];

    
    }
    
  }

# pragma mark -
# pragma mark 删除收藏
- (void)deleteCollection:(UIButton*)btn{
    
   // objc_setAssociatedObject(alertview, &associateButtonKey, btn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    shouCangFangyuan  * shoucag =  [_shoucnagArray objectAtIndex:btn.tag-10086];
    [[NetworkClient sharedClient] POST:[NSString stringWithFormat:@"%@/%@",URL_DeleCOLLECTION,shoucag.ID] dict:nil succeed:^(id data) {
       
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            LRLog(@"删除成功%@",data);
            //从对应的cell移除数据
            [_shoucnagArray removeObjectAtIndex:btn.tag-10086];
            //刷新TableView
            [self.shoucnagTableview reloadData];
           // [self showHint:@"删除收藏成功"];
        }
    } failure:^(NSError *error) {
        //[self showHint:@"删除收藏失败"];

    }];
    

}
-(void)deleBtnClick{



}



# pragma mark -
# pragma mark ACTION
- (void)CollectionEdit:(UIButton*)Btn{






}

- (void)getdata{
    NSDictionary  * dic = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
    NSDictionary  * dict = @{@"like":dic[@"id"],@"type":@2,@"show_details":[NSNumber numberWithBool:YES]};
    [[NetworkClient sharedClient] POST:URL_MYCOLLECTION dict:dict succeed:^(id data) {
//        LRLog(@"我的收藏为%@",data);
        
        [self.shoucnagArray removeAllObjects];
        if ([data[@"error_code"] isEqualToNumber:[NSNumber numberWithInt:40004]]){
            //发出通知，清理登录信息残留
            [[NSNotificationCenter defaultCenter ] postNotificationName:LOGIN_EXPIRE object:self ];
            [self.shoucnagTableview reloadData];

            return ;
        }
        if (![data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            return;
        }
        
        NSArray  * dataArr = [data objectForKey:@"result"];
        [NSDictionary printPropertyWithDict:dataArr.lastObject];
        [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
//            shouCangFangyuan *model = [shouCangFangyuan mj_objectWithKeyValues:obj];
//            apartModel  * apartM = [apartModel mj_objectWithKeyValues:model.be_liked_apartment];
//            [self.shoucnagArray addObject:model];
//            [self.apartmentArray addObject:apartM];
            
            apartModel *flat = [apartModel yy_modelWithDictionary:obj];
            if (flat.be_liked_apartment) {
                
                [self.shoucnagArray addObject:flat];
            }
//            LxDBAnyVar(self.shoucnagArray.count);
        }];
        

        [self.shoucnagTableview reloadData];
        
    } failure:^(NSError *error) {
        LRLog(@"%@",error);
        
    }];
}

-(void)alertView:(TDAlertView *)alertView didClickItemWithIndex:(NSInteger)itemIndex{
    if (itemIndex == 1) {
        apartModel *model = self.shoucnagArray[_deleteIndex];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"like_id"] = model.likeId;
        [[ESWebService sharedWebService].flat deleteLikeParameter:dict success:^(id jsonData) {
            [self.shoucnagArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndex:_deleteIndex]];
            [self.shoucnagTableview reloadData];
        } failure:^(NSString *error,NSString *errorCode) {
            if ([errorCode isEqualToString:@"40004"]) {
                loginViewController *login = [[loginViewController alloc]init];
                [self.navigationController pushViewController:login animated:true];
            }
        }];
    }
}
@end
