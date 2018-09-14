//
//  XYCommentTableVC.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/24.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYCommentTableVC.h"
#import "XYCommentTableViewCell.h"
#import "XYCommentModel.h"
#import "XYFullScreenImagesDeawer.h"
#import "XYPublishCommentVC.h"
#import "XYSidePopView.h"
#import "XYCommentCollectionCell.h"
#import "XYPublishCommentVCG.h"

@interface XYCommentTableVC ()<UITableViewDelegate,UITableViewDataSource,TDAlertViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UIButton *statusBtn;
@property (nonatomic,assign)XYUploadingStatus uploadStatus;
@end

@implementation XYCommentTableVC
{
    NSInteger _indexPage;
    NSInteger _commentId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [UILabel navigationTitleLabelWithText:@"评论"];
    [self.view addSubview:self.tableView];
    _indexPage = 1;
    [self.tableView.mj_header beginRefreshing];
    [self creatRightItem];
    self.uploadStatus = XYUploadingStatusEmpty;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(statusApprence:) name:STATUS_APPRENCE object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0f];/// 这句设置是为了不影响子图层的透明度
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

-(void)statusApprence:(NSNotification *)objc{
    NSDictionary *dict = objc.object;
    NSInteger status = [dict[@"status"] integerValue];
    self.uploadStatus = status;
}

-(UIButton *)statusBtn{
    if (!_statusBtn) {
        _statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _statusBtn.frame = CGRectMake(0, 44, SCREEN_MAIN.width, 20);
        _statusBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_statusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_statusBtn setBackgroundColor:[[UIColor colorWithHex:0x29a7e1] colorWithAlphaComponent:0.7f]];
    }
    return _statusBtn;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_MAIN.width, SCREEN_MAIN.height - 64) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHex:0xf0f0f0];
        
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _indexPage = 1;
            [self requestData:1];
        }];
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _indexPage ++;
            [self requestData:_indexPage];
        }];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYCommentTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYCommentTableViewCell class])];
        
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)setUploadStatus:(XYUploadingStatus)uploadStatus{
    _uploadStatus = uploadStatus;
    switch (uploadStatus) {
        case XYUploadingStatusEmpty:
            {
                [UIView animateWithDuration:0.3f animations:^{
                    self.statusBtn.frame = CGRectMake(0, 44, SCREEN_MAIN.width, 20);
                    [self.statusBtn setTitle:@"" forState:UIControlStateNormal];
                } completion:^(BOOL finished) {
                    
                }];
            }
            break;
        case XYUploadingStatusUploading:
            {
                [self.tableView setContentOffset:CGPointMake(0, 0) animated:true];
                [UIView animateWithDuration:0.3f animations:^{
                    self.statusBtn.frame = CGRectMake(0, 64, SCREEN_MAIN.width, 20);
                    [self.statusBtn setTitle:@"发送中......" forState:UIControlStateNormal];
                } completion:^(BOOL finished) {
                    
                }];
            }
            break;
        case XYUploadingStatusSuccess:
            {
                [UIView animateWithDuration:0.3f animations:^{
                    self.statusBtn.frame = CGRectMake(0, 64, SCREEN_MAIN.width, 20);
                    [self.statusBtn setTitle:@"发送成功" forState:UIControlStateNormal];
                } completion:^(BOOL finished) {
                    double delayTime = 0.7f;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [UIView animateWithDuration:0.3f animations:^{
                            self.statusBtn.frame = CGRectMake(0, 44, SCREEN_MAIN.width, 20);
                        } completion:^(BOOL finished) {
                            _indexPage = 1;
                            [self requestData:_indexPage];
                        }];
                    });
                }];
            }
            break;
        case XYUploadingStatusFailed:
            {
                [UIView animateWithDuration:0.3f animations:^{
                    self.statusBtn.frame = CGRectMake(0, 64, SCREEN_MAIN.width, 20);
                    [self.statusBtn setTitle:@"发送失败" forState:UIControlStateNormal];
                } completion:^(BOOL finished) {
                    double delayTime = 0.7f;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [UIView animateWithDuration:0.3f animations:^{
                            self.statusBtn.frame = CGRectMake(0, 44, SCREEN_MAIN.width, 20);
                        }];
                    });
                }];
            }
            break;
        default:
            break;
    }
}

-(void)requestData:(NSInteger)page{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"commented"] = self.commented;
    dict[@"type"] = @(self.hourseType);
    dict[@"page_size"] = @(20);
    if (page == 1) {
        dict[@"after_date"] = @"";
    }else{
        if (self.dataArray.count>0) {
            XYCommentModel *model = self.dataArray.lastObject;
            dict[@"after_date"] = model.created_time;
        }else{
            dict[@"after_date"] = @"";
        }
    }
    dict[@"page_no"] = @(page);
    [[ESWebService sharedWebService].flat getCommentListWithParameter:dict success:^(id jsonData) {
        if (page == 1) {
            [self.dataArray removeAllObjects];
        }
        for (NSDictionary *dic in jsonData) {
            XYCommentModel *model = [XYCommentModel yy_modelWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSString *error,NSString *errorCode) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD showError:error];
    }];
}

-(void)creatRightItem{
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.titleLabel.font = [UIFont systemFontOfSize:15];
    [bu setTitle:@"发表" forState:UIControlStateNormal];
    [bu setTitleColor:[UIColor colorWithHex:0x29a7e1] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    bu.frame = CGRectMake(0, 0, 40, 50);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:bu];
    
    [self.view addSubview:self.statusBtn];
    [self.view bringSubviewToFront:self.statusBtn];
}

