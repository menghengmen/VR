
//
//  YJTopicController.m
//  WalkTogether2
//
//  Created by boding on 15/7/29.
//  Copyright (c) 2015年 GYJ. All rights reserved.
//

#import "MHCommentViewController.h"
#import "YJTopicCell.h"

#import "UITableView+FDTemplateLayoutCell.h"
#import "SDPhotoBrowser.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "YJTopicPublish.h"
#define  kPageSizeTopic 10

@interface MHCommentViewController ()<YJTopicCellDelegate,UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, SDPhotoBrowserDelegate>
//最外层的大数组
@property (nonatomic,strong)NSMutableArray *dataArray;

//动态内容数组
@property (nonatomic,strong)NSMutableArray *conyentArray;

//动态的用户数组
@property (nonatomic,strong)NSMutableArray *userArray;

@property (nonatomic, strong) NSMutableDictionary  *parameters;

@property (nonatomic, strong) NSIndexPath *selectedCellIndexPath;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,strong)id model;
//@property (nonatomic)TopicType topicType;
@property (nonatomic,copy)NSString *urlString;


@end

@implementation MHCommentViewController
{
    NSInteger  _currentpage;
    NSInteger  _allCount;
    NSInteger  _totalRow;
}
-(NSMutableDictionary *)parameters
{
    if (!_parameters) {
        _parameters = [NSMutableDictionary dictionary];
    }
    return _parameters;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self setUpNewNai:@"返回" Title:@"动态"];
    [self setUpUI];
    [self getData];
    [self headerRefresh];
    
}

- (void)setUpUI{

    //返回按钮
    UIButton  * rightBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"icon_nav_back" buttonTitle:@"发表" target:self action:@selector(publish)];
    [self.view addSubview:rightBtn];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@45);
        make.height.equalTo(@19);
        make.right.and.equalTo(rightBtn.superview).offset(-10);
        make.top.equalTo(rightBtn.superview).offset(35);
    }];



}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加右滑返回功能
    _currentpage = 1;
    [self.parameters  setObject:[NSString stringWithFormat:@"%d",kPageSizeTopic] forKey:@"ps"];
    
    [self setupUI];
    
}


-(void)setupUI
{
    
    
    
    
    
    CGRect frame = self.view.frame;
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 40, frame.size.width, frame.size.height -64) style:UITableViewStyleGrouped];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"YJTopicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YJTopicCell"];
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 8;
    [self.view addSubview:self.tableView];
    
    //[self addRefresh];
    
}
- (void)push{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -添加刷新
/*
 -(void)addRefresh{
 __weak typeof(self) weakSelf = self;
 self.tableView.header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
 _currentpage = 1;
 [weakSelf headerRefresh];
 ;
 [weakSelf.tableView.footer resetNoMoreData];
 
 }];
 self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
 
 if (_currentpage < (_totalRow+kPageSizeTopic-1)/ kPageSizeTopic) {
 _currentpage ++;
 [weakSelf footRefresh];
 }else {
 
 [weakSelf.tableView.footer noticeNoMoreData];
 }
 
 }];
 
 
 
 }
 */
-(void)headerRefresh
{
    [self.parameters setObject:[NSString stringWithFormat:@"%ld",(long)_currentpage] forKey:@"pn"];
    //    [self getOutingList];
    [self.tableView.header endRefreshing];
    
    [self.dataArray removeAllObjects];
    [self getData];
    
}
-(void)footRefresh
{
    [self.tableView.footer endRefreshing];
    
    [self.parameters setObject:[NSString stringWithFormat:@"%ld",(long)_currentpage] forKey:@"pn"];
    [self getData];
    
}

- (void)pushPublish
{
    //    if (![YJTool isLogin]) {
    //        [YJTool showMessage:@"未登录" inView:self.view];
    //        return;
    //    }
    
    //    YJTopicPublish *publish = [[YJTopicPublish alloc]initWithTopicType:_topicType Model:_model];
    //    [self.navigationController pushViewController:publish animated:YES];
    
}
- (void)backToHome
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray*)conyentArray{
    
    if (!_conyentArray) {
        _conyentArray = [NSMutableArray new];
    }
    
    return _conyentArray;
    
}

