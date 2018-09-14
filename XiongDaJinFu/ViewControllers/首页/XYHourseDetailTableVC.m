//
//  XYHourseDetailTableVC.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/15.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYHourseDetailTableVC.h"
#import "CustomNavigationController.h"
#import "XYHourseTypeTVCell.h"
#import "XYSupplyerAboutTVCell.h"
#import "XYFlatListTableViewCell.h"
#import "XYHourseDetailDesTVCell.h"
#import "XYHourseDetailMapTVCell.h"
#import "XYHourseDetailTYpeTVCell.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import <YYModel.h>
#import "XYScheduleNoticeVC.h"
#import "ESTableBowserHeader.h"
#import "XYImageModel.h"
#import "XYCommentTableVC.h"
#import "XYSidePopView.h"
#import "XYTeleConsultView.h"
#import "XYHourseDetailNameTBVCell.h"
#import "XYFacliltiesTableViewCell.h"
#import "XYMapViewController.h"
#import "XYScheduleOrderVC.h"
#import "XYFlatBrawerHeader.h"
#import "XYBrawerHeaderImageView.h"
#import "PlayerViewController.h"
#import "XYFullScreenImagesDeawer.h"
#import "XYCollectionBrawer.h"
#import "TestCollectionViewCell.h"
@interface XYHourseDetailTableVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign)BOOL hourseDesIsFold;
@property (nonatomic,assign)BOOL facilitiesIsFold;
@property (nonatomic,strong) PlayerViewController *vc;
@property (nonatomic,strong) NSArray *originImagesArray;
@property (nonatomic,strong) XYFlatListModel *dataModel;
//@property (nonatomic,strong) XYFlatBrawerHeader *header;
@property (nonatomic,strong) XYCollectionBrawer *header;
@property (nonatomic,strong) XYTeleConsultView *teleConsultView;
@property (nonatomic,strong) NSMutableArray *imagesData;
@property (nonatomic,strong) NSMutableArray *dataArray;

//@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,strong)UIButton *likeBtn;
@end

@implementation XYHourseDetailTableVC
{
    //    BOOL _facIsOpen;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.facilityIsOpen = false;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self creatTableView];
    [self requestData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];/// 这句设置是为了不影响子图层的透明度
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = true;
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.hidden = false;
}
//
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
}

//lazy

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

//-(XYFlatBrawerHeader *)header{
//    if (!_header ) {
//        _header = [[XYFlatBrawerHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_MAIN.width, 230)];
//        _header.delegate = self;
//        [self.view addSubview:_header];
//    }
//    return _header;
//}

-(XYCollectionBrawer *)header{
    if (!_header) {
        _header = [[XYCollectionBrawer alloc]initWithFrame:CGRectMake(0, 0, SCREEN_MAIN.width, 230)];
    }
    return _header;
}

-(NSMutableArray *)imagesData{
    if (!_imagesData) {
        _imagesData = [NSMutableArray array];
    }
    return _imagesData;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_MAIN.width, SCREEN_MAIN.height -64) style:UITableViewStylePlain];
        self.automaticallyAdjustsScrollViewInsets = false;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
        _tableView.tableHeaderView = self.header;
        @weakify(self);
        self.header.imageClickBlock = ^(XYImageModel *model, NSInteger index) {
            @strongify(self);
            if (model.isVideo == XYPhonesTypeFullVideos) {//全景视频
                HTY360PlayerVC * hty360VC =[HTY360PlayerVC sharedInstance];
                hty360VC.videoTitle = self.model.name;
                hty360VC.videoURL = [NSURL URLWithString:model.url];
                [self presentViewController:hty360VC animated:NO completion:nil];
            }else if (model.isVideo == XYPhonesTypeFullImage){//全景图片
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BitmapPlayer" bundle:nil];
                self.vc = [storyboard instantiateViewControllerWithIdentifier:@"BitmapPlayerViewController"];
                [self addChildViewController:self.vc];
                [self.view addSubview:self.vc.view];
                [self.vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.view);
    
                }];
                    //网络请求
                    [self.vc initParams:[NSURL URLWithString:model.url]];
                }else if (model.isVideo == XYPhonesTypeImage){//普通图片
        
                    NSMutableArray *arr = [NSMutableArray array];
                    NSMutableArray *titles = [NSMutableArray array];
                    for (NSArray *arr1 in self.imagesData) {
                        for (XYImageModel *imageModel in arr1) {
                            if (imageModel.isVideo == XYPhonesTypeImage) {
                                [arr addObject:imageModel.url];
                                [titles addObject:imageModel.des];
                            }
                        }
                    }
    
                [XYFullScreenImagesDeawer sharedImageBrawer].titlesArray = titles;
                [[XYFullScreenImagesDeawer sharedImageBrawer]showImageBrawerWithDataArray:arr andCurrentIndex:index andBegainRect:[self.view convertRect:self.tableView.tableHeaderView.frame toView:[UIApplication sharedApplication].keyWindow]];
                [[UIApplication sharedApplication].keyWindow addSubview:[XYFullScreenImagesDeawer sharedImageBrawer]];
            }
        };
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHex:0xf0f0f0];
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 50;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYHourseDetailMapTVCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYHourseDetailMapTVCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYHourseDetailDesTVCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYHourseDetailDesTVCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYHourseDetailTYpeTVCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYHourseDetailTYpeTVCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYSupplyerAboutTVCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYSupplyerAboutTVCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYHourseDetailNameTBVCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYHourseDetailNameTBVCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYFacliltiesTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYFacliltiesTableViewCell class])];
    }
    return _tableView;
}