-(void)rightItemClick:(UIButton *)sender{
    
//    XYPublishCommentVC *publish = [[XYPublishCommentVC alloc]init];
//    publish.commentedId = self.commented;
//    publish.hourseType = self.hourseType;
//    [self.navigationController pushViewController:publish animated:YES];
    
    XYPublishCommentVCG *publish = [[XYPublishCommentVCG alloc]init];
    publish.commentedId = self.commented;
    publish.hourseType = self.hourseType;
    [self.navigationController pushViewController:publish animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYCommentModel *model = self.dataArray[indexPath.row];
    CGFloat width = (SCREEN_MAIN.width - 83 -44 -10)/3.0f ;
    NSInteger lines = model.images.count/3 + (model.images.count %3 == 0?0:1) ;
//    CGFloat height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([XYCommentTableViewCell class]) configuration:^(XYCommentTableViewCell * cell) {
//        cell.model =model;
//    }];
//    +lines *width +5*(lines - 1) -((model.content.length>0 && model.content)?12:27);
//    if (height >= 142) {
//        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([XYCommentTableViewCell class]) configuration:^(XYCommentTableViewCell * cell) {
//            cell.model =model;
//        }] +lines *width +5*(lines - 1) -((model.content.length>0 && model.content)?12:27);
//        return height;
//    return 250;
//    }else{
//        return 142;
//    }
    XYCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYCommentTableViewCell class])];
    cell.model = model;
    
    CGSize size = [cell.desLabel sizeThatFits:CGSizeMake(SCREEN_MAIN.width - 85 -44, 999)];
    
    NSDictionary *dict = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
    BOOL haveDelete = [[NSString stringWithFormat:@"%ld",[dict[@"id"] integerValue]] isEqualToString:model.comment]?true:false;
    
    if ((model.content && model.content.length >0) &&(!model.images || model.images.count == 0)) {//有文字没图片
        //65+文字高+5+23 +10
        CGFloat height = 65 +size.height + (haveDelete?(5+23):0) +10;
        return height >142 ?height :142;
    }else if ((!model.content || model.content.length == 0) && (model.images && model.images.count >0)){//有图没文字
        //65+图片高+5+23 +10
        return 65+lines *width +5*(lines - 1) +(haveDelete?(5+23):0) +10;
    }else{//有图有文字
        //65+文字高+10+图片高+5+23 +10
        return 65 +size.height +10 +lines *width +5*(lines - 1) +(haveDelete?(5+23):0) +10;
    }
//    return size.height +65;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYCommentTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    XYCommentModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    @weakify(cell);
    
    cell.deleteBtnCLickBlock = ^(){//删除评论
        _commentId = [model.commentId integerValue];
        //提示是否删除
        
        TDAlertItem *item1 = [[TDAlertItem alloc] initWithTitle:@"取消"];
        TDAlertItem *item2 = [[TDAlertItem alloc] initWithTitle:@"确定"];
        item2.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
        item2.titleColor = [UIColor colorWithHexString:@"fffefe"];
        TDAlertView *alert = [[TDAlertView alloc] initWithTitle:@"删除评论" message:@"确定要删除该条评论吗？" items:@[item1,item2] delegate:self];
        alert.hideWhenTouchBackground = NO;
        
        [alert show];
    };
    
    cell.imageClickBlock1 = ^(NSInteger index,CGRect rect){
        @strongify(cell);
        
        [XYFullScreenImagesDeawer sharedImageBrawer].titlesArray =nil;
        [[XYFullScreenImagesDeawer sharedImageBrawer]showImageBrawerWithDataArray:model.images andCurrentIndex:index andBegainRect:[cell.contentView convertRect:rect toView:[UIApplication sharedApplication].keyWindow]];
        [[UIApplication sharedApplication].keyWindow addSubview:[XYFullScreenImagesDeawer sharedImageBrawer]];
        [XYFullScreenImagesDeawer sharedImageBrawer].getScrollViewIndexBlock = ^(NSInteger index){
            //根据下标找到图片在当前屏幕上的坐标
            CGRect rect1 = [cell.picsCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]].frame;
            CGRect rect5 = [cell.picsCollectionView convertRect:rect1 toView:[UIApplication sharedApplication].keyWindow];
            [XYFullScreenImagesDeawer sharedImageBrawer].rect = rect5;
        };
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

-(void)alertView:(TDAlertView *)alertView didClickItemWithIndex:(NSInteger)itemIndex{
    if (itemIndex == 0) {
        return;
    }else if (itemIndex == 1){
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"comment_id"] = [NSString stringWithFormat:@"%ld",_commentId];
        [[ESWebService sharedWebService].flat delCommentWithParameter:dict success:^(id jsonData) {
//            LxDBAnyVar(jsonData);
            [self refreshTableView];
        } failure:^(NSString *error, NSString *errorCode) {
            [MBProgressHUD showError:@"删除评论失败"];
        }];
    }
}

-(void)refreshTableView{
    for (XYCommentModel *model in self.dataArray) {
        if ([model.commentId integerValue] == _commentId) {
            [self.dataArray removeObject:model];
            break;
        }
    }
    
    if (self.dataArray.count >= 10) {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]withRowAnimation:UITableViewRowAnimationFade];
    }else{
        [self requestData:1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
