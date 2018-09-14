//
//  XYUniversityDetailVC.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/13.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYUniversityDetailBaseVC.h"
#import "ESPullDownView.h"
#import "XYSidePopView.h"
#import "XYSiftTableView.h"
#import "XYFlatListTableViewCell.h"
#import "XYFlatListModel.h"
#import "XYHourseDetailTableVC.h"
#import "CustomNavigationController.h"
#import "XYAbroadResidenceViewController.h"
#import "XYDBManager.h"
#import "loginViewController.h"
#import "XYHourseSiftTableView.h"
#import "XYNewIntroduceView.h"
@interface XYUniversityDetailBaseVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArray;
//@property (nonatomic,strong)XYSiftTableView *siftTableView;
@property (nonatomic,strong)XYSidePopView *sidePopVIew;
@property (nonatomic,strong)XYHourseSiftTableView *siftTableView;
@property (nonatomic,strong)NSMutableDictionary *siftDict;
@property (nonatomic,assign)BOOL toolIsHidden;
@property (nonatomic,strong)UIButton *siftBtn;

@property (nonatomic,strong)NSDictionary *settingDict;
@end

@implementation XYUniversityDetailBaseVC
{
    NSInteger _indexPage;
    CGFloat _firstContentOffSet;
}
- (void)viewDidLoad {
    
//    LxDBAnyVar([XYToolCategory readLocalSettingInfoFormDefault]);
//    LxDBAnyVar([XYToolCategory getInfoFormDict:[XYToolCategory readLocalSettingInfoFormDefault] andPropertyKey:@"bhfy" privateKey:@"df"]);
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _indexPage = 1;
    self.toolIsHidden = false;
    NSArray *hourseType =@[@"国际公寓",@"海外住宅"];
//    self.title =hourseType[(int)self.hourseType - 1];
    self.navigationItem.titleView = [UILabel navigationTitleLabelWithText:hourseType[(int)self.hourseType - 1]];
    [self initToolBar];
    [[XYDBManager sharedDBManager] creatOrOpenTableWithName:@"test"];
    self.siftDict[@"country"] = @"1";
    if (self.university) {
        self.siftDict[@"univ"] = self.university;
    }
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.settingDict = [XYToolCategory readLocalSettingInfoFormDefault];
    NSArray *hourseType =@[@"FlatListViewController",@"HourseListVIewController"];
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:hourseType[self.hourseType -1]];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];/// 这句设置是为了不影响子图层的透明度
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = true;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.alpha = 1;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSArray *hourseType =@[@"FlatListViewController",@"HourseListVIewController"];
    [MobClick endLogPageView:hourseType[self.hourseType -1]];
}

-(void)getBackView:(UIView*)superView
{
    if ([superView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
    {
        //在这里可设置背景色
        superView.backgroundColor = [UIColor whiteColor];
    }
    else if ([superView isKindOfClass:NSClassFromString(@"_UIBackdropView")])
    {
        
        //_UIBackdropEffectView是_UIBackdropView的子视图，这是只需隐藏父视图即可
        superView.hidden = false;
    }
    
    for (UIView *view in superView.subviews)
    {
        [self getBackView:view];
    }
}

-(NSMutableArray *)dataArray{
    if ((!_dataArray)) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableDictionary *)siftDict{
    if (!_siftDict) {
        _siftDict = [NSMutableDictionary dictionary];
    }
    return _siftDict;
}

-(XYHourseSiftTableView *)siftTableView{
    if (!_siftTableView) {
        _siftTableView = [[XYHourseSiftTableView alloc]initWithFrame:CGRectMake(SCREEN_MAIN.width - 290, 0, 290, SCREEN_MAIN.height)];
        _siftTableView.hourseType = self.hourseType;
    }
    return _siftTableView;
}

-(void)initToolBar{
    self.automaticallyAdjustsScrollViewInsets = false;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden =NO;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"icon_plus@3x"]  forBarMetrics:UIBarMetricsDefault];
    
    //tableview
    [self creatTableView];
    
    //工具栏
    UIView *tool = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_MAIN.width, 30)];
    tool.tag = 99;
    [self.view addSubview:tool];
    [self.view bringSubviewToFront:tool];
    
    NSArray *arr =@[@"推荐排序",@"筛选"];
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:arr[0] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setBackgroundColor:[UIColor whiteColor]];
//    btn.layer.borderWidth =.5f;
//    btn.layer.borderColor =[UIColor blackColor].CGColor;
    [btn setTitleColor:[UIColor colorWithHex:0x29a7e1] forState:UIControlStateNormal];
    btn.frame =CGRectMake(0, 0, SCREEN_MAIN.width, 30);
    btn.tag = 100;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tool addSubview:btn];
    
    UIView *siftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:siftView];
    
    UIButton *sift = [UIButton buttonWithType:UIButtonTypeCustom];
