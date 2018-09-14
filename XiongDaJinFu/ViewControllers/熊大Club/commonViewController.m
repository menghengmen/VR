//
//  commonViewController.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/7.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "commonViewController.h"
#import "MyAccountViewController.h"
#import "CollectionViewController.h"
#import "UIView+Extension.h"
#import "selectHeaderView.h"
#import "loginViewController.h"
//#import "registerViewController.h"
#import "peopleHeadView.h"
#import "AccountManagerTableViewController.h"
#import "MHUserInfoTableViewController.h"
#import "MYSegmentView.h"
#define ICON_COUNT 2
#define Home_Seleted_Item_W 100

@interface commonViewController()<UIScrollViewDelegate,peopleHeadViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, weak) MyAccountViewController *accountVc;
@property(nonatomic, weak) CollectionViewController *colectionVc;
/** UIScrollView */
@property(nonatomic, weak) UIScrollView *scrollView;

@property(nonatomic, weak) selectHeaderView *selectHead;


@property(nonatomic,strong)  NSMutableArray  * titileArr;


@property(nonatomic,strong)  peopleHeadView  * peopleHeadView;

@property(nonatomic,strong)  NSArray  * labelArr;

//总的表格
@property(nonatomic ,strong)UITableView * mainTableView;
@property (nonatomic, strong) MYSegmentView * RCSegView;

@end

@implementation commonViewController
- (NSMutableArray*)titileArr{
    if (!_titileArr) {
        _titileArr = [[NSMutableArray alloc] initWithObjects:@"收藏房源",@"我的订单", nil];
    }
    
    return _titileArr;
    
}
- (NSArray *)labelArr
{
    if (!_labelArr) {
        _labelArr = @[self.label1,self.label2,self.label3,self.label4];
    }
    return _labelArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpUI];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [self.peopleHeadView removeFromSuperview];
    
}
- (void)viewDidLoad{
    //[self setUpUiUnLogin];
    
    [self addViewControllers];
    
    [self setScrollView];
    
    [self setTopView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}


-(void)setUpUI{
   /*
    "from_id" = 1;
    icon = "/images/upload/20161216/57bed663-3666-4e3e-8469-3078c5d1f1fa0.jpg";
    id = 38;
    label =     (
                 "大叔",
                 "会摄影"
                 );
    "major_id" = "软件工程";
    mobile = 13783452657;
    "qq_id" = 0520EDE032A6495ACBC6883CD276CF40;
    "univ_id" = 12;*/
    
    NSDictionary  * userDict = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
   //头像
    self.iconImageView.layer.cornerRadius = 35;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.iconImageView.layer.borderWidth = 2;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GlobalImageUrl,userDict[@"icon"]]]];
   //姓名
    self.nameLabel.text = userDict[@"name"];
    [self.nameLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];
    
   //生日
    self.birthdayLabel.text = userDict[@"birthday"];
    self.birthdayLabel.backgroundColor = [UIColor colorWithHexString:@"#52b4e1"];
    self.birthdayLabel.layer.cornerRadius =8;
    //标签
    NSArray  * labelArr1 =userDict[@"label"];
    for (int i = 0; i <4 && i<labelArr1.count; i++) {
        NSString  * str = labelArr1[i];
        UILabel* label=   self.labelArr [i];
        label.text = str;
    }
    
    /*
    self.label1.layer.cornerRadius = 5;
    self.label1.backgroundColor =[UIColor colorWithHexString:@"#eeafe1"];
    self.label2.layer.cornerRadius = 5;
    self.label2.backgroundColor =[UIColor colorWithHexString:@"#f6e8a4"];
    self.label3.layer.cornerRadius = 5;
    self.label3.backgroundColor =[UIColor colorWithHexString:@"#9eddf9"];
    */
    //大学
    NSMutableArray  * universityArr=   [XDCommonTool queryUniversityDataWithID:[userDict[@"univ_id"] stringValue]withType:@"id"];
   
    self.universityLabel.text = universityArr.firstObject;
    [self.universityLabel setTextColor:[UIColor colorWithHexString:@"#707070"]];
    //专业
    self.majorLabel.text = userDict[@"major_id"];
}


- (void)addViewControllers{
    
    //我的收藏
    CollectionViewController  * collVC = [[CollectionViewController alloc] init];
    collVC.view.userInteractionEnabled = YES;
    [self addChildViewController:collVC];
    _colectionVc = collVC;
    //我的订单
    //myOrderTableViewController  * orderVC = [[myOrderTableViewController //alloc] init];
   // [self addChildViewController:orderVC];
   // _myOrderVc = orderVC;

   // [self.view bringSubviewToFront:orderVC.view];
}

- (void)setScrollView{
    
    UIScrollView *view = [[UIScrollView alloc] init];
    view.frame = CGRectMake(0, 290+40, SCREENWIDTH, SCREENHEIGHT-200);
    view.contentSize = CGSizeMake(view.width * self.childViewControllers.count, 0);
    // 去掉滚动条
    view.showsVerticalScrollIndicator = YES;
    view.showsHorizontalScrollIndicator = YES;
    // 设置分页
    view.pagingEnabled = YES;
    // 设置代理
    view.delegate = self;
    // 去掉弹簧效果
    //view.bounces = NO;
    
    [self.view insertSubview:view atIndex:0];
    self.scrollView = view;
    
    [self scrollViewDidEndScrollingAnimation:view];
    
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x / SCREENWIDTH;
    self.selectHead.underLine.x = page*SCREENWIDTH/2;
    
    self.selectHead.selectedType = (int)(page + 0.5);
    
}
# pragma mark -
# pragma mark peopleHeadViewDelegate
- (void)didClickBtn:(NSString *)btnStr{
    
    if ([btnStr isEqualToString:@"设置"]) {
        [self.navigationController pushViewController:[AccountManagerTableViewController new] animated:YES];
    }
    else{
        MHUserInfoTableViewController  * mhUserInfoVc = [MHUserInfoTableViewController new];
        
        [self.navigationController pushViewController:mhUserInfoVc animated:YES];
        
        
    }
    
}

# pragma mark -
# pragma mark 切换频道视图

- (void)setTopView{
    
    selectHeaderView  * selectHead = [[selectHeaderView alloc] initWithFrame:CGRectMake(0, 290, SCREENWIDTH, 40)];
    
    selectHead.width = SCREENWIDTH;
    selectHead.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [selectHead setSelectedBlock:^(HOMETYPE  type) {
        [self.scrollView setContentOffset:CGPointMake(type * SCREENWIDTH, 0) animated:YES];
    }];
    [self.view addSubview:selectHead];
    _selectHead = selectHead;
}

- (IBAction)editBtn:(UIButton *)sender {
    if ([XDCommonTool readBoolFromUserDefaultWithKey:IS_LOGIN]==YES) {
         [self.navigationController pushViewController:[MHUserInfoTableViewController new] animated:YES];
    }
    else{
     [self.navigationController pushViewController:[loginViewController new] animated:YES];
    
    }
   

}
- (IBAction)settingBtn:(UIButton *)sender {
    [self.navigationController pushViewController:[AccountManagerTableViewController new] animated:YES];

}

@end
