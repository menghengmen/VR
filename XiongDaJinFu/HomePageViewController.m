//
//  ViewController.m
//  XiongDaJinFu
//
//  Created by blinRoom on 16/10/13.
//  Copyright © 2016年 blinRoom. All rights reserved.
//

#import "HomePageViewController.h"
#import "SDCycleScrollView.h"
#import "homeTableViewCell.h"
#import "fullViewController.h"
#import "HotTableViewCellhot.h"
#import "CollectionViewCell.h"
#import "MHHouseListTableViewController.h"
#import "MHHouseDetailTableViewController.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "blinKeModel.h"
#import "hotHouse.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "XYUniversityDetailBaseVC.h"
#import "itemView.h"
#import "UIImageView+WebCache.h"
#import "XYHourseDetailTableVC.h"
#import "XYAbroadResidenceViewController.h"
#import "zhiXunWebViewController.h"
#import "XYZiXunWebViewController.h"

static NSString *reuseIdentifier = @"homeTableViewCell";
static NSString *collectionReuseIdentifier = @"collectionCell";

#define ICON_COUNT 3

@interface HomePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,hotTabelViewCellDelegate,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,itemViewDelegate,SDCycleScrollViewDelegate>


{
    NSString * imagePath;
    
    
    UICollectionView *   hotColle;

    UICollectionView *   zhixunColle;

    //全景图片
    fullViewController  * fullVC;
    UIView*contentView;
}

@property (nonatomic ,strong)NSMutableArray *zixunDataArray;
@property(nonatomic,strong)  UIButton  * cityChooseBtn;

@end

@implementation HomePageViewController

-(NSMutableArray *)zixunDataArray{
    if (!_zixunDataArray) {
        _zixunDataArray = [NSMutableArray array];
    }
    return _zixunDataArray;
}

- (NSMutableArray*)hotHouseArray{
    if (!_hotHouseArray) {
        _hotHouseArray = [NSMutableArray new];
    }

    return _hotHouseArray;
}

- (NSMutableArray*)ziXunArray {
    if (!_ziXunArray  ) {
        _ziXunArray = [NSMutableArray new];
    }
    
    return _ziXunArray;
}

- (NSMutableArray*)blinKeArray {
    if (!_blinKeArray  ) {
        _blinKeArray = [NSMutableArray new];
    }
    
    return _blinKeArray;
}
- (void)viewWillAppear:(BOOL)animated{
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf0f0f0];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self headRefresh];

}
- (void)setUpUI{

   // [self.tableView.mj_header beginRefreshing];

    [self.tableView.mj_header beginRefreshing];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    typeof (self)weakSelf = self;
     self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [weakSelf headRefresh];
     }];
    
    self.tableView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64);
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 50, 0);

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
     //全景图
    fullVC = [[fullViewController alloc] init];
    fullVC.view.frame = CGRectMake(0,0,SCREENWIDTH, SCREENHEIGHT-50);
    
    [self addChildViewController:fullVC];
    fullVC.view.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
   

    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contentView.backgroundColor = [UIColor clearColor];
    
    UIImageView  * logoImageView = [UIImageView new];
    logoImageView.image = [UIImage imageNamed:@"banner_logo"];
    [fullVC.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(fullVC.view);
        make.centerX.equalTo(fullVC.view);
        make.centerY.equalTo(fullVC.view).offset(-50);
        make.width.equalTo(@189);
        make.height.equalTo(@78);

    }];
    
    NSArray  * titileArr = @[@"国际公寓",@"海外住宅",@"VR定制"];
   // NSArray  * titileEnglishArr = @[@"International apartment",@"Overseas residential",@"VR custom"];

    // 按钮的尺寸
    CGFloat iconx = 15;
    CGFloat headerButtonWight = (SCREENWIDTH-iconx*(titileArr.count+1))/titileArr.count;
    CGFloat headerButtonHeight = headerButtonWight;
    itemView  * iView = [[itemView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-50-headerButtonHeight-40, SCREENWIDTH, headerButtonHeight) withItemArray:titileArr withEnglishArr:nil];
    iView.delegate = self;
    [fullVC.view addSubview:iView];
    
}

