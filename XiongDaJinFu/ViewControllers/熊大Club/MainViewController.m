//
//  MainViewController.m
//  XiongDaJinFu

//  Created by room Blin on 2017/3/7.
//  Copyright © 2017年 digirun. All rights reserved.
//


#import "MainViewController.h"
#import "CollectionViewController.h"
#import "MYSegmentView.h"
#import "MHHeaderView.h"
#import "AccountManagerTableViewController.h"
#import "MHUserInfoTableViewController.h"
#import "loginViewController.h"
#import "peopleTableViewCell.h"
#import "peopleModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "OrderViewController.h"
#import "unLoginTableViewCell.h"
#import "registerViewController.h"
#define headViewH    SCREENWIDTH/3*2
#define headH        SCREENWIDTH/4
static CGFloat const headViewHeight = 256/2;

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,unLoginDelegate,CActionSheetDelegate,PhotoPickDelegate,UIActionSheetDelegate>

@property(nonatomic ,strong)UITableView * mainTableView;
@property (nonatomic, strong) MYSegmentView * RCSegView;


@property(nonatomic,strong)UIImageView *headImageView;//头部图片
@property(nonatomic,strong)UIView *BGView;//头部图片背景

@property(nonatomic,strong)UIButton *settingBtn;//设置
@property(nonatomic,strong)UIButton *editBtn;//编辑


@property(nonatomic,strong)  MHHeaderView  * headerView;


@property(nonatomic,strong)  peopleModel  * peopleModel1;


@property(nonatomic, strong)UIView *tableViewHeaderView;


@property (nonatomic, assign) BOOL canScroll;


@end

@implementation MainViewController
@synthesize mainTableView;

-(UIImageView*)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.userInteractionEnabled=YES;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.layer.cornerRadius = 43;

        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        //描边

        _iconImageView.layer.borderWidth = 2;
        _iconImageView.layer.borderColor =[[UIColor whiteColor] CGColor];
        
    }
    
    return _iconImageView;
    
}

-(void)viewWillAppear:(BOOL)animated{

    [self getUserInfo];

}