//    [sift setTitle:@"筛选" forState:UIControlStateNormal];
    [sift setImage:[UIImage imageNamed:@"icon_screen"] forState:UIControlStateNormal];
    sift.tag = 101;
    self.siftBtn = sift;
    sift.titleLabel.font = [UIFont systemFontOfSize:15];
    [sift addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    sift.frame = CGRectMake(10, 0, 40, 40);
    [sift setTitleColor:[UIColor colorWithHex:0x29a7e1] forState:UIControlStateNormal];
    [siftView addSubview:sift];
    
//    CustomNavigationController *nav = (CustomNavigationController *)self.navigationController;
//    nav.backButtonClickBlock = ^(){
//        [self.sidePopVIew dismissplay];
//    };
}

-(void)creatTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_MAIN.width, SCREEN_MAIN.height - 64) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView =tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.backgroundColor = [UIColor colorWithHex:0xf0f0f0];
    tableView.tableFooterView =[UIView new];
    
    //registTableViewCell
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYFlatListTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYFlatListTableViewCell class])];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _indexPage = 1;
        [self requestData:1];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _indexPage ++;
        [self requestData:_indexPage];
    }];
}

-(void)requestData:(NSInteger)page{
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:self.siftDict];
    dic[@"page_size"] = @10;
    dic[@"page_no"] = @(page);
    //大学
    NSString *univ = dic[@"univ"];
    if (univ.length >0) {
        dic[@"univ"] = @([dic[@"univ"] integerValue]);
    }else{
        [dic removeObjectForKey:@"univ"];
    }
    //城市
    NSString *city = dic[@"city"];
    if (city.length == 0) {
        [dic removeObjectForKey:@"city"];
    }
    //国家
    NSString *country = dic[@"country"];
    if (country.length == 0) {
        [dic removeObjectForKey:@"city"];
    }
    
    NSString *maxPrice = dic[@"maxPrice"];
    if (maxPrice.length == 0) {
        [dic removeObjectForKey:@"maxPrice"];
    }else{
        dic[@"maxPrice"] = @([dic[@"maxPrice"] doubleValue]);
    }
    
    NSString *minPrice = dic[@"minPrice"];
    if (minPrice.length == 0) {
        [dic removeObjectForKey:@"minPrice"];
    }else{
        dic[@"minPrice"] = @([dic[@"minPrice"] doubleValue]);
    }
    