-(XYTeleConsultView *)teleConsultView{
    if (!_teleConsultView) {
        _teleConsultView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([XYTeleConsultView class]) owner:nil options:nil][0];
        _teleConsultView.frame = CGRectMake(0, 0, 270, 278);
        _teleConsultView.center = [UIApplication sharedApplication].keyWindow.center;
    }
    return _teleConsultView;
}

-(void)creatTableView{
    [self.view addSubview:self.tableView];
    //    [self.tableView.mj_header beginRefreshing];
    
    UIView *tool = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_MAIN.height - 45, SCREEN_MAIN.width, 45)];
    tool.backgroundColor = [UIColor clearColor];
    for (int i = 0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tool addSubview:button];
        button.tag = 300 +i;
        
        NSArray *arr =@[@"收藏",@"QQ咨询",@"电话咨询"];
        if (i == 0) {
            self.likeBtn = button;
            button.frame = CGRectMake(15, 5, 35, 35);
            //            [button setTitle:@"收藏" forState:UIControlStateNormal];
            self.like = self.model.like;
        }else {
            button.frame = CGRectMake(65 +(i -1)*((SCREEN_MAIN.width - 75)/2.0 +5), 5, (SCREEN_MAIN.width - 65 -10)/2.0, 35);
            button.clipsToBounds = true;
            button.layer.borderWidth = 1.0f;
            button.layer.cornerRadius  =6.0f;
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button setTitle:arr[i] forState:UIControlStateNormal];
            if (i == 1) {
                [button setBackgroundColor:[UIColor whiteColor]];
                button.layer.borderColor = [UIColor colorWithHex:0x29a7e1].CGColor;
                [button setTitleColor:[UIColor colorWithHex:0x29a7e1] forState:UIControlStateNormal];
            }else if(i == 2){
                [button setBackgroundColor:[UIColor colorWithHex:0x29a7e1]];
                button.layer.borderColor = [UIColor colorWithHex:0x29a7e1].CGColor;
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
        
        [button addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:tool];
}

-(void)setLike:(BOOL)like{
    _like = like;
    if (self.likeBtnClickBlock) {
        self.likeBtnClickBlock(like);
    }
    if (like) {
        [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"shoucang_icon_xin_-pre"] forState:UIControlStateNormal];
    }else{
        [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"shoucang_icon_xin"] forState:UIControlStateNormal];
    }
}

