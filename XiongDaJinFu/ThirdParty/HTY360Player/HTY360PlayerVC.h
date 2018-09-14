//
//  HTY360PlayerVC.h
//  HTY360Player
//
//  Created by  on 11/8/15.
//  Copyright © 2015 Hanton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
//#import "PlayModel.h"
@protocol HTY360PlayerVCDelegate
- (void)rotatePortrait;
-(void)rotateLandscape;
-(void)lockLand:(BOOL)needLock;
- (void)htyPlayerEndShare;
//- (void)htyPlayerRefer:(PlayDictionaryModel *)model;

@end
@interface HTY360PlayerVC : UIViewController<AVPlayerItemOutputPullDelegate>
@property(weak)id<HTY360PlayerVCDelegate> delegate;
@property (strong, nonatomic) NSURL *videoURL;
//@property (strong, nonatomic) IBOutlet UIView *debugView;
//@property (strong, nonatomic) IBOutlet UILabel *rollValueLabel;
//@property (strong, nonatomic) IBOutlet UILabel *yawValueLabel;
//@property (strong, nonatomic) IBOutlet UILabel *pitchValueLabel;
//@property (strong, nonatomic) IBOutlet UILabel *orientationValueLabel;
@property (assign) BOOL isLandscape;
@property (nonatomic, strong) UIButton *lockBtn;
@property(strong)UIPanGestureRecognizer *panRecognizer;
@property (assign) int isFavorite;
@property (assign) int vid;
@property (nonatomic, strong) NSString *trendsId;//搜索页面的视频id

@property (strong, nonatomic) UIButton *backBtn;
//加载缓冲视频
@property (nonatomic,strong)   UIView  * loadingView;


@property (strong, nonatomic) UIButton *changeButton;



@property (assign) BOOL externalVideo;
//是不是引导video
@property(assign)   BOOL   isGuideVideo;
//是不是已经下载过
@property (assign)   BOOL   alreadyDownload;

//是否是动态里面的视频
@property  (assign)  BOOL    isDongTaiVideo;
// 用于返回
@property (nonatomic, strong) NSString *orgainStr;
@property (nonatomic, strong) NSString *isBack;

@property (nonatomic, strong) NSString *outSideUrl;
@property (nonatomic, strong) NSString *videoTitle;
@property (nonatomic, strong) NSString *videoImage;
@property (nonatomic, strong) NSString *nextId;
@property (assign) float timeRecord;//观看记录时间，如果不用记录，默认为0
@property(strong,nonatomic)     AVPlayerItemVideoOutput* videoOutput;
@property(strong,nonatomic)  AVPlayer  * player;
@property(strong,nonatomic)   AVPlayerItem  * playerItem;



//-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSURL*)url;
-(CVPixelBufferRef) retrievePixelBufferToDraw;
-(void) toggleControls;
-(void)play;
- (void)updateFullScreenConstraint;
- (void)playButtonTouched:(UIButton *)sender;
//- (void)updateEmbedConstraint;
+ (HTY360PlayerVC *)sharedInstance;
-(void)hty360Play;
@end