//    dic[@"id"] = [XDCommonTool readDicFromUserDefaultWithKey:@"id"];
    
    if (self.hourseType == XYHourseTypeFlat) {//公寓
        [[ESWebService sharedWebService].flat getFlatListWithParameter:dic success:^(id jsonData) {
            //公寓
            if ((![XDCommonTool readBoolFromUserDefaultWithKey:@"userIsNew"]) && (self.hourseType == XYHourseTypeFlat)) {
                [[XYNewIntroduceView sharedIntroudence]showIntroduceWithItems:@[[XYIntroduceItemObj itemWithRect:CGRectMake(SCREEN_MAIN.width -50, 22, 40, 40) type:XYIntrodeceItemTypeOval cornerRadius:10]]];
                [XYNewIntroduceView sharedIntroudence].clickBlock = ^(){
                    [XDCommonTool saveToUserDefaultWithBool:true key:@"userIsNew"];
                    [[XYNewIntroduceView sharedIntroudence]hiddenIntroduce];
                };
            }
            
            if (page == 1) {
                [self.dataArray removeAllObjects];
            }
            
            for (NSDictionary *dict in jsonData) {
                XYFlatListModel *model = [XYFlatListModel yy_modelWithDictionary:dict];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        } failure:^(NSString *error,NSString *errorCode) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            //        [[XYCustomStatusbar sharedStatusBar] hiddenStatusBar];
            if (_indexPage>1) {
                _indexPage --;
            }
            [MBProgressHUD showError:error];
        }];
    }else if (self.hourseType == XYHourseTypeResidence){//住宅
        [[ESWebService sharedWebService].flat getHourseListWithParameter:dic success:^(id jsonData) {
            
            //住宅
            if ((![XDCommonTool readBoolFromUserDefaultWithKey:@"userIsNew1"]) && (self.hourseType == XYHourseTypeResidence)) {
                [[XYNewIntroduceView sharedIntroudence]showIntroduceWithItems:@[[XYIntroduceItemObj itemWithRect:CGRectMake(SCREEN_MAIN.width -50, 22, 40, 40) type:XYIntrodeceItemTypeOval cornerRadius:10]]];
                [XYNewIntroduceView sharedIntroudence].clickBlock = ^(){
                    [XDCommonTool saveToUserDefaultWithBool:true key:@"userIsNew1"];
                    [[XYNewIntroduceView sharedIntroudence]hiddenIntroduce];
                };
            }
            
            if (page == 1) {
                [self.dataArray removeAllObjects];
            }
            
            for (NSDictionary *dict in jsonData) {
                XYFlatListModel *model = [XYFlatListModel yy_modelWithDictionary:dict];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        } failure:^(NSString *error, NSString *errorCode) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (_indexPage>1) {
                _indexPage --;
            }
            [MBProgressHUD showError:error];
        }];
    }
}