-(void)buttonClick1:(UIButton *)sender{
    if (sender.tag == 300) {//收藏
        [self detailLikeWithModel:self.model andLike:!self.model.like index:0];
    }else if (sender.tag == 301){//QQ咨询
        
        [MobClick event:@"QQ"];
        if ([QQApiInterface isQQInstalled]) {
            NSString *qqStr=[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",consultQQ];
            NSURL *url = [NSURL URLWithString:qqStr];
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
            }else{
                [[UIApplication sharedApplication] openURL:url];
            }
        }else{
            
            [MobClick event:@"telephone"];
//            TDAlertItem *item1 = [[TDAlertItem alloc] initWithTitle:@"取消"];
            TDAlertItem *item2 = [[TDAlertItem alloc] initWithTitle:@"确定"];
            item2.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
            item2.titleColor = [UIColor colorWithHexString:@"fffefe"];
            TDAlertView *alert = [[TDAlertView alloc] initWithTitle:@"提醒" message:@"本机尚未安装QQ，请先行安装" items:@[item2] delegate:nil];
            alert.hideWhenTouchBackground = NO;
            
            [alert show];
        }
    }else if (sender.tag == 302){//电话咨询
        //判断登录
        NSDictionary *dic = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
        if (!dic) {
            loginViewController *login = [[loginViewController alloc]init];
            [self.navigationController pushViewController:login animated:true];
            return;
        }
        XYSidePopView *side = [XYSidePopView initWithCustomView:self.teleConsultView andBackgroundFrame:[UIApplication sharedApplication].keyWindow.frame andPopType:popTypeMid];
        NSDictionary *info = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
        if (info) {
            self.teleConsultView.info = info;
        }
        
        side.backgroundClickBlock = ^{
            [self.teleConsultView.nameTextFidle resignFirstResponder];
            [self.teleConsultView.phoneTextFidle resignFirstResponder];
            [self.teleConsultView.emailTextFidle resignFirstResponder];
        };
        
        @weakify(self);
        self.teleConsultView.scheduleBtnClickBlock = ^(NSDictionary *dict){
            @strongify(self);
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"beconsulted"] = self.model.faltId;
            dic[@"type"] = @(1);
            dic[@"name"] = dict[@"name"];
            dic[@"phone"] = dict[@"phone"];
            dic[@"email"] = dict[@"email"];
            dic[@"consult"] = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO][@"id"];
            dic[@"sex"] = @1;
            [MBProgressHUD showIndicatorMessage:@"提交中" toView:self.teleConsultView];
            [[ESWebService sharedWebService].flat telePhoneScheduleWithParameter:dic success:^(id jsonData) {
                [MBProgressHUD hideHUDForView:self.teleConsultView];
                [MBProgressHUD showSuccess:@"提交咨询信息成功"];
                [side dismissplay];
                
            } failure:^(NSString *error, NSString *errorCode) {
                [MBProgressHUD hideHUDForView:self.teleConsultView];
                [MBProgressHUD showMessage:error];
            }];
        };
        side.PopViewStatusBlock = ^(BOOL status,UIView *popView){
            
        };
    }
}

-(void)detailLikeWithModel:(XYFlatListModel *)model andLike:(BOOL)like index:(NSInteger)index{
    NSDictionary *dic = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
    if (!dic) {
        loginViewController *login = [[loginViewController alloc]init];
        [self.navigationController pushViewController:login animated:true];
        return;
    }
    if (like) {//收藏
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"like"] = dic[@"id"];//收藏方
        dict[@"be_liked"] = model.faltId;//被收藏方
        dict[@"type"] =@1 ;//收藏类型，1=收藏房源，2=收藏用户（关注）
        [[ESWebService sharedWebService].flat addLikeParameter:dict success:^(id jsonData) {
            self.like = true;
            self.model.like = true;
            self.model.like_id = jsonData[@"id"];
        } failure:^(NSString *error,NSString *errorCode) {
            if ([errorCode isEqualToString:@"40004"]) {
                loginViewController *login = [[loginViewController alloc]init];
                [self.navigationController pushViewController:login animated:true];
            }else if ([errorCode isEqualToString:@"40401"]){//收藏过了
                self.like = true;
                self.model.like = true;
                self.model.like_id = error;
            }
        }];
    }else{//取消收藏
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"like_id"] = model.like_id;
        [[ESWebService sharedWebService].flat deleteLikeParameter:dict success:^(id jsonData) {
            self.like = false;
            self.model.like = false;
        } failure:^(NSString *error,NSString *errorCode) {
            if ([errorCode isEqualToString:@"40004"]) {
                loginViewController *login = [[loginViewController alloc]init];
                [self.navigationController pushViewController:login animated:true];
            }
        }];
    }
}