- (void)headRefresh{
    [self.hotHouseArray removeAllObjects];
    [self.blinKeArray removeAllObjects];
    [self.ziXunArray removeAllObjects];
    [self.bannerImageArray removeAllObjects];
    [self.imageArray removeAllObjects];
    [self getData];
}
# pragma mark -
# pragma mark 网络请求

-(void)getData{
    
    [[NetworkClient sharedClient] POST:URL_HOMEDATA dict:nil succeed:^(id data) {
        [self.tableView.mj_header endRefreshing];
        
        LRLog(@"%@",data);
       
        if (![data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            return ;
        }
            
            NSArray  * hotHouseArr = [[data objectForKey:@"result"] objectForKey:@"hot_apartment"];
            
            NSArray  * zhixunArr = [[data objectForKey:@"result"] objectForKey:@"informations"];
            //比邻客
            NSArray  * blinKeArr = [[data objectForKey:@"result"] objectForKey:@"abouts"];
            
            for (NSDictionary  * dict in hotHouseArr) {
                hotHouse  * model  = [hotHouse mj_objectWithKeyValues:dict];
                [self.hotHouseArray addObject:model];
                
            }
            for (NSDictionary  * dict in zhixunArr) {
                zhiXunModel  * model  = [zhiXunModel mj_objectWithKeyValues:dict];
                [self.ziXunArray addObject:model];
                [self.zixunDataArray addObject:model];
                
            }
            
            for (NSDictionary  * dict in blinKeArr) {
                blinKeModel  * model  = [blinKeModel mj_objectWithKeyValues:dict];
                [self.blinKeArray addObject:model];
                
            }
            
            if (self.blinKeArray.count<3) {
                for (NSDictionary  * dict in blinKeArr) {
                    blinKeModel  * model  = [blinKeModel mj_objectWithKeyValues:dict];
                    [self.blinKeArray addObject:model];
                    
                }
            }
            
            [self.tableView reloadData];
   } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        LRLog(@"++++++%@",error);
        //网络超时
        if (error.code == -1001) {
           // [XDCommonTool  alertWithMessage:@"网络超时"];
            [self getData];
        }
    }];

}
# pragma mark
# pragma mark - UITableViewDataSource

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//禁止下拉
        if (self.tableView.contentOffset.y <= 0) {
        self.tableView.bounces = NO;
    }
    else
        if (self.tableView.contentOffset.y >= 0){
            self.tableView.bounces = YES;
            
        }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
    if (indexPath.row ==0) {
        homeTableViewCell  *  cell = [homeTableViewCell homeTableViewCellWithTableView:tableView];
       
        [cell addSubview:fullVC.view];
        return cell;
        

    }
    if (indexPath.row ==1) {
        HotTableViewCellhot *  cellhot = [HotTableViewCellhot detailCellroomWithTableView:tableView];
        [cellhot initWithType:kHouseType];
        cellhot.delegate = self;

        [self creatUicollectionWith:cellhot];
        
        return cellhot;
    }
    
    if (indexPath.row ==2){
    
        HotTableViewCellhot *  cellhot1 = [HotTableViewCellhot detailCellroomWithTableView:tableView];
        cellhot1.label.text = @"热门资讯";
        cellhot1.moreBtn.hidden = YES;
        [self createZhiXun];
        [cellhot1.Maptableview addSubview:self.cycleScrollView];
        
        return cellhot1;
    
    }
    else{
    
      HotTableViewCellhot *  blinKeCell = [HotTableViewCellhot detailCellroomWithTableView:tableView ];
        [blinKeCell initWithType:kBlinKeType];
    
        [self setUpRunTimeUIWith:blinKeCell];
        return blinKeCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return SCREENHEIGHT-50;

    }
    if (indexPath.row ==3) {
        return 500*SCREENHEIGHT/1334;
    }
    
    else{
        return 240;
    }

}

