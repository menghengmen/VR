//
//  XYPublishCommentVC.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/29.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYPublishCommentVC.h"
#import "CLTextView.h"
#import "CLPhotosVIew.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "TZImagePickerController.h"
#import "loginViewController.h"
@interface XYPublishCommentVC ()<UITextViewDelegate>

@property (nonatomic,weak) CLPhotosVIew *phontView;
@property (nonatomic,strong) NSMutableArray *imgArr;
@property (nonatomic,strong)CLTextView *textView;
@end

@implementation XYPublishCommentVC

/*懒加载**/
- (NSMutableArray *)imgArr
{
    if (_imgArr == nil) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}

-(void)creatUI{
    self.view.backgroundColor = [UIColor whiteColor];
    CLTextView *textView = [[CLTextView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 300)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.delegate = self;
    self.textView = textView;
    textView.placehoder = @"请输入要评论的内容...";
    [self.view addSubview:textView];
    
    CLPhotosVIew *photosView = [[CLPhotosVIew alloc] initWithFrame:CGRectMake(10, 50, textView.frame.size.width-20, 250)];
    self.phontView = photosView;
    photosView.photoArray = @[[UIImage imageNamed:@"images_01"]];
    __weak XYPublishCommentVC *weakSelf=self;
    photosView.clickcloseImage = ^(NSInteger index){
        [weakSelf.imgArr removeObjectAtIndex:index];
    };
    photosView.clickChooseView = ^{
        // 直接调用相册
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:nil];
        imagePickerVc.allowPickingOriginalPhoto = false;
        imagePickerVc.allowPickingVideo = false;
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL is) {
            [weakSelf.imgArr addObjectsFromArray:photos];
            NSArray *arr = [weakSelf.imgArr arrayByAddingObjectsFromArray:@[[UIImage imageNamed:@"images_01"]]];
            weakSelf.phontView.photoArray = arr;
            
            
        }];
        [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
        
    };
    [textView addSubview:photosView];
    
    //
    [self creatRightItem];
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
    if (self.imgArr.count == 0 && self.textView.text.length <= 0) {
        [MBProgressHUD showError:@"文字和图片不能同时为空"];
        return;
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:STATUS_APPRENCE object:@{@"status":@(XYUploadingStatusUploading)}];
    if (self.imgArr.count >0 ) {
        [[ESWebService sharedWebService].flat uploadImagesToQiNiuWithParameter:self.imgArr type:XYUploadFileTypeCommentImage progress:^(NSString *key, float percent) {
            
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

#pragma  mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat textH = [textView.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    CGRect frame = self.phontView.frame;
    frame.origin.y = 50+textH;
    self.phontView.frame = frame;
}
@end