- (NSMutableArray*)userArray{
    
    if (!_userArray) {
        _userArray = [NSMutableArray new];
    }
    return _userArray;
    
}





-(void)getData
{
    
    
    
    //    if (!_model) {
    //        return;
    //    }
    __weak typeof(self) weakSelf = self;
    
    
    [[NetworkClient sharedClient] GET:@"http://api.kuaikanmanhua.com/v1/feeds/feed_lists?catalog_type=2&page_num=1&since=0&uid=0" dict:nil succeed:^(id data) {
        NSLog(@"朋友圈的数据为%@",data);
        
        
        NSArray  * arr = data[@"data"][@"feeds"];
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MHTopicModel  * model  = [MHTopicModel mj_objectWithKeyValues:(NSDictionary*)obj];
            
            MHContentModel   * contentModel = [MHContentModel mj_objectWithKeyValues:model.content];
            
            MHUserModel   * userModel = [MHUserModel mj_objectWithKeyValues:model.user];
            
            
           
            
            
            [self.dataArray addObject:model];
            
            [self.conyentArray addObject:contentModel];
            
            [self.userArray addObject:userModel];
            
        }];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}


#pragma mark -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJTopicCell *cell = (YJTopicCell *)[tableView dequeueReusableCellWithIdentifier:@"YJTopicCell" forIndexPath:indexPath];
    cell.topic = self.dataArray[indexPath.section];
    cell.contentTopic = self.conyentArray[indexPath.section];
    cell.userModel = self.userArray [indexPath.section];
    
    
    
    
    [self configureCell:cell atIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate =self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -UITableViewDataSource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    YJCommentController *comment = [[YJCommentController  alloc]init];
    //    comment.topic = self.dataArray[indexPath.section];
    //    [self.navigationController pushViewController:comment animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"YJTopicCell" configuration:^(YJTopicCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}


- (void)configureCell:(YJTopicCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    
    cell.topic = self.dataArray[indexPath.section];
    cell.contentTopic = self.conyentArray[indexPath.section];
    
}


#pragma mark - YJTopicCellDelegate
- (void)topicCell:(YJTopicCell *)topicCell didSelectLable:(NSUInteger)label isPraise:(BOOL)isPraise indexPath:(NSIndexPath *)indexPath
{
    self.selectedCellIndexPath = indexPath;
    __weak MHTopicModel *topic = self.dataArray[indexPath.row];
    
    switch (label) {
        case 0:
        {
            //举报
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles:nil, nil]
            ;
            [actionSheet showInView:self.view];
            
        }
            break;
        case 1:
        {
            //            //点赞
            //            if ([topic.ispraised integerValue]>0) {
            //                //[self showHint:@"你已点赞"];
            //                return;
            //            }
        }
            break;
        case 2:
        {
            //            YJCommentController *comment = [[YJCommentController  alloc]init];
            //            comment.topic = self.dataArray[indexPath.section];
            //            [self.navigationController pushViewController:comment animated:YES];
            //评论
        }
            break;
        case 3:
        case 4:
        case 5:
        {
            SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
            browser.currentImageIndex = label - 3;
            MHContentModel *topic =  (MHContentModel *)self.conyentArray[indexPath.section];
            browser.imageCount = topic.images.count;
            browser.sourceImagesContainerView = topicCell.imgPanelView;
            browser.delegate = self;
            [browser show];
        }
            break;
        default:
            break;
    }
}

#pragma mark -SDPhotoBrowserDelegate
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    YJTopicCell *cell = (YJTopicCell *)[self.tableView cellForRowAtIndexPath:self.selectedCellIndexPath];
    UIImageView *imageView = nil;
    if (index >= 3) {
        imageView = cell.imageViewArr[2];
    }
    else
    {
        imageView = cell.imageViewArr[index];
    }
    
    return imageView.image;
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    //YJTopic *topic = self.dataArray[self.selectedCellIndexPath.section];
    // NSString *imgUrlStr = topic.imageArr[index];
    // return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",globalImgURl,imgUrlStr]];
    return nil;
    
}


# pragma mark -
# pragma mark 发表动态
- (void)publish{

    [self.navigationController pushViewController:[YJTopicPublish new] animated:YES];

}



#pragma mark -UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    // 0 举报  1 取消
}

@end