-(void)createZhiXun{

    // 网络加载 --- 创建带标题的图片轮播器
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200) delegate:self placeholderImage:[UIImage imageNamed:@"main_default_img"]];
    self.cycleScrollView.mainView.scrollsToTop = NO;
    self.cycleScrollView.delegate = self;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
   
    NSMutableArray  * titleImageArr = [NSMutableArray new];
    NSMutableArray  * titleArray = [NSMutableArray new];

    
    for (int i = 0 ; i <self.ziXunArray.count; i ++) {
        zhiXunModel  * zM = self.ziXunArray[i];
        [titleImageArr addObject:zM.title_image];
        [titleArray addObject:zM.title];

    }
    _cycleScrollView.titlesGroup = titleArray;
    
    
//    NSMutableArray *arr = [NSMutableArray array];
//    for (zhiXunModel *zuxun in self.zixunDataArray) {
//        [arr addObject:zuxun.title];
//    }
//    _cycleScrollView.titlesGroup = arr;
    _cycleScrollView.currentPageDotColor = [UIColor whiteColor];
       //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cycleScrollView.imageURLStringsGroup = titleImageArr;
        
    });
    [self.tableView addSubview:self.cycleScrollView];


}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

    zhiXunModel  * zM = self.ziXunArray[index];
    zhiXunWebViewController  * ziXunWebVC = [zhiXunWebViewController new];
    ziXunWebVC.urlStr  = zM.context_image;
    ziXunWebVC.titleStr = zM.title;
    
    [self.navigationController pushViewController:ziXunWebVC  animated:YES];

}



//创建推荐房源和热门资讯
-(void)creatUicollectionWith:(HotTableViewCellhot*)hot{
    //创建纵向uicollec
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(256, 200);
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    layout.sectionInset=UIEdgeInsetsMake(0, 5, 0, 5);
    UICollectionView *   collec=[[UICollectionView alloc]initWithFrame: CGRectMake(0,0,SCREENWIDTH, 200)  collectionViewLayout:layout];
    collec.backgroundColor=[UIColor whiteColor];
    collec.delegate=self;
    collec.dataSource=self;
    collec.userInteractionEnabled=YES;
    [collec registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionReuseIdentifier];
        hotColle = collec;

    [hot.Maptableview addSubview:collec];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
        return self.hotHouseArray.count;
  
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CollectionViewCell *roomcell=[collectionView dequeueReusableCellWithReuseIdentifier:collectionReuseIdentifier forIndexPath:indexPath];
    
        roomcell.hotHouseModel = self.hotHouseArray[indexPath.row];
 
    return roomcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
      hotHouse  * hModel = [self.hotHouseArray objectAtIndex:indexPath.row];
    XYHourseDetailTableVC *detail = [[XYHourseDetailTableVC alloc]init];
    detail.faltId = hModel.ID;
    detail.title = @"公寓详情";
    [self.navigationController pushViewController:detail animated:YES];
    //[self.navigationController pushViewController:[MHHouseDetailTableViewController new] animated:YES];

}
# pragma mark -
# pragma mark hotTabelViewCellDelegate

- (void)moreBtnClick:(hotType)hotType{

    switch (hotType) {
        case kHouseType:
            {
            [MobClick event:@"MineToList" attributes:@{@"type":@"main_hot"}];
            XYUniversityDetailBaseVC *un =[[XYUniversityDetailBaseVC alloc]init];
            un.hourseType = XYHourseTypeFlat;
            [self.navigationController pushViewController:un animated:YES];
        }
            break;
            
      case kZhiXunType:
            [XDCommonTool alertWithMessage:@"热门资讯的更多"];

         
            break;
        default:
            break;
    }


}
# pragma mark -
# pragma mark ACTION

