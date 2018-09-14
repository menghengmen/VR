//
//  PhotoManager.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/5/3.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "PhotoManager.h"
#import "UtilityManager.h"
#import "MBProManager.h"

static PhotoManager *    s_PhotoManager = nil;

@implementation PhotoManager
{
    UIImagePickerController         *_IPController;
    UIImage                         *_ChoiceImg;
    
    BOOL                            _ImageOper;
}
@synthesize delegate;

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_PhotoManager = [[PhotoManager alloc] init];
    });
    return s_PhotoManager;
}

/**
 * 照片本地提取
 * @Param
 * @Return
 */
- (void)showNormalPicker:(UIViewController *)root
{
    _IPController = nil;
    _IPController = [[UIImagePickerController alloc] init];
    _IPController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _IPController.delegate = self;
    _IPController.allowsEditing = YES;
    _ImageOper = YES;
    [root presentViewController:_IPController animated:YES completion:^{
        
    }];
}

/**
 * 选取本地视频
 * @Param
 * @Return
 */
- (void)showLocalVideoPicker:(UIViewController *)root
{
    _IPController = nil;
    _IPController = [[UIImagePickerController alloc] init];
    _IPController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _IPController.delegate = self;
    _IPController.allowsEditing = YES;
    _IPController.mediaTypes = @[(NSString*)kUTTypeMovie];
    _ImageOper = NO;
    [root presentViewController:_IPController animated:YES completion:^{
        
    }];
}

/**
 * 自己拍摄
 * @Param
 * @Return
 */
- (void)showCameraVideoPicker:(UIViewController *)root
{
    
    
    if([[UtilityManager shareInstance] checkIsAuthor:AVMediaTypeVideo])
    {
        _IPController = nil;
        _IPController = [[UIImagePickerController alloc] init];
        _IPController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _IPController.delegate = self;
        _IPController.allowsEditing = YES;
        _IPController.mediaTypes = @[(NSString*)kUTTypeMovie];
        _IPController.videoQuality = UIImagePickerControllerQualityTypeMedium;
        _ImageOper = NO;
        [root presentViewController:_IPController animated:YES completion:^{
            
        }];
    }
}



- (void)showCameraPicker:(UIViewController *)root
{
    
    
    if([[UtilityManager shareInstance] checkIsAuthor:AVMediaTypeVideo])
    {
        _IPController = nil;
        _IPController = [[UIImagePickerController alloc] init];
        _IPController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _IPController.delegate = self;
        _IPController.allowsEditing = YES;
        _ImageOper =YES;
        [root presentViewController:_IPController animated:YES completion:^{
            
        }];
    }
}

# pragma mark -
# pragma mark UIImagePickerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    LRLog(@"%@",[info description]);
    
    if (_ImageOper) {
        //图片处理
        _ChoiceImg = [info objectForKey:UIImagePickerControllerEditedImage];
        [delegate imagePicker:_ChoiceImg];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }else{
        ///视频处理
        NSURL* sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                         forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [picker dismissViewControllerAnimated:YES completion:nil];
            MBProManager* tMBProManager = [MBProManager shareInstance];
            [tMBProManager showHubActive:@"" titleText:@"压缩视频中..." containerView:((UIViewController*)delegate).view];
        });
        
        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:sourceURL options:opts];
        float second = 0;
        second = urlAsset.duration.value/urlAsset.duration.timescale;
        LRLog(@"movie duration : %f", second);
        NSString* tSize = [NSString stringWithFormat:@"%f kb", [self getFileSize:[[sourceURL absoluteString] substringFromIndex:16]]];//文件并没有存储在sourceURL所指的地方，因为这里自己加上了所以要将这段字符串去掉，这个Label是测试时工程中用到的显示所拍摄文件大小的标签
        LRLog(@"原始大小：%@",tSize);
        LRLog(@"原始路径：%@",[[sourceURL absoluteString] substringFromIndex:16]);
        
        if (second >=5 && second<= 3*60) {
            //转换时文件不能已存在，否则出错
            AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:sourceURL options:nil];
            NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
            if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]) {
                AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
                NSString* tTemp = NSTemporaryDirectory();
                NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
                [dateformat setDateFormat:@"yyyyMMddHHmmss"];
                NSString* tNameVideo = [dateformat stringFromDate:[NSDate date]];
                NSString* tImgLocalURL =[NSString stringWithFormat:@"%@.mp4",[tTemp stringByAppendingPathComponent:tNameVideo]];
                LRLog(@"%@",tImgLocalURL);
                
                exportSession.outputURL = [NSURL fileURLWithPath:tImgLocalURL];
                exportSession.outputFileType = AVFileTypeMPEG4;
                [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
                 {
                     switch ((int)exportSession.status) {
                         case AVAssetExportSessionStatusUnknown:
                             LRLog(@"AVAssetExportSessionStatusUnknown");
                             [delegate videoPickerError:AVAssetExportSessionStatusUnknown];
                             break;
                         case AVAssetExportSessionStatusWaiting:
                             LRLog(@"AVAssetExportSessionStatusWaiting");
                             [delegate videoPickerError:AVAssetExportSessionStatusWaiting];
                             break;
                         case AVAssetExportSessionStatusExporting:
                             LRLog(@"AVAssetExportSessionStatusExporting");
                             [delegate videoPickerError:AVAssetExportSessionStatusExporting];
                             break;
                         case AVAssetExportSessionStatusCompleted:
                             LRLog(@"AVAssetExportSessionStatusCompleted");
                             LRLog(@"转化后：%f kb",[self getFileSize:tImgLocalURL]);
                             [delegate videoPickerSuc:tImgLocalURL];
                             break;
                         case AVAssetExportSessionStatusFailed:
                             LRLog(@"AVAssetExportSessionStatusFailed");
                             [delegate videoPickerError:AVAssetExportSessionStatusFailed];
                             break;
                     }
                     [picker dismissViewControllerAnimated:YES completion:nil];
                 }];
            }else{
                [delegate videoPickerError:AVAssetExportSessionStatusUnknown];
            }
        }else{
            [delegate videoPickerTimeError];
            
        }
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //[self.delegate imagePickerDidCancel];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark-
#pragma mark 呵呵你懂的
- (void)convert:(NSURL*)sourceURL
{
    
}

- (CGFloat) getFileSize:(NSString *)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }
    return filesize;
}
- (CGFloat) getVideoLength:(NSURL *)URL
{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:URL options:opts];
    float second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    return second;
}

@end
