//
//  MHUserInfoTableViewController.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/3/6.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "MHUserInfoTableViewController.h"
#import "searchView.h"
#import "city.h"
#import "YJPersonInfoCell.h"
#import "loginViewController.h"
#import "UniversityModel.h"
#import "majorModel.h"
#import "CityPickView.h"
#import "DatePickerView.h"
#import "XYSidePopView.h"
@interface MHUserInfoTableViewController ()<UITableViewDataSource,UITableViewDelegate,tagViewClickNameDelegate,searchViewDelegate,YJPickerKeyBoardDelegate,YJPersonInfoCellDelegate,searchUniversityDelegate>
{
    JCTagView *JCView;
    
}
@property(nonatomic,weak)  CityPickView  * pickerPlace;
@property (strong,nonatomic) DatePickerView *datePickerView;

@property (nonatomic,strong) XYSidePopView *universityPopView;//大学
@property (nonatomic,strong) XYSidePopView *zhunYePopView;//专业
@property (nonatomic,strong) XYSidePopView *jcViewPopVIew;//标签
@property (nonatomic,strong) UITextField *nameText;


//左边的数据源
@property(nonatomic,strong)  NSMutableArray  * itemArray;
//右边的数据源
@property (nonatomic, strong) NSMutableArray *detailArray;
//行
@property (nonatomic, strong) NSIndexPath *indexPath;

///数组数据源
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic,strong) searchUniversityView *   searchView;
@property(nonatomic,strong) searchUniversityView *   searchMajorView;

@end

@implementation MHUserInfoTableViewController
-(searchUniversityView*)searchView{

    if (!_searchView  ) {
        _searchView = [searchUniversityView shareInstance];
    }
    return _searchView;
}
-(searchUniversityView*)searchMajorView{
    
    if (!_searchMajorView  ) {
        _searchMajorView = [searchUniversityView shareInstance];
    }
    return _searchMajorView;
}

///懒加载

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        NSMutableArray  * dataArr = [XDCommonTool getPeiZhiWithFileName:@"allDictionary.plist" keyStr:@"grbq"];
        self.dataSource = [NSMutableArray arrayWithArray:dataArr];
        
    }
    return _dataSource;
}

- (NSMutableArray*)detailArray{

    if (!_detailArray) {
      
        NSDictionary  * userDict =   [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];
       //大学
        NSMutableArray  * universityArr = [XDCommonTool queryUniversityDataWithID:[NSString stringWithFormat:@"%@",userDict[@"univ_id"]]withType:@"id"];
        NSString   * univerStr =  universityArr.firstObject==nil?@"未设置":universityArr.firstObject;

        //专业
        NSMutableArray  * mojorArr = [XDCommonTool queryPeiZhiWithKey:@"subject" withIdOrName:userDict[@"major_id"] withType:@"id"];
        NSString   * majorStr =  mojorArr.firstObject==nil?@"未设置":mojorArr.firstObject;

        //我的标签
        NSArray  * labelArr = userDict[@"label"];
       
        NSMutableArray  * nameLabelArr = [NSMutableArray new];
        
        for (int i = 0; i <labelArr.count ; i++) {
            NSMutableArray  * idArr =    [XDCommonTool queryPeiZhiWithKey:@"grbq" withIdOrName:labelArr[i] withType:@"id"];
            [nameLabelArr addObject:idArr.firstObject];
        }
        
        NSString *tempString = [[nameLabelArr componentsJoinedByString:@","] isEqualToString:@""]?@"未设置":[nameLabelArr componentsJoinedByString:@","];

        //性别
        NSString  * sexStr= [NSString new];
        if ([userDict[@"sex"] isEqualToNumber:@0]) {
            sexStr = @"男";
        }else{
        
        sexStr = @"女";
        }
        NSString  * birthday = userDict[@"birthday"]==nil?@"未设置":userDict[@"birthday"];
        
        
         NSString  * placeStr = userDict[@"be_from"]==nil?@"未设置":userDict[@"be_from"];
        
        
        _detailArray = [[NSMutableArray alloc] initWithObjects:userDict[@"nick_name"],birthday,sexStr,placeStr,univerStr,majorStr,tempString, nil];
        
        if (_detailArray.count ==0) {
            _detailArray = [[NSMutableArray alloc] initWithObjects:@"未设置",@"未设置",@"未设置",@"未设置",@"未设置",@"未设置",@"未设置", nil];
        }
    
    }
    return _detailArray;
}
- (NSMutableArray*)itemArray{
    
    if (!_itemArray) {
        
    _itemArray  = [NSMutableArray arrayWithObjects:@"用户名",@"生日",@"性别",@"我的家乡",@"留学院校",@"就读专业",@"我的标签", nil];
      }
    
    return _itemArray;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;

}