-(void)viewDidAppear:(BOOL)animated{
   
    [super viewDidAppear:animated];

    [self.view addSubview:self.editBtn];
    [self.view addSubview:self.settingBtn];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewInfo) name:LOGINOUT_SUCCESS object:nil];

   if (self.mainTableView.contentOffset.y>0) {
        [self.navigationController.navigationBar setHidden:NO] ;
        [self.navigationController.navigationBar setAlpha:1];
       
       UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.settingBtn];
       self.navigationItem.leftBarButtonItem = leftItem;
       
       UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.editBtn];
       self.navigationItem.rightBarButtonItem = rightItem;
    }

}
-(void)getNewInfo{
    [self.mainTableView reloadData];

}
-(void)viewWillDisaprpear:(BOOL)animated{
}
-(void)updateMessage{
    [self getUserInfo];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMessage) name:REGISTERSAVEMESSAGE object:nil];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableView registerClass:[peopleTableViewCell class] forCellReuseIdentifier:@"Identifier"];
    [self.mainTableView registerClass:[unLoginTableViewCell class] forCellReuseIdentifier:@"unLoginTableViewCellIdentifier"];
    self.mainTableView.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];

    [self.view addSubview:self.mainTableView];

    [self createTableViewHeaderView];
    [self.mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([peopleTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([peopleTableViewCell class])];
}

-(void)createTableViewHeaderView{

    _tableViewHeaderView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, SCREENWIDTH, 165))];
    [_tableViewHeaderView addSubview:self.headImageView];
    [_tableViewHeaderView addSubview:self.BGView];

    [_tableViewHeaderView addSubview:self.iconImageView];

    //添加手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeIcon)];//响应方法没写
    self.iconImageView.userInteractionEnabled=YES;   ///必须设置用户交互，手势才有用
    [self.iconImageView addGestureRecognizer:tap];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableViewHeaderView.mas_bottom).offset(-43);
        make.centerX.equalTo(_tableViewHeaderView.mas_centerX);
        make.width.equalTo(@86);
        make.height.equalTo(@86);
        
    }];

   
    
    self.mainTableView.tableHeaderView = self.tableViewHeaderView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = self.view.frame.size.width; // 图片宽度
    CGFloat yOffset = scrollView.contentOffset.y;  // 偏移的y值
   if (yOffset <= 0) {
       
      // [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];

       [self.navigationController.navigationBar setAlpha:0];
      
       CGFloat totalOffset = 165 + ABS(yOffset);
        CGFloat f = totalOffset / 165;
        self.headImageView.frame =  CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset); //拉伸后的图片的frame应该是同比例缩放。
        self.BGView.frame =  CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset); //拉伸后的图片的frame应该是同比例缩放。
        
        
       [self.settingBtn setImage:[UIImage imageNamed:@"icon_shezhi"] forState:UIControlStateNormal];
       [self.editBtn setImage:[UIImage imageNamed:@"icon_bianji"] forState:UIControlStateNormal];
        self.editBtn.frame = CGRectMake(SCREENWIDTH- 15-20, 30, 40/2+10, 43/2);
        self.settingBtn.frame = CGRectMake(15, 30, 23+10, 21);

        [self.view addSubview:_settingBtn];
        [self.view addSubview:_editBtn];

            }

    else{
        
       [self.navigationController.navigationBar setHidden:NO];
        //self.navigationController.navigationBar.alpha = 1;
        //导航栏的渐变效果
        self.navigationController.navigationBar.alpha = fabs(yOffset / 64) ;

        [self.settingBtn setImage:[UIImage imageNamed:@"icon_shezhi_black"] forState:UIControlStateNormal];
        [self.editBtn setImage:[UIImage imageNamed:@"icon_bianji_black"] forState:UIControlStateNormal];

        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.settingBtn];
        self.navigationItem.leftBarButtonItem = leftItem;
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.editBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    //禁用最外层额滑动效果
    if (yOffset>=260) {
      [[NSNotificationCenter defaultCenter] postNotificationName:kGoTopNotificationName object:nil userInfo:@{@"canScroll":@"1"}];
    }
    else{
     [[NSNotificationCenter defaultCenter] postNotificationName:kLeaveTopNotificationName object:nil userInfo:nil];
        self.mainTableView.scrollEnabled = YES;

    }

}
-(UIView*)BGView{

    if (_BGView==nil) {
        _BGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 ,SCREENWIDTH,165)];
        _BGView.backgroundColor = [UIColor blackColor];
        _BGView.alpha= 0.3;
    }
    return _BGView;
}
-(UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"peopleBg"]];
        _headImageView.frame=CGRectMake(0, 0 ,SCREENWIDTH,165);
        _headImageView.userInteractionEnabled = YES;
        _headImageView.contentMode = UIViewContentModeScaleToFill;
        _headImageView.clipsToBounds = YES;
       // _editBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom frame:CGRectMake(SCREENWIDTH- 15-20, 30, 40/2, 43/2) normalImage:@"icon_bianji" buttonTitle:@"   " target:self action:@selector(editMessage)];
       
        _editBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"icon_bianji" buttonTitle:nil target:self action:@selector(editMessage)];
        _editBtn.frame = CGRectMake(SCREENWIDTH- 15-20, 30, 40/2+20, 43/2);

        [_editBtn setTitle:@"        " forState:UIControlStateNormal];

        
        
        [self.headImageView addSubview:_editBtn];
        //_settingBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom frame:CGRectMake(15, 30, 23, 21) normalImage:@"icon_shezhi" buttonTitle:@"     " target:self action:@selector(setting)];
        _settingBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"icon_shezhi" buttonTitle:nil target:self action:@selector(setting)];
        _settingBtn.frame = CGRectMake(15, 30, 23+40, 21);
        
        [_settingBtn setTitle:@"    " forState:UIControlStateNormal];

        [self.headImageView addSubview:_settingBtn];
    }
    return _headImageView;
}


-(UITableView *)mainTableView
{
    if (mainTableView == nil)
    {
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        // mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0);
        mainTableView.delegate=self;
        mainTableView.dataSource=self;
        mainTableView.showsVerticalScrollIndicator = YES;
        //mainTableView.tableFooterView= [UIView new];
        [mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([peopleTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([peopleTableViewCell class])];
    
    }
    return mainTableView;
}

#pragma marl -tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==0) {
        if ([XDCommonTool readBoolFromUserDefaultWithKey:IS_LOGIN]) {
           return  [tableView fd_heightForCellWithIdentifier:NSStringFromClass([peopleTableViewCell class]) configuration:^(peopleTableViewCell * cell) {
                cell.peopleModel = self.peopleModel1;
            }];
        }
        else{
           
            
            return 120;
        }
   
    }
    else{
    return SCREENHEIGHT-40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.row==0) {
        
                if ([XDCommonTool readBoolFromUserDefaultWithKey:IS_LOGIN]) {
            
//                     peopleTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier" forIndexPath:indexPath];
//                    cell.peopleModel = self.peopleModel1;
//                    
//                    return cell;
                    
                    peopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([peopleTableViewCell class])];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.peopleModel = self.peopleModel1;
                    return cell;
                }
          {
        
           
              unLoginTableViewCell  * cell1 = [tableView dequeueReusableCellWithIdentifier:@"unLoginTableViewCellIdentifier" forIndexPath:indexPath];
              cell1.selectionStyle = UITableViewCellSelectionStyleNone;
              cell1.delegate = self;
              return cell1;

        }
        
    }
    
  
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //添加pageView
    [cell.contentView addSubview:self.setPageViewControllers];
    
    return cell;
    
}