-(void)setNav{
    //评论
    UIButton* comment = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [comment addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [comment setBackgroundImage:[UIImage imageNamed:@"home_icon_pinlun"] forState:UIControlStateNormal];
    
    //分享
    //    UIButton* share = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    //    [share addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [share setImage:[UIImage imageNamed:@"button_tianjia@3x"] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:comment]];
}

-(void)requestData{
    [MBProgressHUD showIndicatorMessage:@"加载中" toView:self.view];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"apartment_id"] = self.faltId;
    
    [[ESWebService sharedWebService].flat getFlatDetailWithParameter:dic success:^(id jsonData) {
        
        [MBProgressHUD hideHUDForView:self.view];
        XYFlatListModel *model = [XYFlatListModel yy_modelWithDictionary:jsonData];
        //处理配置
//        NSArray *fa = [XDCommonTool getSettingInfoWithKey:@"ptss"];
//        NSArray *fa1 = [fa getRelateInfoArrayWithArray:model.facility];
        model.facility =[XYToolCategory getInfoFormDict:self.settingInfo andPropertyKey:@"ptss" privateKeys:model.facility];
        //处理相关房型展开
        for (XYHourseTypeModel *type in model.apartment_types) {
            type.isOpen = false;
        }
        
        self.model =model;
    } failure:^(NSString *error,NSString *errorCode) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:error];
    }];
}

-(void)setModel:(XYFlatListModel *)model{
    _model = model;
    self.imagesData = [self detailImagesData:self.model];
    self.header.imagesArray = self.imagesData;
    self.header.title_imageUrl = model.title_image;
    self.like = model.like;
    self.dataArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5"]];
    [self.tableView reloadData];
}

-(NSMutableArray *)detailImagesData:(XYFlatListModel *)model{
    NSMutableArray *arr = [NSMutableArray array];
    if (model.full_shot_videos.count >0) {
        XYFlatListModelFullShotVideos *fMoves = model.full_shot_videos[0];
        XYImageModel *iModel = [XYImageModel new];
        iModel.isVideo = XYPhonesTypeFullVideos;
        iModel.des = fMoves.desc;
        iModel.url = fMoves.url;
        [arr addObject:iModel];
    }if (model.full_shot_images.count >0) {
        XYFlatListModelFullShotVideos *fMoves = model.full_shot_images[0];
        XYImageModel *iModel = [XYImageModel new];
        iModel.isVideo = XYPhonesTypeFullImage;
        iModel.url = fMoves.url;
        iModel.des = fMoves.desc;
        [arr addObject:iModel];
    }if (model.images.count>0) {
        for (XYFlatListModelImages *fMoves in model.images) {
            XYImageModel *iModel = [XYImageModel new];
            iModel.isVideo = XYPhonesTypeImage;
            iModel.des = fMoves.desc;
            iModel.url = fMoves.url;
            [arr addObject:iModel];
        }
    }
    
    //这才到真正的处理
    NSMutableArray *sectionArray = [NSMutableArray array];
    for (int i = 0; i<arr.count; i++) {
        XYImageModel *model = arr[i];
        if (model.isVideo == XYPhonesTypeImage) {
            [sectionArray addObject:model];
            //            [arr removeObject:model];
        }
    }
    
    NSMutableArray *last = [NSMutableArray array];
    NSArray *arrNew = [NSArray arrayWithArray:sectionArray];
    for (id objcG in arrNew) {
        XYImageModel *model2 = [XYImageModel new];
        for (id objc in sectionArray) {
            if (![objc isKindOfClass:[NSString class]]) {
                model2 = objc;
                break;
            }
        }
        NSMutableArray *arrq = [NSMutableArray array];
        [sectionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj isKindOfClass:[NSString class]]) {
                
                XYImageModel *model1 = obj;
                if ([model2.des isEqualToString:model1.des]) {
                    [arrq addObject:model1];
                    [sectionArray replaceObjectAtIndex:idx withObject:@"empty"];
                    //                [sectionArray removeObjectAtIndex:idx];
                }
            }
        }];
        if (arrq.count>0) {
            [last addObject:arrq];
        }
    }
    
    //添加全景视频或者图片
    NSMutableArray *arrat = last.firstObject;
    XYImageModel *image = arrat.lastObject;
    NSMutableArray *arrate = [NSMutableArray array];
    for (XYImageModel *model in arr) {
        if (model.isVideo == XYPhonesTypeFullImage ||model.isVideo == XYPhonesTypeFullVideos) {
            model.des = image.des;
            [arrate addObject:model];
        }
    }
    [arrat insertObjects:arrate atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, arrate.count)]];
    if (arrate.count >0 && last.count >0) {
        [last replaceObjectAtIndex:0 withObject:arrat];
    }else if (last.count == 0){
        [last addObject:arrate];
    }
    return last;
}

