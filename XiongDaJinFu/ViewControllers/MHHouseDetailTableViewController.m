//
//  MHHouseDetailTableViewController.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/2/24.
//  Copyright © 2017年 Blin. All rights reserved.
//

#import "MHHouseDetailTableViewController.h"
#import "PubTableViewCell.h"
#import "universityDetailTableViewCell3.h"
#import "AFNetworking.h"
#import "DetableViewCellone.h"
#import "RoomTWTableViewCell.h"
#import "MHTableViewCellDetailHouse5.h"
@interface MHHouseDetailTableViewController ()<SDCycleScrollViewDelegate,SDPhotoBrowserDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray  *imagesURLStrings;
    UITableView  *    tableview;
}

@property(nonatomic,strong)SDCycleScrollView * cycleScrollView;




@end

@implementation MHHouseDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self getHouseTypeData];
    [self getHouseTypeDataDetail];
    [self ask];
    [self getComment];
    [self addComment];
}

- (void)setUpUI{
    
  
    self.automaticallyAdjustsScrollViewInsets= NO;
        //创建zzzzzzzz表格
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT+20)];
    tableview.dataSource=self;
    tableview.delegate=self;

    [self.view addSubview:tableview];
    
    typeof (self)WeakSelf = self;
    
    
     tableview.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [WeakSelf headFresh];
    }];
    
    
    // 网络加载 --- 创建带标题的图片轮播器
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200) delegate:self placeholderImage:[UIImage imageNamed:@"002"]];
    self.cycleScrollView.mainView.scrollsToTop = NO;
    self.cycleScrollView.autoScrollTimeInterval = 1000000;
    
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.titlesGroup = @[@"公寓环境",@"客厅",@"卫生间",@"户型图",@"卧室"];
    _cycleScrollView.currentPageDotColor = RGB(99, 222, 253); // 自定义分页控件小圆
    
    UIButton  * btn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,50,50)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [_cycleScrollView addSubview:btn];
    

    
    
    imagesURLStrings = @[@"http://admin.blinroom.com/images/upload/20161201/6a84c4c1-4a41-44fd-87c3-3a768a157dc60.png?cover=N",@"http://admin.blinroom.com/images/upload/20161201/8549670d-a7ba-4bde-8632-b594fa09bd9a0.png?cover=N",@"http://admin.blinroom.com/images/upload/20161201/9fda4955-ee17-478b-99d5-f774308193250.png?cover=N",@"http://admin.blinroom.com/images/upload/20161201/ced7fefe-5863-48be-8e7c-2267c0fe98c30.png?cover=N",@"http://admin.blinroom.com/images/upload/20161201/e3c82069-8e4f-4410-8a26-226031ec3df20.png?cover=N"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cycleScrollView.imageURLStringsGroup = imagesURLStrings;
        
    });
    

}
- (void)headFresh{

    [tableview.mj_header endRefreshing];
}
- (void)push{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.titleArray = @[@"公寓环境",@"客厅",@"卫生间",@"户型图",@"卧室",@"厨房"];
    browser.currentImageIndex =  index;
    browser.imageCount = imagesURLStrings.count;
    browser.sourceImagesContainerView = self.cycleScrollView;
    browser.delegate = self;
    [browser show];
}


