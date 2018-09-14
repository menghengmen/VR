//
//  MHUniversityDetailViewController.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/2/23.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "MHUniversityDetailViewController.h"
#import "PlayerViewController.h"
#import "universityDetailTableViewCell2.h"
#import "MHCommentViewController.h"
#import "UniversityModel.h"
#import "HTY360PlayerVC.h"
#import "XYCommentTableVC.h"
#import "fullImageModel.h"
#import "UniversityVideos.h"
#import "XYUniversityDetailBaseVC.h"
@interface MHUniversityDetailViewController ()<UITableViewDataSource,UITableViewDelegate,universityDetailTableViewCellDelegate>

{
    PlayerViewController *vc;
    UITableView  *    tableview;
}
@property(nonatomic,strong)  UniversityModel  * universityDetail;
@end
@implementation MHUniversityDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self supportedInterfaceOrientations];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self setNeedsStatusBarAppearanceUpdate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFullBackGroundView];
    [self setUpUI];
    [self getData];

}
# pragma mark -
# pragma mark 全景背景图
- (void)setFullBackGroundView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BitmapPlayer" bundle:nil];
    vc = [storyboard instantiateViewControllerWithIdentifier:@"BitmapPlayerViewController"];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
    }];
    //本地
   // NSString  * pathStr =  [[NSBundle mainBundle] pathForResource:@"002" ofType:@"jpg"];
  //  [vc initParams:[NSURL URLWithString:pathStr]];
    //网络请求
    //[vc initParams:[NSURL URLWithString:@"http://ok4372s5v.bkt.clouddn.com/002.jpg"]];
   
}
- (void)setUpUI{
    //创建表格
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    tableview.dataSource=self;
    tableview.delegate=self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.scrollEnabled = NO;
   
    [self.view addSubview:tableview];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
         
         return SCREENHEIGHT;
         
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
         
         return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
         
         
    universityDetailTableViewCell2  * cell = [universityDetailTableViewCell2 detailCell2WithTableView:tableView];
    
    cell.model = self.universityDetail;
    cell.delegate = self;
    
    return cell;
}
- (BOOL)shouldAutorotate{
    
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

# pragma mark -
# pragma mark universityDetailTableViewCellDelegate

- (void)detailCell:(universityDetailTableViewCell2 *)Cell didSelectBnt:(NSUInteger)btnIndex{

    switch (btnIndex) {
        case 100:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 104:{
            [self playVideo];
            
        }
            break;
        
        case 102:{

            XYCommentTableVC  * commentVC = [XYCommentTableVC new];
            commentVC.commented = self.univ_id ;
            commentVC.hourseType = XYHourseTypeUniversity;
            [self .navigationController pushViewController:commentVC animated:YES];        
        }
            break;
        case 103:{
            [MobClick event:@"ToFlatList" attributes:@{@"type":@"university"}];
            XYUniversityDetailBaseVC *un =[[XYUniversityDetailBaseVC alloc]init];
            NSMutableArray  * idUniversityArr =   [XDCommonTool queryUniversityDataWithID:self.universityDetail.name_zh withType:@"name"];
            un.hourseType = XYHourseTypeFlat;
            un.university = [idUniversityArr.firstObject stringValue];
            [self.navigationController pushViewController:un animated:YES];
        
        
          }
            break;
        
        
        default:
            break;
    }
}
-(void)playVideo{
    HTY360PlayerVC * hty360VC =[HTY360PlayerVC sharedInstance];
    UniversityVideos  * univerVideo = self.universityDetail.videos.firstObject;
    hty360VC.videoTitle = self.universityDetail.name_zh;
    hty360VC.videoURL = [NSURL URLWithString:univerVideo.url];
    [self presentViewController:hty360VC animated:NO completion:nil];

}
- (void)getData{
    NSMutableDictionary * dict = [NSMutableDictionary new];
      [dict setObject:self.univ_id forKey:@"univ_id"];
    [[NetworkClient sharedClient] POST:[NSString stringWithFormat:@"%@/%@",URL_UNIVERSITYLIST,self.univ_id] dict:nil succeed:^(id data) {
        LRLog(@"%@",data);
        NSDictionary  * dataDict = [data objectForKey:@"result"];
        self.universityDetail = [UniversityModel mj_objectWithKeyValues:dataDict];
        fullImageModel * full = self.universityDetail.full_shot_images.firstObject;
        [vc initParams:[NSURL URLWithString:full.url]];
        [tableview reloadData];
    } failure:^(NSError *error) {
        LRLog(@"%@",error);
    }];
    
    
}
@end