-(void)commentBtnClick:(UIButton *)sender{
//    LxDBAnyVar(@"评论");
    XYCommentTableVC *comment = [[XYCommentTableVC alloc]init];
    comment.commented = self.faltId;
    comment.hourseType = XYHourseTypeFlat;
    [self.navigationController pushViewController:comment animated:true];
}

//-(void)shareBtnClick:(UIButton *)sender{
//    LxDBAnyVar(@"分享");
//}

#pragma mark -- table delegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0://名字
        {
            XYHourseDetailNameTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYHourseDetailNameTBVCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return cell;
        }
            break;
        case 1://地图
        {
            XYHourseDetailMapTVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYHourseDetailMapTVCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            cell.mapTapBlock = ^(){
                XYMapViewController *map = [[XYMapViewController alloc]init];
                NSString *mapUrl = [NSString stringWithFormat:@"http://relay-hk.blinroom.com:8080/index.html?lat=%@&lng=%@",self.model.lat,self.model.lng];
                map.url = mapUrl;
                map.title = @"地图";
                [self.navigationController pushViewController:map animated:YES];
            };
            return cell;
        }
            break;
        case 2://房源描述
        {
            XYHourseDetailDesTVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYHourseDetailDesTVCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return cell;
        }
            break;
        case 3://设施
        {
            XYFacliltiesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYFacliltiesTableViewCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            cell.isOpen = self.facilityIsOpen; 
            @weakify(self);
            cell.moreBtnClickBlock =^(BOOL isOpen){
                @strongify(self);
                self.facilityIsOpen = isOpen;
                //                    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView reloadData];
            };
            return cell;
        }
            break;
        case 4://相关房型
        {
            XYHourseDetailTYpeTVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYHourseDetailTYpeTVCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //查看更多按钮点击
            cell.moreBtnClickBlock = ^(BOOL isOpen,NSInteger index){
                XYHourseTypeModel *type = self.model.apartment_types[index];
                type.isOpen = isOpen;
                [self.tableView reloadData];
            };
            
            //图片点击
            cell.imageClickBlock = ^(NSInteger index){
                XYHourseTypeModel *hourseType = self.model.apartment_types[index];
                [[XYFullScreenImagesDeawer sharedImageBrawer]showImageBrawerWithDataArray:@[hourseType.title_image] andCurrentIndex:0 andBegainRect:[self.view convertRect:self.tableView.tableHeaderView.frame toView:[UIApplication sharedApplication].keyWindow]];
                [[UIApplication sharedApplication].keyWindow addSubview:[XYFullScreenImagesDeawer sharedImageBrawer]];
            };
            //预定按钮点击
            cell.scheduleClickBlock = ^(NSInteger index){
                NSDictionary *dic = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
                if (!dic) {
                    loginViewController *login = [[loginViewController alloc]init];
                    [self.navigationController pushViewController:login animated:true];
                    return;
                }
                XYScheduleNoticeVC *schedule = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([XYScheduleNoticeVC class]) owner:nil options:nil][0];
                schedule.center = [UIApplication sharedApplication].keyWindow.center;
                XYSidePopView *side = [XYSidePopView initWithCustomView:schedule andBackgroundFrame:[UIApplication sharedApplication].keyWindow.frame andPopType:popTypeMid];
                
                //须知知道按钮点击
                schedule.knowBtnClick = ^(){
                    [side dismissplay];
                    XYScheduleOrderVC *order = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([XYScheduleOrderVC class]) owner:nil options:nil][0];
                    order.center = [UIApplication sharedApplication].keyWindow.center;
                    NSDictionary *info = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
                    if (USER_INFO) {
                        order.userInfo = info;
                    }
                    
                    XYSidePopView *side1 = [XYSidePopView initWithCustomView:order andBackgroundFrame:[UIApplication sharedApplication].keyWindow.frame andToView:self.view andPopType:popTypeMid];
                    [self.navigationController.view insertSubview:side1 aboveSubview:self.navigationController.navigationBar];
                    
                    side1.backgroundClickBlock = ^{
                        [order.nameTextField resignFirstResponder];
                        [order.qqTextField resignFirstResponder];
                        [order.emailTextField resignFirstResponder];
                        [order.phoneTextField resignFirstResponder];
                    };
                    
                    @weakify(order);
                    order.scheduleBtnClickBlock = ^(NSDictionary *dic){
                        @strongify(order);
                        XYHourseTypeModel *house = self.model.apartment_types[index];
                        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                        dict[@"commodity_id"] = @([house.hourseId intValue]);
                        dict[@"type"]  = @1;
                        dict[@"phone"] = dic[@"phone"];
                        dict[@"email"] = dic[@"email"];
                        dict[@"name"]  = dic[@"name"];
                        dict[@"sex"]   = dic[@"sex"];
                        dict[@"qq"]    = dic[@"qq"];
                        [MBProgressHUD showIndicatorMessage:@"预定中" toView:order];
                        [[ESWebService sharedWebService].flat addConsultWithParameter:dict success:^(id jsonData) {
                            [MBProgressHUD hideHUDForView:order];
                            [MBProgressHUD showSuccess:@"预订成功"];
                            [side1 dismissplay];
                        } failure:^(NSString *error, NSString *errorCode) {
                            [MBProgressHUD hideHUDForView:order];
                            [MBProgressHUD showError:error];
                            if ([errorCode isEqualToString:@"40004"]) {
                                loginViewController *login = [[loginViewController alloc]init];
                                [self.navigationController pushViewController:login animated:true];
                            }
                        }];
                    };
                    
                };
            };
            cell.settingInfo = self.settingInfo;
            
            cell.model =self.model;
            return cell;
        }
            break;
            //        case 5://公寓商
            //            {
            //                XYSupplyerAboutTVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYSupplyerAboutTVCell class])];
            //                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //                cell.model = self.model;
            //                return cell;
            //            }
            //            break;
        default:
            break;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 53;
    }else if (indexPath.row == 1) {
        return 220 +5;
    }else if (indexPath.row == 2){
        if (IOSVersion <10.3) {
        
            return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([XYHourseDetailDesTVCell class]) configuration:^(XYHourseDetailDesTVCell *cell) {
                cell.model = self.model;
            }] ;
        }else{
            static UILabel *stringLabel = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{//生成一个同于计算文本高度的label
                stringLabel = [[UILabel alloc] init];
                stringLabel.numberOfLines = 0;
            });
            stringLabel.font = [UIFont systemFontOfSize:13];
            stringLabel.text = self.model.intro_zh;