-(void)btnClick:(UIButton *)sender{
    //点击排序
    if (sender.tag ==100) {
        //获取筛选条件
        NSMutableArray *array = [NSMutableArray array];
        NSString *univ = self.siftDict[@"univ"];
        NSMutableArray *seleArray = [NSMutableArray arrayWithArray:[XDCommonTool getSettingInfoWithKey:@"fypx"]];
        
        //将距离学校远近选项放到最后
//        for (int i = 0; i<seleArray.count; i++) {
//            NSDictionary *dict = seleArray[i];
//            if ([dict[@"alias"] isEqualToString:@"lxxzj"]) {
//                [seleArray removeObject:dict inRange:NSMakeRange(i, 1)];
//                [seleArray addObject:dict];
//                break;
//            }
//        }
        
        //判断是否选择了学校
        for (NSDictionary *dict in seleArray) {
            if ([dict[@"alias"] isEqualToString:@"lxxzj"] && !(univ && univ.length>0)) {
                [array addObject:[NSString stringWithFormat:@"%@%@",dict[@"name_zh"],@"(请先选择就读的大学)"]];
            }else{
                [array addObject:dict[@"name_zh"]];
            }
        }
        [array insertObject:@"推荐排序" atIndex:0];
        
        ESPullDownView *pullDownView =[ESPullDownView pullDownView];
        pullDownView.layer.borderColor =[[UIColor blackColor] colorWithAlphaComponent:0.25f].CGColor;
        pullDownView.layer.borderWidth =.3f;
        pullDownView.cellType =1;
        UIButton *btn =(UIButton *)[self.view viewWithTag:sender.tag];
        [pullDownView showFromView:btn withData:array];
        pullDownView.clickCallBack = ^(NSInteger index){
            NSLog(@"%@",array[index]);
            [btn setTitle:array[index] forState:UIControlStateNormal];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.siftDict];
            if (index == 0) {
                dict[@"sort"] = @"";
            }else{
                dict[@"sort"] = seleArray[index -1][@"alias"];
            }
            self.siftDict = dict;
            [self.tableView.mj_header beginRefreshing];
        };
        
        if (_isShowSidePopView) {
            [self.sidePopVIew dismissplay];
        }
    }else if (sender.tag ==101){
        if (!_isShowSidePopView) {
            XYSidePopView *sidePopView =[XYSidePopView initWithCustomView:self.siftTableView andBackgroundFrame:[self.view convertRect:[UIApplication sharedApplication].keyWindow.frame toView:[UIApplication sharedApplication].keyWindow] andPopType:popTypeRight];
            self.sidePopVIew =sidePopView;
            @weakify(self);
            self.siftTableView.btnClickeBlock = ^(UIButton *button,NSMutableDictionary *dict){
                @strongify(self);
                [self.sidePopVIew dismissplay];
                
                [self.siftBtn setImage:[UIImage imageNamed:@"icon_screen_pre"] forState:UIControlStateNormal];
                //TODO: 重新请求数据
                self.siftDict = dict;
                [self.tableView.mj_header beginRefreshing];
            };
            _isShowSidePopView = true;
            sidePopView.PopViewStatusBlock = ^(BOOL isShow,UIView *customView){
                [self.siftBtn setImage:[UIImage imageNamed:@"icon_screen_pre"] forState:UIControlStateNormal];
                if (isShow == false) {
                    _isShowSidePopView = isShow;
                }else{
                }
            };
        }else{
            [self.sidePopVIew dismissplay];
        }
    }
    
}

#pragma mark -- tableview Delegata and Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYFlatListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYFlatListTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.type = self.hourseType;
    cell.settingDict = self.settingDict;
    cell.country = self.siftDict[@"country"];
    cell.model = self.dataArray[indexPath.row];
    cell.likeBtnClickBlock = ^(BOOL like){
        [self detailLikeWithModel:self.dataArray[indexPath.row] andLike:like index:indexPath.row];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 255;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.hourseType == XYHourseTypeFlat) {
        XYFlatListModel *model = self.dataArray[indexPath.row];
        XYHourseDetailTableVC *detail = [[XYHourseDetailTableVC alloc]init];
        detail.faltId = model.faltId;
        detail.likeBtnClickBlock = ^(BOOL like) {
            XYFlatListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.favouriteBtn setBackgroundImage:[UIImage imageNamed:(like && like ==true) ?@"shoucang_icon_xin_-pre":@"shoucang_icon_xin"] forState:UIControlStateNormal];
            model.like = like;
        };
        detail.settingInfo = self.settingDict;
        detail.title = @"公寓详情";
        [self.navigationController pushViewController:detail animated:YES];
    }else if (self.hourseType == XYHourseTypeResidence){
        XYFlatListModel *model = self.dataArray[indexPath.row];
        XYAbroadResidenceViewController *abroad = [[XYAbroadResidenceViewController alloc]init];
        abroad.likeBtnClickBlock = ^(BOOL like) {
            XYFlatListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.favouriteBtn setBackgroundImage:[UIImage imageNamed:(like && like ==true) ?@"shoucang_icon_xin_-pre":@"shoucang_icon_xin"] forState:UIControlStateNormal];
            model.like = like;
        };
        abroad.settingInfo = self.settingDict;
        abroad.title = @"住宅详情";
        abroad.hourseId = model.faltId;
        [self.navigationController pushViewController:abroad animated:YES];
    }
}