- (void)viewDidLoad {
    [super viewDidLoad];
   self.automaticallyAdjustsScrollViewInsets = NO;
  // [self setUpNewNai:nil Title:@"个人资料"];
    self.view.backgroundColor = [UIColor colorWithHex:0xf0f0f0];
    [self setUpNewNai:nil Title:@"个人资料" withColor:nil];
    [self.rightBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UITableView  * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 285)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    tableView.scrollEnabled = false;
//    tableView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    tableView.tableFooterView.backgroundColor = [UIColor clearColor];
    self.tableView = tableView;
    tableView.layer.shadowColor = [UIColor blackColor].CGColor;
    tableView.layer.shadowOpacity = 0.15f;
    tableView.layer.shadowOffset = CGSizeMake(0, 5);
    tableView.layer.shadowRadius = 10;
    
    [self.view addSubview:self.tableView];
    
   
   // [self setUpUi];
}

- (void)setUpUi{
    //标题
    //保存按钮
    UIButton  * saveBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"icon_nav_back" buttonTitle:@"保存" target:self action:@selector(save)];
    saveBtn.backgroundColor = [UIColor redColor];
    [saveBtn setTitleColor:[UIColor colorWithHexString:@"#29a7e1"] forState:UIControlStateNormal];
    [self.view addSubview:saveBtn];
    
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@45);
        make.height.equalTo(@19);
        make.right.equalTo(self.view.mas_right).offset(-10);
        //make.top.equalTo(self.view.mas_top).offset(10);
        make.centerY.equalTo(self.view.mas_centerY);
    }];

    



}
# pragma mark -
# pragma mark 保存信息

