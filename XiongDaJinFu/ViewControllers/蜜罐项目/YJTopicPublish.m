//
//  YJTopicPublish.m
//  WalkTogether2
//
//  Created by boding on 15/7/30.
//  Copyright (c) 2015年 GYJ. All rights reserved.
//

#import "YJTopicPublish.h"
#import "topicPublishCell.h"
#import "TZImagePickerController.h"
#import "UIViewController+HUD.h"
#define kCellHeight 195

#define  globalImageUrl  @"http://ok4372s5v.bkt.clouddn.com/"
#define kDocumentsPath                      [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0]

@interface YJTopicPublish () <UITableViewDelegate, UITableViewDataSource, topicPublishCellDelegate, UIAlertViewDelegate>
{
    NSUInteger _topicType;
    BOOL _isExit;
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, copy) NSString *publishContent;

@property (nonatomic, strong) NSMutableArray *uploadImageArr;

@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) TZImagePickerController *imagePickerVC;
@property (nonatomic)id model;


@end

@implementation YJTopicPublish

- (NSMutableArray *)uploadImageArr
{
    if (!_uploadImageArr) {
        _uploadImageArr = [NSMutableArray array];
    }
    return _uploadImageArr;
}

- (NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}
- (void)viewWillAppear:(BOOL)animated{


    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewWillDisappear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = YES;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (instancetype)initWithTopicType:(TopicType)type Model:(id)model
{
    if (self = [super init]) {
        _topicType = type;
        _model = model;
    }
    return self;
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //初始化返回button
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.title = @"发表动态";
    //初始化发表button
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    rightBtn.enabled = NO;
    self.rightButton = rightBtn;
    [rightBtn addTarget:self action:@selector(uploadImages) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    //初始化UITableView
    CGRect frame = self.view.frame;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -300, frame.size.width, frame.size.height + 300)];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    //添加表头
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -300, frame.size.width, 300)];
    headerView.backgroundColor = [UIColor whiteColor];
    tableView.tableHeaderView = headerView;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark -action
-(void)backClick
{
    topicPublishCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ((cell.inputContent.text.length > 0 || (self.imageArr.count > 0)) && !_isExit)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"你要放弃发布么?" message:nil delegate:self cancelButtonTitle:@"继续编辑" otherButtonTitles:@"放弃", nil];
        [alertView show];
        
    }
    else
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)uploadImages
{
   
    
    NSDictionary  * QINIUDict =    [XDCommonTool readDicFromUserDefaultWithKey:QINIU];
    
    if(self.imageArr.count == 0)
    {
        [self uploadInfo];
        return;
    }
    topicPublishCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell.inputContent.text.length == 0)
    {
        [self showHint:@"请输入文本信息" yOffset:-100];
        return;
    }
    for (int i = 0; i < self.imageArr.count; i++)
    {
       
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];

        
        NSData *imageData = UIImageJPEGRepresentation(self.imageArr[i], 0.9f);
        
        NSString *uniqueName = [NSString stringWithFormat:@"%@.jpg",[formatter stringFromDate:date]];
           NSString *uniquePath = [kDocumentsPath stringByAppendingPathComponent:uniqueName];

           [imageData writeToFile:uniquePath atomically:NO];

        
        //http://ok4372s5v.bkt.clouddn.com/20170320180259.jpg
        
        
       
        
       }

}

-(void)uploadInfo
{
    NSString *string ;
  
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
     topicPublishCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.uploadImageArr options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *imagesStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [dict setObject:imagesStr forKey:@"images"];
    [dict setObject:cell.inputContent.text forKey:@"content"];

    switch (_topicType)
    {
        case kSportType:
        {                string =  [NSString stringWithFormat:@"%@"];
        [dict setObject:[_model valueForKey:@"myId"] forKey:@"entryId"];
        }
            break;
        case kMatchType:
        {
            string = [NSString stringWithFormat:@"%@"];
        [dict setObject:[_model valueForKey:@"myId"] forKey:@"entryId"];
        }
            break;
        case kClubType:
        {
            string = [NSString stringWithFormat:@"%@"];
            [dict setObject:[_model valueForKey:@"friendId"] forKey:@"entryId"];
        }
            break;
        case kCircleType:
        {
            string = [NSString stringWithFormat:@"%@"];
            [dict setObject:[_model valueForKey:@"friendId"] forKey:@"entryId"];
        }
            break;
        default:
            break;
    }
            
            
    
    
    
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    topicPublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicPublishCell"];
     
    if (!cell) {
        cell = (topicPublishCell *)[[[NSBundle mainBundle] loadNibNamed:@"topicPublishCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    cell.imageArr = _imageArr;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kCellHeight;
    }

        return 20;
}

#pragma mark -UITableViewDelegate


#pragma mark -topicPublishCellDelegate
/*
- (void)itemClickWithIndex:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.imageArr.count)
    {
        __weak typeof(self) weakSelf = self;
        TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:kMaxImageCount - self.imageArr.count delegate:self];
        imagePicker.allowPickingOriginalPhoto = YES;
        imagePicker.allowPickingVideo = NO;
        //imagePicker.maxImagesCount = 9;
        [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
        
       // [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL is) {
            //[weakSelf refreshDate:photos];
       // }];
        self.imagePickerVC = imagePicker;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
*/
- (void)refreshDate:(NSArray *)photos
{
    topicPublishCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    self.imageArr = cell.imageArr;
    [self.imageArr addObjectsFromArray:photos];
    [cell refreshCollectionView:self.imageArr];
    [self.tableView reloadData];
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