#pragma mark -SDPhotoBrowserDelegate
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imagesURLStrings[index]] placeholderImage:[UIImage imageNamed:@"002.jpg"]];
    return imageView.image;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    switch (indexPath.row) {
        case 0:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            [cell addSubview:self.cycleScrollView];
            
              return cell;
            }
            break;
            
        case 1:{
        
            PubTableViewCell*     cell1 = [PubTableViewCell pubTableViewCellWithTableView:tableview];
            cell1.selectionStyle=NO;
            
            return cell1;
        
        }
            break;
        
        case 2:{
        
            universityDetailTableViewCell3  * cell = [universityDetailTableViewCell3 detailCell3WithTableView:tableView];
            
            UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-16, 210)];
            
            imageview.image= [UIImage imageNamed:@"002.jpg"];
            [cell.mapView addSubview:imageview];
            
            return cell;

        
        }
            break;
        case 3:{
            DetableViewCellone  * oneCell = [DetableViewCellone detailViewCellTableView:tableview];
            return oneCell;
        }
            break;

        case 4:{
            RoomTWTableViewCell  * roomCell = [RoomTWTableViewCell detailCell4WithTableView:tableView];
            return roomCell;
        }
          break;
        
        case 5:{
            MHTableViewCellDetailHouse5  * oneCell = [MHTableViewCellDetailHouse5 detailCell5WithTableView:tableview];
            return oneCell;
        }
            break;
        default:
            break;
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
        case 0:
            return 200;
            break;
            
            case 1:
            return 50;
            break;
            
            case 2:
            return 250;
            break;
            
            case 3:
            return 200;
            break;
      
           case 4:
            return 150;
            break;
         case 5:
            return 200;
            break;
        
        default:
            break;
    }
    
    
    return 0;
    
  
}

# pragma mark -
# pragma mark  公寓房型列表
- (void)getHouseTypeData{
    [[NetworkClient sharedClient] POST:URL_APARTMENTHOUSETYPE dict:@{@"apartment_id":@1001008} succeed:^(id data) {
        LRLog(@"%@",data);
        
        
        //NSArray *returnArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
    } failure:^(NSError *error) {
        LRLog(@"%@",error);
    }];
    
    
}

# pragma mark -
# pragma mark 公寓房型详情
- (void)getHouseTypeDataDetail{
    [[NetworkClient sharedClient] POST:[NSString stringWithFormat:@"%@/%@",URL_APARTMENTHOUSETYPE,@1002003] dict:nil succeed:^(id data) {
        LRLog(@"%@",data);
    } failure:^(NSError *error) {
        LRLog(@"%@",error);
    }];
    
    
}
# pragma mark -
# pragma mark 咨询
- (void)ask{
//    consult	Number(32)	false	咨询方
//    beconsulted	Number(32)	false	被收藏方
//    type	Number(2)	false	咨询类型1=咨询房源
//    name	Number(32)	false	咨询人姓名
//    phone	String(32)	false	联系电话
//    email	String(64)	false	邮箱
//
    NSDictionary  * DICT = @{@"consult":@17,@"beconsulted":@1001008,@"type":@1,@"name":@"哈哈",@"sex":@1,@"phone":@"13783452657",@"email":@"245501373@qq.com"};
    
    [[NetworkClient sharedClient] POST:URL_ASKINFOMATION dict:DICT succeed:^(id data) {
        LRLog(@"%@",data);
    } failure:^(NSError *error) {
        LRLog(@"%@",error);
    }];
    
    
}
# pragma mark -
# pragma mark 评价
-(void)getComment{
//    comment	Number(32)	false	评价方(用户ID或评价ID)
//    commented	Number(32)	false	被评价方（房源ID)
//    type	Number(2)	false	评价类型，1=评价房源
     NSDictionary  * DICT = @{@"comment":@18,@"commented":@1001008,@"type":@1};
    
    [[NetworkClient sharedClient] POST:URL_GETCOMMENT dict:DICT succeed:^(id data) {
        LRLog(@"%@",data);
    } failure:^(NSError *error) {
        LRLog(@"%@",error);

    }];

}

- (void)addComment{
    NSDictionary  * DICT = @{@"comment":@18,@"commented":@1001008,@"type":@1,@"content":@"公寓致力为租客提供舒适的服务，并且不收取任何额外的费用。主要服务包括：畅享50M免费wifi服务，全天候安保系统，定期公共区域（例如，共用厨房、大厅等）清洁服务。该公寓距离曼彻斯特市中心仅5分钟步程，距离曼彻斯特城市大学和曼彻斯特大学北校区在10分钟左右步程"};
    
    [[NetworkClient sharedClient] POST:URL_ADDCOMMENT dict:DICT succeed:^(id data) {
        LRLog(@"%@",data);
    } failure:^(NSError *error) {
        LRLog(@"%@",error);
        
    }];

}
@end