//            stringLabel.attributedText = GetAttributedText(string);
            return [stringLabel sizeThatFits:CGSizeMake(SCREEN_MAIN.width -30, MAXFLOAT)].height +60;
        }
    }else if (indexPath.row == 3){
        CGFloat cellHeight = 0;
        CGFloat itemWidth = (SCREEN_MAIN.width -63/2.0 *2 * SCREEN_MAIN.width/414.0 -128/2.0*3 *SCREEN_MAIN.width/414.0)/4;
        NSInteger lines =self.model.facility.count/4 +(self.model.facility.count%4 == 0 ?0:1);
        if (self.model.facility.count > 0) {
            if (self.model.facility.count <= 6) {//实高不加按钮
                cellHeight = lines *(itemWidth +30) + (lines -1)*10 +60;
            }else if(!self.facilityIsOpen){//两行高加按钮
                cellHeight = 2 *(itemWidth +30) + 10 +60 +27;
            }else{//实高加按钮
                cellHeight = lines *(itemWidth +30) + (lines -1)*10 +60 +27;
            }
        }else{
            
        }
        return cellHeight;
    }else{
//        return self.model.apartment_types.count *199 + 38;
        XYHourseDetailTYpeTVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYHourseDetailTYpeTVCell class])];
        cell.model =self.model;
        return cell.tableView.contentSize.height + 37;
    }
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [[SDWebImageManager sharedManager] cancelAll];
    
    [[SDImageCache sharedImageCache] clearDisk];
}


#pragma mark -- scrollviewDelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView == self.tableView) {
//        CGFloat x = scrollView.contentOffset.y;
//        if (x >= 0) {
//            self.navigationController.navigationBar.backgroundColor = [UIColor colorWithWhite:1 alpha:x/150.0f];
//        }
//    }
//}


@end