/* 
 * 这里可以任意替换你喜欢的pageView
 */
-(UIView *)setPageViewControllers
{
    if (!_RCSegView) {
        
        CollectionViewController * collectionVC=[[CollectionViewController alloc]init];
        OrderViewController * orderVC=[[OrderViewController alloc]init];
         NSArray *controllers=@[collectionVC,orderVC];
         NSArray *titleArray =@[@"收藏房源",@"我的订单"];
        MYSegmentView * rcs=[[MYSegmentView alloc]initWithFrame:CGRectMake(0, 10, SCREENWIDTH, SCREENHEIGHT-64) controllers:controllers titleArray:titleArray ParentController:self lineWidth:SCREENWIDTH/2 lineHeight:1];
        _RCSegView = rcs;
    }
    return _RCSegView;
}
- (void)setting{

    [self.navigationController pushViewController:[AccountManagerTableViewController new] animated:YES];

}
-(void)editMessage{
    if (![XDCommonTool readBoolFromUserDefaultWithKey:IS_LOGIN]) {
        [self.navigationController pushViewController:[loginViewController new] animated:YES];

      }
     else{
    [self.navigationController pushViewController:[MHUserInfoTableViewController new] animated:YES];

   }
}
-(void)getUserInfo{
    NSString  * idStr = [[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO] objectForKey:@"id"];
    
    NSDictionary  * userDict = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
    LRLog(@"%@",userDict);
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userDict[@"icon"]]]placeholderImage:[UIImage imageNamed:@"126E88607D8808A0FBD6DF6133EF0F39"]];
    [[NetworkClient sharedClient] POST:[NSString stringWithFormat:@"%@/%@",URL_USERINFO,idStr] dict:nil succeed:^(id data) {
        [_tableViewHeaderView addSubview:self.iconImageView];
        LRLog(@"dasdasda%@",data);
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [XDCommonTool saveToUserDefaultWithDic:[data objectForKey:@"result"] key:USER_INFO];
            NSDictionary  * userDict = [data objectForKey:@"result"];
            peopleModel  * pM= [peopleModel yy_modelWithDictionary:userDict];
            self.peopleModel1 = pM;
            [mainTableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];

}
# pragma mark -
# pragma mark unLoginDelegate
-(void)didSelectWithBtnTag:(NSUInteger)tag{

    if (tag ==10001) {
        [self.navigationController pushViewController:[registerViewController new] animated:YES];
    }
    else{
    [self.navigationController pushViewController:[loginViewController new] animated:YES];
    }


}
-(void)changeIcon{

    
    //在这里呼出下方菜单按钮项
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:nil
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];
    
 }
#pragma mark- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex)
    {
        case 0:
        {
            PhotoManager * PhManager =[PhotoManager shareInstance];
            PhManager.delegate = self;
            [PhManager showCameraPicker:self];

        }
            //打开照相机拍照
            break;
            
        case 1:  //打开本地相册
        {
        
            PhotoManager * PhManager =[PhotoManager shareInstance];
            PhManager.delegate = self;
            [PhManager showNormalPicker:self];
        }
            
            
            break;
    }
}
#pragma mark PhotoPickDelegate
- (void)imagePicker:(UIImage *)image{
    self.iconImageView.image = image;
    [[ESWebService sharedWebService].flat uploadImagesToQiNiuWithParameter:@[image] type:XYUploadFileTypeAvatar progress:^(NSString *key, float percent) {
      LRLog(@"上传的进度为%f",percent);
  } success:^(id jsonData) {
      LRLog(@"上传的%@",jsonData);
      NSArray  * iocnArr = jsonData;
      [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iocnArr.firstObject] placeholderImage:[UIImage imageNamed:@"126E88607D8808A0FBD6DF6133EF0F39"]];
      NSDictionary  * userDict =   [XDCommonTool
                                    readDicFromUserDefaultWithKey:@"userInfo"];
      
      NSDictionary  * dict1 = @{@"client_id":[userDict objectForKey:@"id"],@"icon":iocnArr.firstObject};
      [[NetworkClient sharedClient] POST:URL_UPDATEINFO dict:dict1 succeed:^(id data) {
          LRLog(@"更改信息%@",data);
          if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
              //[self showHint:@"保存成功"];
          }else{
              
              
          }
          
      } failure:^(NSError *error) {
          LRLog(@"更改信息%@",error);
          
      }];
    } failure:^(NSString *error, NSString *errorCode) {
      
  }];
}
@end