-(void)detailLikeWithModel:(XYFlatListModel *)model andLike:(BOOL)like index:(NSInteger)index{
    
    NSDictionary *dic = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
    if (!dic) {
        loginViewController *login = [[loginViewController alloc]init];
        [self.navigationController pushViewController:login animated:true];
        return;
    }
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    if (like) {//收藏
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"like"] = dic[@"id"];//收藏方
        dict[@"be_liked"] = model.faltId;//被收藏方
        if (self.hourseType == XYHourseTypeFlat) {//收藏类型，1=收藏房源，2=住宅， 3
            dict[@"type"] =@1 ;
        }else if(self.hourseType == XYHourseTypeResidence){
            dict[@"type"] =@2 ;
        }
        NSLog(@"请求发起时间%@",[self getCurrentTime]);
        [[ESWebService sharedWebService].flat addLikeParameter:dict success:^(id jsonData) {
            NSLog(@"收到请求时间%@",[self getCurrentTime]);
            CFAbsoluteTime useTime = (CFAbsoluteTimeGetCurrent() - startTime);
            NSLog(@"请求耗时：%lf ms", useTime*1000.0);
            [self functionUseTimesDurtionBlock:^{
                XYFlatListModel *model = self.dataArray[index];
                model.like =!model.like;
                model.like_id = jsonData[@"id"];
                [self.dataArray replaceObjectAtIndex:index withObject:model];
                [self.tableView reloadData];
            }];
        } failure:^(NSString *error,NSString *errorCode) {
            if ([errorCode isEqualToString:@"40004"]) {
                loginViewController *login = [[loginViewController alloc]init];
                [self.navigationController pushViewController:login animated:true];
            }else if ([errorCode isEqualToString:@"40401"]){//收藏过了
                XYFlatListModel *model = self.dataArray[index];
                model.like =!model.like;
                model.like_id = error;
                [self.dataArray replaceObjectAtIndex:index withObject:model];
                [self.tableView reloadData];
            }
        }];
    }else{//取消收藏
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"like_id"] = model.like_id;
        dict[@"like"] = dic[@"id"];//收藏方
        [[ESWebService sharedWebService].flat deleteLikeParameter:dict success:^(id jsonData) {
            CFAbsoluteTime useTime = (CFAbsoluteTimeGetCurrent() - startTime);
            NSLog(@"请求耗时：%lf ms", useTime*1000.0);
            [self functionUseTimesDurtionBlock:^{
                XYFlatListModel *model = self.dataArray[index];
                model.like =!model.like;
                [self.dataArray replaceObjectAtIndex:index withObject:model];
                [self.tableView reloadData];
            }];
        } failure:^(NSString *error,NSString *errorCode) {
            if ([errorCode isEqualToString:@"40004"]) {
                loginViewController *login = [[loginViewController alloc]init];
                [self.navigationController pushViewController:login animated:true];
            }
        }];
    }
}

-(void)setToolIsHidden:(BOOL)toolIsHidden{
    _toolIsHidden = toolIsHidden;
//    UIButton *btn = (UIButton *)[self.view viewWithTag:100];
    UIView *view = (UIView *)[self.view viewWithTag:99];
    if (toolIsHidden) {//隐藏
        [UIView animateWithDuration:0.3 animations:^{
//            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            view.frame = CGRectMake(0, 34, SCREEN_MAIN.width, 30);
        } completion:^(BOOL finished) {
            
        }];
    }else{//显示
        [UIView animateWithDuration:0.3 animations:^{
//            self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
            view.frame = CGRectMake(0, 64, SCREEN_MAIN.width, 30);
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.tableView) {
        _firstContentOffSet = scrollView.contentOffset.y;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tableView) {
        if (scrollView.contentOffset.y -_firstContentOffSet >=40) {//向下
            self.toolIsHidden = true;
        }else{//向上
            self.toolIsHidden = false;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[SDWebImageManager sharedManager] cancelAll];
    
    [[SDImageCache sharedImageCache] clearDisk];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