- (void)save{
  
    //如果大学，专业，标签未设置，不可保存
//    if ([self.detailArray[4] isEqualToString:@"未设置"]||[self.detailArray[5] isEqualToString:@"未设置"]||[self.detailArray[6] isEqualToString:@"未设置"]) {
//        [self showHint:@"请把信息填写完整"];
//        return;
//    }
    
    NSDictionary  * userDict =   [XDCommonTool readDicFromUserDefaultWithKey:@"userInfo"];
    
    
    YJPersonInfoCell  *declarationcell =(YJPersonInfoCell *)[self tableView:self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSString  * homeTownStr =     declarationcell.text.text;
    
    //兴趣爱好
    NSArray  * labelArr =   [self.detailArray[6]componentsSeparatedByString:@","];
    NSMutableArray  * idMutableArr = [NSMutableArray new];
    for (int i = 0; i <labelArr.count; i ++) {
     NSMutableArray  * idArr =    [XDCommonTool queryPeiZhiWithKey:@"grbq" withIdOrName:labelArr[i] withType:@"name"];
        [idMutableArr addObject:idArr.firstObject];
    }
    
    
    
    //生日
    
   
    //大学
   NSMutableArray  * idUniversityArr =   [XDCommonTool queryUniversityDataWithID:self.detailArray[4] withType:@"name"];
   //专业
    NSMutableArray  * majorArr =   [XDCommonTool queryPeiZhiWithKey:@"subject" withIdOrName:self.detailArray[5] withType:@"name"];
    
    NSNumber  *sex =  [NSNumber new];
    if ([self.detailArray[2] isEqualToString:@"男"]) {
        sex = @0;
    }
    else{
        sex = @1;
    }
   
    if (majorArr == nil || [majorArr isKindOfClass:[NSNull class]] || majorArr.count == nil){
        [majorArr addObject:@"未设置"];

    
    }
    if (idUniversityArr == nil || [idUniversityArr isKindOfClass:[NSNull class]] || idUniversityArr.count == nil){
        [idUniversityArr addObject:@"未设置"];
        
        
    }
    
    NSString *name = self.detailArray[0];
    if (name.length == 0) {
        [self showHint:@"用户名不能为空"];
        return;
    }
    
    NSDictionary  * dict = @{@"client_id":[userDict objectForKey:@"id"],@"be_from":self.detailArray[3],@"univ_id":idUniversityArr.firstObject,@"major_id":majorArr.firstObject,@"label":idMutableArr,@"nick_name":self.detailArray[0],@"sex":sex,@"birthday":self.detailArray[1]};
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]initWithDictionary:dict];
    [NSDictionary deleteKeysWithValue:@"未设置" inDict:dict1];
    [NSDictionary deleteKeysWithValue:@"" inDict:dict1];
 
    LRLog(@"%@",self.detailArray);
    [[NetworkClient sharedClient] POST:URL_UPDATEINFO dict:dict1 succeed:^(id data) {
      LRLog(@"更改信息%@",data);
        if ([data[@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]){
            [self showHint:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
        
            [self showHint:@"保存失败"];

        }
    
    } failure:^(NSError *error) {
      LRLog(@"更改信息%@",error);

  }];


}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJPersonInfoCell *cell = [YJPersonInfoCell personInfoCellWithTableView:tableView];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.delegate = self;
    //cell左边的数据
    cell.name.text = self.itemArray[indexPath.row];
    //cell右边的数据
    NSString *nameStr = self.detailArray[indexPath.row];
    cell.text.text =  [NSString stringWithFormat:@"%@",nameStr];
    
    
    if (indexPath.section ==0) {
        YJPersonInfoCell *cell = [YJPersonInfoCell personInfoCellWithTableView:tableView];
        self.nameText = cell.text;
        cell.text.enabled = true;
        cell.delegate  =self;
    }
    
    if ([nameStr isEqualToString:@"未设置"]) {
        cell.text.textColor = [UIColor colorWithHex:0xcccccc];
    }else{
        cell.text.textColor = [UIColor colorWithHex:0x666666];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
    // return 8*SCREENHEIGHT/1334;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchView!=nil) {
        [self.searchView removeFromSuperview];
    }
    
    //用户名特殊
    if (indexPath.row == 0) {
        self.indexPath = indexPath;
        YJPersonInfoCell *cell = (YJPersonInfoCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.text.enabled = YES;
        cell.delegate = self;
    }
     switch (indexPath.row) {
                
            case 1:{
                self.indexPath = indexPath;
                _datePickerView = [[DatePickerView alloc] initWithCustomeHeight:200];
                __weak typeof (self) weakSelf = self;
                _datePickerView.confirmBlock = ^(NSString *choseDate, NSString *restDate) {
                    [self pickerBoardFinish:choseDate withData:nil];
                };
                
                _datePickerView.cannelBlock = ^(){
                    
                    [weakSelf.view endEditing:YES];
                    
                };
                [self.view addSubview:_datePickerView];
                
                
            }
                break;
            
         
         case 2:{
             self.indexPath = indexPath;
             YJPickerKeyBoard *pickerBoard = [[YJPickerKeyBoard alloc] initWithFrame:CGRectMake(0,SCREENHEIGHT - 180, SCREENWIDTH, 180)];
             
             [self.view addSubview:pickerBoard];
             pickerBoard.delegate = self;
             pickerBoard.contents = @[@[@"男", @"女"]];
         }
         
             break;
         
         
         case 3:{
                self.indexPath = indexPath;
                
                CityPickView *cityPickView = [[CityPickView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-180, SCREENWIDTH, 180)];
                
                [cityPickView setContentPath:[[NSBundle mainBundle] pathForResource:@"citymh" ofType:@"plist"]];
                
                cityPickView.address = @"江苏省-南京市-雨花台区";  //设置默认城市，弹出之后显示的是这个
                cityPickView.backgroundColor = [UIColor whiteColor];//设置背景颜色
                cityPickView.toolshidden = NO; //默认是显示的，如不需要，toolsHidden设置为yes
                
                self.pickerPlace = cityPickView;
                [self.view addSubview:cityPickView];
             
             //每次滚动结束都会返回值
                cityPickView.confirmblock = ^(NSString *proVince,NSString *city,NSString *area){
                };
                //点击确定按钮回调
                cityPickView.doneBlock = ^(NSString *proVince,NSString *city,NSString *area){
                    //textField.text = [NSString stringWithFormat:@"%@-%@-%@",proVince,city,area];
                    [self pickerBoardFinish:[NSString stringWithFormat:@"%@-%@-%@",proVince,city,area] withData:nil];
                    [cityPickView removeFromSuperview];
                    
                };
                //点击取消按钮回调
                cityPickView.cancelblock = ^(){
                    [cityPickView removeFromSuperview];
                };

           
            
            
            }
             
                break;
  
             
            case 4:{
                
                self.indexPath = indexPath;

                self.searchView.frame = CGRectMake(60, 0, SCREENWIDTH-60,SCREENHEIGHT);
               self.searchView.typeStr = @"大学";
                self.searchView.delegate = self;
                self.searchView.backgroundColor = [UIColor grayColor];
//                [self.view addSubview:self.searchView];
//                [UIView animateWithDuration:0.5 animations:^{
//                    self.searchView.frame =   CGRectMake(100, 20, SCREENWIDTH-100, SCREENHEIGHT-20);
//                }];
                [self.searchView initViewWithData:@[@"1",@"2"]];
                
                XYSidePopView *sidePopView =[XYSidePopView initWithCustomView:self.searchView andBackgroundFrame:[self.view convertRect:[UIApplication sharedApplication].keyWindow.frame toView:[UIApplication sharedApplication].keyWindow] andPopType:popTypeRight];
                self.universityPopView = sidePopView;
                self.searchView.finishBlock = ^{
                    [sidePopView dismissplay];
                };
            }
                
                break;
           
         case 5:{
         
             self.indexPath = indexPath;
             

             self.searchMajorView.frame = CGRectMake(60, 0, SCREENWIDTH-60,SCREENHEIGHT);
             self.searchMajorView.typeStr = @"专业";
             self.searchMajorView.delegate = self;
             self.searchMajorView.backgroundColor = [UIColor grayColor];
//             [self.view addSubview:self.searchView];
//             [UIView animateWithDuration:0.5 animations:^{
//                 self.searchView.frame =   CGRectMake(100, 20, SCREENWIDTH-100, SCREENHEIGHT);
//             }];
             [self.searchMajorView initViewWithData:@[@"1",@"2"]];
         
             XYSidePopView *sidePopView =[XYSidePopView initWithCustomView:self.searchMajorView andBackgroundFrame:[self.view convertRect:[UIApplication sharedApplication].keyWindow.frame toView:[UIApplication sharedApplication].keyWindow] andPopType:popTypeRight];
             self.zhunYePopView = sidePopView;
             self.searchMajorView.finishBlock = ^{
                 [sidePopView dismissplay];
             };
         }
         
             break;
         case 6:{
                self.indexPath = indexPath;
                JCView = [[JCTagView alloc] initWithFrame: CGRectMake(80, 0, SCREENWIDTH-80, SCREENHEIGHT+100)];
                
                JCView.delegate = self;
                JCView.JCSignalTagColor = [UIColor colorWithHexString:@"#d9d9d9"];
                JCView.JCbackgroundColor = [UIColor colorWithHexString:@"#ffffff"];

//                [UIView animateWithDuration:0.5 animations:^{
//                    JCView.frame =   CGRectMake(100, 0, SCREENWIDTH-100, SCREENHEIGHT);
//
//               }];
             [JCView setArrayTagWithLabelArray:self.dataSource withMaxSelected:4];
             
             XYSidePopView *sidePopView =[XYSidePopView initWithCustomView:JCView andBackgroundFrame:[self.view convertRect:[UIApplication sharedApplication].keyWindow.frame toView:[UIApplication sharedApplication].keyWindow] andPopType:popTypeRight];
             self.jcViewPopVIew = sidePopView;
             
             JCView.finshBlock = ^{
                 [sidePopView dismissplay];
             };

            }
                break;
            default:
                break;
        }
}

# pragma mark -
# pragma mark YJPickerKeyBoardDelegate
- (void)pickerBoardFinish:(NSString *)selected withData:(NSArray *)dataArray{

    if (!selected) {
        selected = dataArray[0][0];
        
    };
    [self.detailArray replaceObjectAtIndex:self.indexPath.row withObject:selected];
    [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - YJPersonInfoCellDelegate
-(void)personInfoChange:(NSString *)change andCell:(YJPersonInfoCell *)cell{

    //NSMutableArray *arr = self.detailArray[self.indexPath.row];
    //[arr replaceObjectAtIndex:self.indexPath.row withObject:change];
    
    [self.detailArray replaceObjectAtIndex:self.indexPath.row withObject:change];
    
//    [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    self.nameText.text = change;
}



# pragma mark -
# pragma mark searchViewDelegate

-(void)didSelectUniversity:(UniversityModel *)University{
    LRLog(@"选择的城市名字为%@",University.name_zh);
    [self pickerBoardFinish:University.name_zh withData:nil];
    [self.universityPopView dismissplay];

}
-(void)didSelectMajor:(majorModel *)major{
    
    [self pickerBoardFinish:major.name_zh withData:nil];
    
    [self.zhunYePopView dismissplay];

}
# pragma mark -
# pragma mark tagViewClickNameDelegate
- (void)tagClick:(NSMutableArray *)tagTitleArr{
    LRLog(@"选择的标签为%@",tagTitleArr);
   NSString * tempString = [tagTitleArr componentsJoinedByString:@","];
    //--分隔符
    [self pickerBoardFinish:tempString withData:nil];
    
    [self.jcViewPopVIew dismissplay];
}

@end
