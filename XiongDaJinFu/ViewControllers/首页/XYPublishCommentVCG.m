//
//  XYPublishCommentVCG.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/4/28.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYPublishCommentVCG.h"
#import "XYPublishCommentPicCell.h"
#import "XYPublishCommentTextCell.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "TZImagePickerController.h"
#import "loginViewController.h"
@interface XYPublishCommentVCG ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)NSMutableArray *photosArray;
@end

@implementation XYPublishCommentVCG
{
    CGFloat _textViewHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _textViewHeight = 69;
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = false;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.title = @"评论";
    [self creatRightItem];
    
    loginViewController  * LOGIN = [loginViewController new];
    [LOGIN BGLogin:^{
        
    }];
}

-(NSMutableArray *)photosArray{
    if (!_photosArray) {
        _photosArray = [NSMutableArray array];
    }
    return _photosArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_MAIN.width, SCREEN_MAIN.height -64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYPublishCommentPicCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYPublishCommentPicCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYPublishCommentTextCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYPublishCommentTextCell class])];
        
    }
    return _tableView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(void)creatRightItem{
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    [bu setTitle:@"完成" forState:UIControlStateNormal];
    [bu setTitleColor:[UIColor colorWithHex:0x29a7e1] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    bu.frame = CGRectMake(0, 0, 40, 50);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:bu];
}

-(void)rightItemClick:(UIButton *)sender{
    if (self.photosArray.count == 0 && self.textView.text.length <= 0) {
        [MBProgressHUD showError:@"文字和图片不能同时为空"];
        return;
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:STATUS_APPRENCE object:@{@"status":@(XYUploadingStatusUploading)}];
    if (self.photosArray.count >0 ) {
        [[ESWebService sharedWebService].flat uploadImagesToQiNiuWithParameter:self.photosArray type:XYUploadFileTypeCommentImage progress:^(NSString *key, float percent) {
            
        } success:^(id jsonData) {
            //        LxDBAnyVar(jsonData);
            //上传评论
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            //        dict[@"comment"] = ;//
            dict[@"commented"] = self.commentedId;//
            dict[@"content"] = self.textView.text;//
            dict[@"images"] = jsonData;//
            dict[@"type"] = @(self.hourseType);//评价房源
            [self uploadComment:dict];
            
        } failure:^(NSString *error,NSString *errorCode) {
            //        [MBProgressHUD showError:@"上传图片失败"];
            [[NSNotificationCenter defaultCenter]postNotificationName:STATUS_APPRENCE object:@{@"status":@(XYUploadingStatusFailed)}];
        }];
    }else{
        //上传评论
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        //        dict[@"comment"] = ;//
        dict[@"commented"] = self.commentedId;//
        dict[@"content"] = self.textView.text;//
        dict[@"type"] = @(self.hourseType);//评价房源
        [self uploadComment:dict];
    }
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)uploadComment:(NSDictionary *)dict{
    [[ESWebService sharedWebService].flat addCommentWithParameter:dict success:^(id jsonData) {
        [[NSNotificationCenter defaultCenter]postNotificationName:STATUS_APPRENCE object:@{@"status":@(XYUploadingStatusSuccess)}];
    } failure:^(NSString *error,NSString *errorCode) {
        if ([errorCode isEqualToString:@"40004"]) {
            [MBProgressHUD showMessage:@"登录信息失效，请重新登录"];
            loginViewController *log = [[loginViewController alloc]init];
            [self.navigationController pushViewController:log animated:true];
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:STATUS_APPRENCE object:@{@"status":@(XYUploadingStatusFailed)}];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 220;
    if (indexPath.row == 0) {
//        if (_textViewHeight +31 >height) {
//           return  _textViewHeight +31;
//        }
        return height ;
    }else{
        NSInteger line;
        if (self.photosArray.count <9) {
            line = (self.photosArray.count +1)/3 +((self.photosArray.count +1)%3 == 0?0:1);
        }else{
            line = 3;
        }
        CGFloat width = (SCREEN_MAIN.width -40)/3.0;
        return line *width +(line -1)*10 +10;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        XYPublishCommentTextCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYPublishCommentTextCell class])];
        self.textView = cell.textView;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textDidChangedBlock  =^(UITextView *textView){
            [tableView beginUpdates];
            [tableView endUpdates];
        };
        return cell;
    }else{
        XYPublishCommentPicCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYPublishCommentPicCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.array = self.photosArray;
        
        @weakify(self);
        //获取图片
        cell.getPicBlock = ^(){
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:nil];
            imagePickerVc.allowPickingOriginalPhoto = false;
            imagePickerVc.allowPickingVideo = false;
            
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL is) {
                @strongify(self);
                [self.photosArray addObjectsFromArray:photos];
                [self.tableView reloadData];
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        };
        
        //删除
        cell.deleteBlock = ^(NSInteger index){
            @strongify(self);
            [self.photosArray removeObjectAtIndex:index];
            [self.tableView reloadData];
        };
        
        //调整顺序
        cell.imageSequenceBlock = ^(NSArray *array){
            self.photosArray = [NSMutableArray arrayWithArray:array];
        };
        return cell;
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