-(void)tagClick:(NSInteger)tag{

    if (tag == 999) {
        [MobClick event:@"ToFlatList" attributes:@{@"type":@"main_falt"}];
        XYUniversityDetailBaseVC *un =[[XYUniversityDetailBaseVC alloc]init];
        un.hourseType = XYHourseTypeFlat;
        [self.navigationController pushViewController:un animated:YES];
    }else if (tag == 1000){
        XYUniversityDetailBaseVC *un =[[XYUniversityDetailBaseVC alloc]init];
        un.hourseType = XYHourseTypeResidence;
        [self.navigationController pushViewController:un animated:YES];
    }else if (tag == 1001){

            XYZiXunWebViewController *zixun = [[XYZiXunWebViewController alloc]initWithNibName:NSStringFromClass([XYZiXunWebViewController class]) bundle:nil];
            zixun.url = @"http://u4320408.viewer.maka.im/k/SJZX20LU";
//            zixun.title = model.title;
            [self.navigationController pushViewController:zixun animated:true];
    }
}
- (void)setUpRunTimeUIWith:(HotTableViewCellhot*)hot{
  
        for (int index = 0; index < self.blinKeArray.count; index++) {
            blinKeModel  * model = self.blinKeArray[index];
            
            UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"Blinroom%d",index+1]];
            
            [self.imageArray addObject:image];
            // [self downloadImageWithUrl:model.image];
            
        }
    
    if (self.imageArray.count==0) {
                   return;
       }
   
  
    
    
    for (NSInteger imageIndex = 0; imageIndex < 3; imageIndex ++) {
        [self.bannerImageArray addObjectsFromArray:self.imageArray];
        
    }
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, (SCREENWIDTH - 84) * 9 / 16 + 24)];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    pageFlowView.minimumPageScale = 0.85;
    pageFlowView.orginPageCount = self.imageArray.count;
    //开启自动轮播
    //[pageFlowView startTimer];
    [hot.Maptableview addSubview:pageFlowView];
}

- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (NSMutableArray *)bannerImageArray {
    if (_bannerImageArray == nil) {
        _bannerImageArray = [NSMutableArray array];
    }
    return _bannerImageArray;
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(SCREENWIDTH - 84, (SCREENWIDTH - 84) * 9 / 16);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.bannerImageArray.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
   
      if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 84, (SCREENWIDTH - 84) * 9 / 16)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    bannerView.mainImageView.image = self.bannerImageArray[index];

    
    return bannerView;
}

//异步线程加载网络下载图片 ——> 回到主线程更新UI
-(void)downloadImageWithUrl:(NSString *)imageDownloadURLStr{
    //以便在block中使用
    __block UIImage *image = [[UIImage alloc] init];
    //图片下载链接
    NSURL *imageDownloadURL = [NSURL URLWithString:imageDownloadURLStr];
    //将图片下载在异步线程进行
    //创建异步线程执行队列
    dispatch_queue_t asynchronousQueue = dispatch_queue_create("imageDownloadQueue", NULL);
    //创建异步线程
    dispatch_async(asynchronousQueue, ^{
        //网络下载图片  NSData格式
        NSError *error;
        NSData *imageData = [NSData dataWithContentsOfURL:imageDownloadURL options:NSDataReadingMappedIfSafe error:&error];
        if (imageData) {
            image = [UIImage imageWithData:imageData];
        }

        //回到主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.imageArray addObject:image];

        
        });
    });
}

#pragma mark -- SDCycleScrollViewDelegate
//-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
//    zhiXunModel *model = self.zixunDataArray[index];
//    zhiXunWebViewController *zixun = [[zhiXunWebViewController alloc]initWithNibName:NSStringFromClass([zhiXunWebViewController class]) bundle:nil];
//    zixun.url = @"https://baidu.com";
//    zixun.title = model.title;
//    [self.navigationController pushViewController:zixun animated:true];
//}
@end
