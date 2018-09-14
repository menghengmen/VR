//
//  HTY360PlayerVC.m
//  HTY360Player
//
//  Created by  on 11/8/15.
//  Copyright © 2015 Hanton. All rights reserved.
//

#import "HTY360PlayerVC.h"
#import "HTYGLKVC.h"
#import "Masonry.h"
//#import "UIFactory.h"
#import "UIImage+ResizeImage.h"

#import "JGProgressHUD.h"
#define ONE_FRAME_DURATION 0.03

#define HIDE_CONTROL_DELAY 5.0f
#define DEFAULT_VIEW_ALPHA 1.0f

#import <MediaPlayer/MediaPlayer.h>

#import "Reachability.h"

#import "PlayerGuideView.h"

#import "playLoadingView.h"
typedef NS_ENUM(NSUInteger,PanDireation){
    
    PanDireationHorizontalMoved, //横向拖动
    PanDireationVerticalMoved   //纵向拖动
    
    
};


NSString * const kTracksKey         = @"tracks";
NSString * const kPlayableKey		= @"playable";
NSString * const kRateKey			= @"rate";
NSString * const kCurrentItemKey	= @"currentItem";
NSString * const kStatusKey         = @"status";

static void *AVPlayerDemoPlaybackViewControllerRateObservationContext = &AVPlayerDemoPlaybackViewControllerRateObservationContext;
static void *AVPlayerDemoPlaybackViewControllerCurrentItemObservationContext = &AVPlayerDemoPlaybackViewControllerCurrentItemObservationContext;
static void *AVPlayerDemoPlaybackViewControllerStatusObservationContext = &AVPlayerDemoPlaybackViewControllerStatusObservationContext;
static void *AVPlayerItemStatusContext = &AVPlayerItemStatusContext;

@interface HTY360PlayerVC () <UIGestureRecognizerDelegate,PlayGuideViewDelegate,loadViewDelegate>{
    HTYGLKVC *_glkViewController;
    HTYGLKVC *_glkViewController2;
    
    AVPlayerItemVideoOutput* _videoOutput;
    AVPlayer* _player;
    AVPlayerItem* _playerItem;
    dispatch_queue_t _myVideoOutputQueue;
    id _notificationToken;
    id _timeObserver;
    
    float mRestoreAfterScrubbingRate;
    BOOL seekToZeroBeforePlay;
    UILabel * titleLabel;
    AVURLAsset *asset;
    NSString* isUsingMotion;
    NSString* isDoubleScreen;
    
    
    JGProgressHUD *HUD;
// 蒙版
      UIView  *  backgroundView;

    playLoadingView  * PlayLoadView;

}

@property (strong, nonatomic) UISlider *progressSlider;
@property (strong, nonatomic) UIProgressView * progressView;
//底部的进度条
@property (strong, nonatomic) UIProgressView * bottomProgressView;



@property (strong, nonatomic) UIButton *gyroButton;
@property (strong, nonatomic) UIButton *screenButton;
@property (strong, nonatomic) UIButton *favoriteButton;
@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIButton *playPauseButton;
@property (nonatomic, strong) UILabel *timeElapsedLabel;
@property (nonatomic, strong) UILabel *timeRemainingLabel;
/** 定义一个实例变量，保存枚举值 */

@property  (nonatomic,assign)  PanDireation   panDireaation;

/** 滑杆 */
@property (nonatomic, strong) UISlider  *volumeViewSlider;
/** 滑杆 */
@property (nonatomic, strong) UISlider  *BrightViewSlider;





/** 音量进度 */
@property (nonatomic,strong) UIProgressView   *volumeProgress;

/** 音量进度 */
@property (nonatomic,strong) UIProgressView   *BrightProgress;

@property (nonatomic, strong) Reachability *conn;

@end

@implementation HTY360PlayerVC
+ (HTY360PlayerVC *)sharedInstance
{
    static HTY360PlayerVC * hty360 = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        hty360 = [[self alloc] init];
    });
    return hty360;
}

-(HTY360PlayerVC *)init
{
    if (self = [super init]) {
        _externalVideo = NO;

        
              
        //        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(applicationWillResignActive:)
//                                                     name:UIApplicationWillResignActiveNotification
//                                                   object:nil];
//       
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidBecomeActive:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneCome1) name:@"phoneCome"  object:nil];
        
        
        //        [[NSNotificationCenter defaultCenter] addObserver:self
        //                                                 selector:@selector(canPlay:)
        //                                                     name:AVPlayerItemNewAccessLogEntryNotification
        //                                                   object:nil];
        //
        //        [[NSNotificationCenter defaultCenter] addObserver:self
        //                                                 selector:@selector(paused:)
        //                                                     name:AVPlayerItemPlaybackStalledNotification
        //                                                   object:nil];
        
        
        
        
        
        //拖动手势 PanRecognizer
        _panRecognizer = [[UIPanGestureRecognizer alloc]
                          initWithTarget:self
                          action:@selector(handlePan:)];
        _panRecognizer.maximumNumberOfTouches = 1;
        _panRecognizer.delegate = self;
        [self setupVideoPlaybackForURL:_videoURL];
        [self configureGLKView];
               double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [_player seekToTime:CMTimeMakeWithSeconds(_timeRecord, NSEC_PER_SEC)];
        });
        [self setup];
        [self updateFullScreenConstraint];
#if SHOW_DEBUG_LABEL
        self.debugView.hidden = NO;
#endif
        
        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    
    NSUserDefaults* tUserDef = [NSUserDefaults standardUserDefaults];
    NSString* tStr = [tUserDef objectForKey:FIRSTPLAY];
    if ([tStr length] <= 0){
        return;
    }
    
    
   
    playLoadingView  * loadView = [[playLoadingView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) withTitleStr:self.videoTitle];
    loadView.delegate = self;
    loadView.backgroundColor = [UIColor blackColor];
    PlayLoadView = loadView;
    [self.view addSubview:loadView];
    
    //缓冲动画
   // HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
//    
//    //HUD.textLabel.text = @"正在加载，请稍后...";
//    HUD.userInteractionEnabled = NO;
//    [HUD showInView:loadView];


}
# pragma mark -
# pragma mark loadViewDelegate
-(void)didClickBackBtn{

    [self backButtonTouched:nil];

}
-(void)viewDidLoad {
    [super viewDidLoad];
   
  
    
    
    _bottomProgressView.alpha = 0.0;
    
    //网络监测
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    self.conn = [Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
    
    

    
}
- (void)networkStateChange
{
    [self checkNetworkState];
}
- (void)checkNetworkState
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        //        DDLogInfo(@"有wifi");
        
    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        // [self showHint:@"你当前正在使用移动网络" yOffset:-300 :4];
       // [self showHint:@"你当前正在使用移动网络"];
        
    } else { // 没有网络
       // [self showHint:@"无网络连接" yOffset:-150 : 4];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;
    
   

    
    [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;
    
    NSUserDefaults* tUserDef = [NSUserDefaults standardUserDefaults];
    NSString* tStr = [tUserDef objectForKey:FIRSTPLAY];
    if ([tStr length] <= 0) {
       
        
        
        //蒙版
        backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0.6;
        [self.view addSubview:backgroundView];
        
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(backgroundView.superview);
        }];
        
        //暂停视频
        _playPauseButton.selected  =![self isPlaying];
        if ([self isPlaying]) {
            [self pause];
        }else{
            [self play];
        }
        
        
        
        
        PlayerGuideView * playerGuideView = [[PlayerGuideView alloc] init];
        playerGuideView.delegate = self;
        playerGuideView.kind = 2;
        [self.view addSubview:playerGuideView];
        [playerGuideView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(playerGuideView.superview);
        }];
        [playerGuideView animationBegin:2];


        
    }

    
    //    //默认陀螺仪开启，
   isUsingMotion = [tUserDef objectForKey:@"motion"];
    if ([isUsingMotion isEqualToString:@"NO"])
    {
        _glkViewController.isUsingMotion = YES;
        _glkViewController2.isUsingMotion = YES;
        [self gyroButtonTouched:_gyroButton];
        
    }else{
        _glkViewController.isUsingMotion = NO;
        _glkViewController2.isUsingMotion = NO;
        [self gyroButtonTouched:_gyroButton];
    }
    
    isDoubleScreen = [tUserDef objectForKey:@"motion"];
    if ([isDoubleScreen isEqualToString:@"YES"])
        
    {
        _screenButton.selected = YES;
        [self screenButtonTouched:_screenButton];
        
    }else{
        //_screenButton.selected = NO;
    }
    
    [self hty360Play];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)guideDidEnd{
    [backgroundView removeFromSuperview];
    _playPauseButton.selected = ![self isPlaying];
    [self play];



}


- (void)canPlay:(NSNotification *)notify {
    LRLog(@"canPlay:");
    if(![self isPlaying]&& _playPauseButton.selected)
    {
        [self play];
    }
}

- (void)paused:(NSNotification *)notify {
    LRLog(@"paused:");
}

-(void)handlePan:(UIPanGestureRecognizer*)recognizer
{
    NSLog(@"拖动操作");
    //处理拖动操作,拖动是基于imageview，如果经过旋转，拖动方向也是相对imageview上下左右移动，而不是屏幕对上下左右
    CGPoint translation = [recognizer translationInView:self.view];
    float delta = translation.y/1000;
    NSLog(@"delta :%f",delta);
    
    
    
}

- (void)applicationWillResignActive:(NSNotification *)notification {
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemNewAccessLogEntryNotification object:nil];
    //
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemPlaybackStalledNotification object:nil];
    
    _playPauseButton.selected=![self isPlaying];
    
    if([self isPlaying])
    {
        [self pause];
    }else{
        
        [self play];
    }
    
    
}
- (void)phoneCome1{
    
    _playPauseButton.selected = ![self  isPlaying];
    [self pause];


}
- (void)applicationDidBecomeActive:(NSNotification *)notification {
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(canPlay:)
    //                                                 name:AVPlayerItemNewAccessLogEntryNotification
    //                                               object:nil];
    //
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(paused:)
    //                                                 name:AVPlayerItemPlaybackStalledNotification
    //                                               object:nil];
    if([self isPlaying])
    {
        [_player seekToTime:[_player currentTime]];
        [self play];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    
}



- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
- (BOOL)shouldAutorotate{
    
    return NO;
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
}


#pragma mark video communication

- (CVPixelBufferRef)retrievePixelBufferToDraw {
    CVPixelBufferRef pixelBuffer = [_videoOutput copyPixelBufferForItemTime:[_playerItem currentTime] itemTimeForDisplay:nil];
    
    return pixelBuffer;
}

#pragma mark video setting

-(void)setupVideoPlaybackForURL:(NSURL*)url {
    
    NSDictionary *pixBuffAttributes = @{(id)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange)};
    _videoOutput = [[AVPlayerItemVideoOutput alloc] initWithPixelBufferAttributes:pixBuffAttributes];
    _myVideoOutputQueue = dispatch_queue_create("myVideoOutputQueue", DISPATCH_QUEUE_SERIAL);
    [_videoOutput setDelegate:self queue:_myVideoOutputQueue];
    
    if(_player == nil)
    {
        _player = [[AVPlayer alloc] init];
    }
    [_player replaceCurrentItemWithPlayerItem:nil];
    // Do not take mute button into account
    NSError *error = nil;
    BOOL success = [[AVAudioSession sharedInstance]
                    setCategory:AVAudioSessionCategoryPlayback
                    error:&error];
    if (!success) {
        NSLog(@"Could not use AVAudioSessionCategoryPlayback", nil);
    }
    
    asset = [AVURLAsset URLAssetWithURL:url options:nil];
    
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:[[asset URL] path]]) {
        NSLog(@"file does not exist");
    }
    
    NSArray *requestedKeys = [NSArray arrayWithObjects:kTracksKey, kPlayableKey, nil];
    
    [asset loadValuesAsynchronouslyForKeys:requestedKeys completionHandler:^{
        
        //        dispatch_async( dispatch_get_main_queue(),
        //                       ^{
        /* Make sure that the value of each key has loaded successfully. */
        for (NSString *thisKey in requestedKeys) {
            NSError *error = nil;
            AVKeyValueStatus keyStatus = [asset statusOfValueForKey:thisKey error:&error];
            if (keyStatus == AVKeyValueStatusFailed) {
                [self assetFailedToPrepareForPlayback:error];
                return;
            }
        }
        
        NSError* error = nil;
        AVKeyValueStatus status = [asset statusOfValueForKey:kTracksKey error:&error];
        if (status == AVKeyValueStatusLoaded) {
            _playerItem = [AVPlayerItem playerItemWithAsset:asset];
            
            
            
            [_playerItem addOutput:_videoOutput];
            [_player replaceCurrentItemWithPlayerItem:_playerItem];
            [_videoOutput requestNotificationOfMediaDataChangeWithAdvanceInterval:ONE_FRAME_DURATION];
            
            /* When the player item has played to its end time we'll toggle
             the movie controller Pause button to be the Play button */
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(playerItemDidReachEnd:)
                                                         name:AVPlayerItemDidPlayToEndTimeNotification
                                                       object:_playerItem];
            
            seekToZeroBeforePlay = NO;
            //[_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
            [_playerItem addObserver:self
                          forKeyPath:kStatusKey
                             options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                             context:AVPlayerDemoPlaybackViewControllerStatusObservationContext];
            
            [_player addObserver:self
                      forKeyPath:kCurrentItemKey
                         options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                         context:AVPlayerDemoPlaybackViewControllerCurrentItemObservationContext];
            
            [_player addObserver:self
                      forKeyPath:kRateKey
                         options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                         context:AVPlayerDemoPlaybackViewControllerRateObservationContext];
            
            
            [self initScrubberTimer];
            [self syncScrubber];
        }
        else {
            NSLog(@"%@ Failed to load the tracks.", self);
        }
        //                       });
    }];
}

#pragma mark rendering glk view management

-(void)configureGLKView {
    _glkViewController = [[HTYGLKVC alloc] init];
    
    _glkViewController.videoPlayerController = self;
    
    [self.view addSubview:_glkViewController.view];
    [self addChildViewController:_glkViewController];
    [_glkViewController didMoveToParentViewController:self];
    //_glkViewController.view.frame = self.view.bounds;
    [_glkViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(_glkViewController.view.superview);
        make.width.equalTo(@(SCREENHEIGHT/2));
        
        
        
    }];
    
    _glkViewController2 = [[HTYGLKVC alloc] init];
    
    _glkViewController2
    .videoPlayerController = self;
    
    [self.view addSubview:_glkViewController2.view];
    [self addChildViewController:_glkViewController2];
    [_glkViewController2 didMoveToParentViewController:self];
    //_glkViewController.view.frame = self.view.bounds;
    [_glkViewController2.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_glkViewController2.view.superview);
    }];
    //    _glkViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 320);
    
}

#pragma mark play button management

- (void)playButtonTouched:(UIButton *)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self scheduleHideControls];
    sender.selected = ![self isPlaying];
    if ([self isPlaying]) {
        [self pause];
    } else {
        [self play];
    }
}

-(void)play {
    if ([self isPlaying])
        return;
    /* If we are at the end of the movie, we must seek to the beginning first
     before starting playback. */
    if (YES == seekToZeroBeforePlay) {
        seekToZeroBeforePlay = NO;
        [_player seekToTime:kCMTimeZero];
    }
    [_player play];
    
    //[self scheduleHideControls];
}

- (void)pause {
    if (![self isPlaying])
        return;
    [_player pause];
    
    //[self scheduleHideControls];
}

#pragma mark controls management

-(void)toggleControls {
    if(_topBar.hidden){
        [self showControlsFast];
    }else{
        [self hideControlsFast];
    }
    
    [self scheduleHideControls];
}

-(void)scheduleHideControls {
    if(!_topBar.hidden) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(hideControlsSlowly) withObject:nil afterDelay:HIDE_CONTROL_DELAY];
    }
}

-(void)hideControlsWithDuration:(NSTimeInterval)duration {
    _topBar.alpha = DEFAULT_VIEW_ALPHA;
    _bottomBar.alpha = DEFAULT_VIEW_ALPHA;
    
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^(void) {
                         
                         _topBar.alpha = 0.0f;
                         _bottomBar.alpha = 0.0f;
                         _bottomProgressView.alpha = DEFAULT_VIEW_ALPHA;
                         
                         
                     }
                     completion:^(BOOL finished){
                         if(finished)
                             _topBar.hidden = YES;
                         _bottomBar.hidden = YES;
                         [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
                         
                     }];
    
}

-(void)hideControlsFast {
    [self hideControlsWithDuration:0.2];
}

-(void)hideControlsSlowly {
    [self hideControlsWithDuration:0.3];
}

-(void)showControlsFast {
    _topBar.alpha = 0.0;
    _topBar.hidden = NO;
    _bottomBar.alpha = 0.0;
    _bottomBar.hidden = NO;
    
    //隐藏底部进度条
    _bottomProgressView.alpha = 0.0;
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^(void) {
                         _topBar.alpha = DEFAULT_VIEW_ALPHA;
                         
                         _bottomBar.alpha = DEFAULT_VIEW_ALPHA;
                         
                     }
                     completion:nil];
}

- (void)removeTimeObserverFro_player {
    if (_timeObserver) {
        [_player removeTimeObserver:_timeObserver];
        _timeObserver = nil;
    }
}

#pragma mark slider progress management

-(void)initScrubberTimer {
    double interval = .1f;
    
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration)) {
        return;
    }
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration)) {
        CGFloat width = CGRectGetWidth([_progressSlider bounds]);
        interval = 0.5f * duration / width;
    }
    
    
    __weak HTY360PlayerVC* weakSelf = self;
    _timeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(interval, NSEC_PER_SEC)
                                                          queue:NULL /* If you pass NULL, the main queue is used. */
                                                     usingBlock:^(CMTime time)
                     {
                         [weakSelf syncScrubber];
                     }];
    
}

- (CMTime)playerItemDuration {
    
    if (_playerItem.status == AVPlayerItemStatusReadyToPlay) {
        /*
         NOTE:
         Because of the dynamic nature of HTTP Live Streaming Media, the best practice
         for obtaining the duration of an AVPlayerItem object has changed in iOS 4.3.
         Prior to iOS 4.3, you would obtain the duration of a player item by fetching
         the value of the duration property of its associated AVAsset object. However,
         note that for HTTP Live Streaming Media the duration of a player item during
         any particular playback session may differ from the duration of its asset. For
         this reason a new key-value observable duration property has been defined on
         AVPlayerItem.
         
         See the AV Foundation Release Notes for iOS 4.3 for more information.
         */
        
        return([_playerItem duration]);
    }
    
    return(kCMTimeInvalid);
}

- (void)syncScrubber {
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration)) {
        _progressSlider.minimumValue = 0.0;
        return;
    }
    
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration)) {
        float minValue = [_progressSlider minimumValue];
        float maxValue = [_progressSlider maximumValue];
        double time = CMTimeGetSeconds([_player currentTime]);
        //DDLogInfo(@"htytime:%lld,%d",_player.currentTime.value,_player.currentTime.timescale);
        
        //DDLogInfo(@"htytime:%f",time);
        [_progressSlider setValue:(maxValue - minValue) * time / duration + minValue];
        [_bottomProgressView setProgress:(maxValue - minValue) * time / duration + minValue];
        
        [self setTimeLabelValues:time totalTime:duration];
   

    }
    
    //if ([path isEqualToString:@"loadedTimeRanges"]) {
    NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
    //DDLogInfo(@"Time Interval:%f",timeInterval);
    CMTime duration2 = _playerItem.duration;
    CGFloat totalDuration = CMTimeGetSeconds(duration2);
    [_progressView setProgress:timeInterval / totalDuration animated:NO];
    HUD.alpha = 0;

    
    //}
    
    
    
}
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}


/* The user is dragging the movie controller thumb to scrub through the movie. */
- (void)beginScrubbing:(id)sender
{
    mRestoreAfterScrubbingRate = [_player rate];
    [_player setRate:0.f];
    
    /* Remove previous timer. */
    [self removeTimeObserverFro_player];
}

/* Set the player current time to match the scrubber position. */
- (void)setTimeLabelValues:(int)currentTime totalTime:(int)totalTime {
    //加载动画消失
    [PlayLoadView removeFromSuperview];
    //HUD.alpha = 0;
    self.timeElapsedLabel.text = [NSString stringWithFormat:@"%@/",[self timeToString:currentTime]];
    self.timeRemainingLabel.text = [NSString stringWithFormat:@"%@",[self timeToString:totalTime]];
    
    
}

- (NSString *)timeToString:(int)time {
    int seconds = time%60;
    int minutes = time%3600/60;
    int hours = time/3600.0;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minutes,seconds];
    
}

- (void)scrub:(id)sender
{
    if ([sender isKindOfClass:[UISlider class]]) {
        
        HUD.alpha = 1;
        
        UISlider* slider = sender;
        
        CMTime playerDuration = [self playerItemDuration];
        if (CMTIME_IS_INVALID(playerDuration)) {
            return;
        }
        
        double duration = CMTimeGetSeconds(playerDuration);
        if (isfinite(duration)) {
            float minValue = [slider minimumValue];
            float maxValue = [slider maximumValue];
            float value = [slider value];
            
            double time = duration * (value - minValue) / (maxValue - minValue);
            
            [_player seekToTime:CMTimeMakeWithSeconds(time, NSEC_PER_SEC)];
            //NSLog(@"hehe1htytime:%lld,%d",_player.currentTime.value,_player.currentTime.timescale);
        }
    }
}

/* The user has released the movie thumb control to stop scrubbing through the movie. */
- (void)endScrubbing:(id)sender {
    if (!_timeObserver) {
        CMTime playerDuration = [self playerItemDuration];
        if (CMTIME_IS_INVALID(playerDuration)) {
            return;
        }
        
        double duration = CMTimeGetSeconds(playerDuration);
        if (isfinite(duration)) {
            CGFloat width = CGRectGetWidth([_progressSlider bounds]);
            double tolerance = 0.5f * duration / width;

            __weak HTY360PlayerVC* weakSelf = self;
            _timeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(tolerance, NSEC_PER_SEC) queue:NULL usingBlock:
                             ^(CMTime time)
                             {
                                 [weakSelf syncScrubber];
                             }];
        }
    }
    
    if (mRestoreAfterScrubbingRate) {
        [_player setRate:mRestoreAfterScrubbingRate];
        mRestoreAfterScrubbingRate = 0.f;
    }
}

- (BOOL)isScrubbing {
    return mRestoreAfterScrubbingRate != 0.f;
}

-(void)enableScrubber {
    _progressSlider.enabled = YES;
}

-(void)disableScrubber {
    _progressSlider.enabled = NO;
}

- (void)observeValueForKeyPath:(NSString*) path
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context {
    /* AVPlayerItem "status" property value observer. */
    if (context == AVPlayerDemoPlaybackViewControllerStatusObservationContext) {
        
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status) {
                /* Indicates that the status of the player is not yet known because
                 it has not tried to load new media resources for playback */
            case AVPlayerStatusUnknown: {
                [self removePlayerTimeObserver];
                [self syncScrubber];
                
                [self disableScrubber];
                
            }
                break;
                
            case AVPlayerStatusReadyToPlay: {
                /* Once the AVPlayerItem becomes ready to play, i.e.
                 [playerItem status] == AVPlayerItemStatusReadyToPlay,
                 its duration can be fetched from the item. */
                
                [self initScrubberTimer];
                
                [self enableScrubber];
            }
                break;
                
            case AVPlayerStatusFailed: {
                AVPlayerItem *playerItem = (AVPlayerItem *)object;
                //                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"视频地址有误，无法播放" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //                [alert show];
                [self assetFailedToPrepareForPlayback:playerItem.error];
                //NSLog(@"Error fail : %@", playerItem.error);
            }
                break;
        }
    } else if (context == AVPlayerDemoPlaybackViewControllerRateObservationContext) {
        // NSLog(@"AVPlayerDemoPlaybackViewControllerRateObservationContext");
    }
    
    /* AVPlayer "currentItem" property observer.
     Called when the AVPlayer replaceCurrentItemWithPlayerItem:
     replacement will/did occur. */
    else if (context == AVPlayerDemoPlaybackViewControllerCurrentItemObservationContext) {
        //NSLog(@"AVPlayerDemoPlaybackViewControllerCurrentItemObservationContext");
    }
    else {
        [super observeValueForKeyPath:path ofObject:object change:change context:context];
    }
}
//
-(void)assetFailedToPrepareForPlayback:(NSError *)error {
    [self removePlayerTimeObserver];
    [self syncScrubber];
    [self disableScrubber];
    
    /* Display the error. */
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:[error localizedDescription]
                                          message:[error localizedFailureReason]
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (BOOL)isPlaying {
    return mRestoreAfterScrubbingRate != 0.f || [_player rate] != 0.f;
}

/* Called when the player item has played to its end time. */
- (void)playerItemDidReachEnd:(NSNotification *)notification {
    /* After the movie has played to its end time, seek back to time zero
     to play it again. */
    seekToZeroBeforePlay = YES;
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemNewAccessLogEntryNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemPlaybackStalledNotification object:nil];
    
    if (!_externalVideo) {
        //        playEndView = [[PlayEndView alloc] initWithChannelID:_vid];
        //        playEndView.delegate = self;
        //        [self.view addSubview:playEndView];
        //        [playEndView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.edges.equalTo(playEndView.superview);
        //        }];
    }else
    {
        [self backButtonTouched:nil];
    }
    
}

# pragma mark -
# pragma mark 陀螺仪手势切换
- (IBAction)gyroButtonTouched:(id)sender {
    NSUserDefaults* tUserDef = [NSUserDefaults standardUserDefaults];
    
    if(_glkViewController.isUsingMotion) {
        NSUserDefaults* tUserDef = [NSUserDefaults standardUserDefaults];
        NSString* tStr = [tUserDef objectForKey:FIRSTPLAY];
        if ([tStr length] <= 0) {
            
            
            //蒙版
            backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
            backgroundView.backgroundColor = [UIColor blackColor];
            backgroundView.alpha = 0.6;
            [self.view addSubview:backgroundView];
            
            [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(backgroundView.superview);
            }];
            
            //暂停视频
            _playPauseButton.selected  =![self isPlaying];
            if ([self isPlaying]) {
                [self pause];
            }else{
                [self play];
            }

            
            
            
            
            PlayerGuideView * playerGuideView = [[PlayerGuideView alloc] init];
                        playerGuideView.delegate = self;
                        playerGuideView.kind = 1;
                        [self.view addSubview:playerGuideView];
                        [playerGuideView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.edges.equalTo(playerGuideView.superview);
                        }];
                        [playerGuideView animationBegin:1];
        }else{
            
        }
        [_glkViewController stopDeviceMotion];
        isUsingMotion = @"NO";
    } else {
        [_glkViewController startDeviceMotion];
        isUsingMotion = @"YES";
        LRLog(@"陀螺仪开启");
        
        
        
        
        
        
    }
    [tUserDef setObject:isUsingMotion forKey:@"motion"];
    [tUserDef synchronize];
    _gyroButton.selected = _glkViewController.isUsingMotion;
    
    if(_glkViewController2.isUsingMotion) {
        [_glkViewController2 stopDeviceMotion];
    } else {
        [_glkViewController2 startDeviceMotion];
    }
    
    _gyroButton.selected = _glkViewController2.isUsingMotion;
}

#pragma mark back button 退出播放器

- (IBAction)backButtonTouched:(id)sender {
    [self removePlayerTimeObserver];
    [_playerItem removeOutput:_videoOutput];
    //    _playerItem = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemNewAccessLogEntryNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemPlaybackStalledNotification object:nil];
    
    [_player pause];
    
    //    [_glkViewController removeFromParentViewController];
    //    _glkViewController = nil;
    //
    //    [_glkViewController2 removeFromParentViewController];
    //    _glkViewController2 = nil;
    NSDate *timeDate = [[NSDate alloc] init];
    long long longTime = [timeDate timeIntervalSince1970] * 1000;
    float playTime;
    if(isnan(CMTimeGetSeconds([_player currentTime])))
    {
        playTime = 0;
    }else
    {
        playTime =CMTimeGetSeconds([_player currentTime]);
    }
    LRLog(@"播放记录%f",playTime);
    
    if(_externalVideo == NO)
    {
        //        [UserInfoRequest RequestAddWatchRecorduserToken:globeObject.loginModel.user_token videoId:_vid playTime:playTime creatTime:longTime success:^(NSDictionary *tJsonDic)
        //        {
        //
        //        } fail:^(NSDictionary *tJsonDic) {
        //
        //        }];
    }
    
    
    
    
    
    //    @try {
    //        [self removePlayerTimeObserver];
    //        [_playerItem removeObserver:self forKeyPath:kStatusKey];
    //        [_playerItem removeOutput:_videoOutput];
    //        [_player removeObserver:self forKeyPath:kCurrentItemKey];
    //        [_player removeObserver:self forKeyPath:kRateKey];
    //    } @catch(id anException) {
    //        //do nothing
    //
    //        DDLogInfo(@"没有清理成功");
    //    }
    //    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    //
    //    _videoOutput = nil;
    //    _playerItem = nil;
    //    _player = nil;
    //[NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControlsSlowly) object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControlsFast) object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(scheduleHideControls) object:nil];
    [ [ UIApplication sharedApplication] setIdleTimerDisabled:NO ] ;
    [self performSelector:@selector(showControlsFast) withObject:nil afterDelay:0.5 ];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    [PlayLoadView removeFromSuperview];
    [self userJudge];
    [HUD dismiss];
}

-(void)userJudge{
    dispatch_queue_t queue  = dispatch_queue_create("UserJudge", DISPATCH_QUEUE_SERIAL);;
    dispatch_async(queue, ^{
        NSString *localCount = [XDCommonTool readStringFromUserDefaultWithKey:UserJudgeCount];
        if (localCount) {
            [XDCommonTool saveToUserDefaultWithString:[NSString stringWithFormat:@"%ld",[localCount integerValue]+1] key:UserJudgeCount];
        }else{
            
            [XDCommonTool saveToUserDefaultWithString:@"1" key:UserJudgeCount];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[XDCommonTool readStringFromUserDefaultWithKey:UserJudgeCount] integerValue] == 3) {
                [[NSNotificationCenter defaultCenter]postNotificationName:USERJUDGE_NOTFITICSTION object:nil];
            }
        });
    });
}

/* Cancels the previously registered time observer. */
-(void)removePlayerTimeObserver {
    if (_timeObserver) {
        [_player removeTimeObserver:_timeObserver];
        _timeObserver = nil;
    }
}

- (void)setup {
    //top bar
    _topBar = [[UIView alloc] init];
    _topBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"player_mengceng.png"]];
    //    _topBar.alpha = 0.f;
    [self.view addSubview:_topBar];
    [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@70);
    }];
    
    
    _backBtn = [XDCommonTool newButtonWithType:UIButtonTypeCustom normalImage:@"player_back.png" buttonTitle:nil target:self action:@selector(backButtonTouched:)];
    
    [_topBar addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backBtn.superview).offset(20);
        make.left.equalTo(_backBtn.superview).offset(0);
    }];
    
    titleLabel = [XDCommonTool newlabelWithTextColor:[UIColor whiteColor] withTitle:nil fontSize:18];
    
    titleLabel.text = _videoTitle;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [_topBar addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.superview).offset(35);
        make.left.equalTo(_backBtn.superview).offset(46);
        make.height.equalTo(@18);
        make.right.equalTo(titleLabel.superview).offset(-10);
    }];
    titleLabel.shadowColor = [UIColor blackColor];
    titleLabel.shadowOffset = CGSizeMake(1, 1);
    //bottom bar
    _bottomBar = [[UIView alloc] init];
    _bottomBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"player_bottombar.png"]];
    //  _bottomBar.alpha = 0.f;
    [self.view addSubview:_bottomBar];
    [_bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    
    
    _progressSlider = [[UISlider alloc] init];
    [_progressSlider setMinimumTrackImage:[UIImage resizeImage:@"player_minimum.png"] forState:UIControlStateNormal];
    [_progressSlider setMaximumTrackImage:[UIImage resizeImage:@"player_maximum.png"] forState:UIControlStateNormal];
    [_progressSlider setThumbImage:[UIImage imageNamed:@"player_sliderthumb"] forState:UIControlStateNormal];
    _progressSlider.value = 0.f;
    _progressSlider.continuous = YES;
    [_progressSlider addTarget:self action:@selector(scrub:) forControlEvents:UIControlEventValueChanged];
    [_progressSlider addTarget:self action:@selector(beginScrubbing:) forControlEvents:UIControlEventTouchDown];
    [_progressSlider addTarget:self action:@selector(endScrubbing:) forControlEvents:UIControlEventTouchUpInside];
    [_progressSlider addTarget:self action:@selector(endScrubbing:) forControlEvents:UIControlEventTouchUpOutside];
    
    _progressView = [UIProgressView new];
    _progressView.progressImage = [UIImage resizeImage:@"player_buffer.png"];
    _progressView.trackImage = [UIImage resizeImage:@"player_track.png"];
    //底部进度条
    _bottomProgressView = [UIProgressView new];
    _bottomProgressView.alpha = 0.0;
    [self.view addSubview:_bottomProgressView];
    
    
    
    
    
    _timeElapsedLabel = [[UILabel alloc] init];
    _timeElapsedLabel.backgroundColor = [UIColor clearColor];
    _timeElapsedLabel.font = [UIFont systemFontOfSize:12.f];
    _timeElapsedLabel.textColor = [UIColor whiteColor];
    _timeElapsedLabel.textAlignment = NSTextAlignmentRight;
    _timeElapsedLabel.text = @"00:00:00";
    _timeElapsedLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    _timeElapsedLabel.layer.shadowRadius = 1.f;
    _timeElapsedLabel.layer.shadowOffset = CGSizeMake(1.f, 1.f);
    _timeElapsedLabel.layer.shadowOpacity = 0.8f;
    
    _timeRemainingLabel = [[UILabel alloc] init];
    _timeRemainingLabel.backgroundColor = [UIColor clearColor];
    _timeRemainingLabel.font = [UIFont systemFontOfSize:12.f];
    _timeRemainingLabel.textColor = [UIColor colorWithRed:85 green:85 blue:85 alpha:1];
    _timeRemainingLabel.textAlignment = NSTextAlignmentLeft;
    _timeRemainingLabel.text = @"/00:00:00";
    _timeRemainingLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    _timeRemainingLabel.layer.shadowRadius = 1.f;
    _timeRemainingLabel.layer.shadowOffset = CGSizeMake(1.f, 1.f);
    _timeRemainingLabel.layer.shadowOpacity = 0.8f;
    
    
    _playPauseButton = [[UIButton alloc] init];
    [_playPauseButton setImage:[UIImage imageNamed:@"player_play.png"] forState:UIControlStateNormal];
    [_playPauseButton setImage:[UIImage imageNamed:@"player_pause.png"] forState:UIControlStateSelected];
    //[_playPauseButton setSelected:_moviePlayer.playbackState == MPMoviePlaybackStatePlaying ? NO : YES];
    [_playPauseButton addTarget:self action:@selector(playButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    //_playPauseButton.delegate = self;
    NSLog(@"hehehtytime:%lld,%d",_player.currentTime.value,_player.currentTime.timescale);
    _gyroButton = [[UIButton alloc] init];
    [_gyroButton setImage:[UIImage imageNamed:@"gyro_btn.png"] forState:UIControlStateNormal];
    [_gyroButton setImage:[UIImage imageNamed:@"gyro_selected_btn.png"] forState:UIControlStateSelected];
    [_gyroButton addTarget:self action:@selector(gyroButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    _gyroButton.selected = YES;
    _screenButton = [[UIButton alloc] init];
    [_screenButton setImage:[UIImage imageNamed:@"screen_btn.png"] forState:UIControlStateNormal];
    [_screenButton setImage:[UIImage imageNamed:@"screen_selected_btn.png"] forState:UIControlStateSelected];
    [_screenButton addTarget:self action:@selector(screenButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    _screenButton.selected = NO;
    _favoriteButton = [[UIButton alloc] init];
    [_favoriteButton setImage:[UIImage imageNamed:@"player_favorite.png"] forState:UIControlStateNormal];
    [_favoriteButton setImage:[UIImage imageNamed:@"player_selected_favorite.png"] forState:UIControlStateSelected];
    [_favoriteButton addTarget:self action:@selector(favoriteButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    _favoriteButton.hidden = YES;
    if (_isFavorite == 1) {
        _favoriteButton.selected = YES;
    }else
    {
        _favoriteButton.selected = NO;
    }
    [_topBar addSubview:_backBtn];
    [_bottomBar addSubview:_playPauseButton];
    [_bottomBar addSubview:_timeElapsedLabel];
    [_bottomBar addSubview:_timeRemainingLabel];
    [_bottomBar addSubview:_gyroButton];
    [_bottomBar addSubview:_screenButton];
    [_bottomBar addSubview:_favoriteButton];
    [_bottomBar addSubview:_progressView];
    [_bottomBar addSubview:_progressSlider];
    
    
    
}

//- (void)favoriteButtonTouched:(UIButton *)sender {
//    MBProManager* tMBManager = [MBProManager shareInstance];
//    GlobeObject * globe = [GlobeObject sharedInstance];
//    NSLog(@"userToken:%@",globe.loginModel.user_token);
//    if ([globe.loginModel.user_token length] <=0) {
//        LoginViewController * vc = [LoginViewController new];
//        [vc setBlock:^{
//            //用个人信息刷新UI
//            // 不让点击登录
//        }];
//        [self presentViewController:vc animated:YES completion:nil];        return;
//    }
//    if (_isFavorite == 1) {
////        [MineRequest RequestDelCollectionWithuserToken:globe.loginModel.user_token vids:[NSString stringWithFormat:@"%d",_vid] success:^(NSDictionary *tJsonDic) {
////            _favoriteButton.selected = NO;
////            _isFavorite = 0;
////
////            [tMBManager showHubAutoDiss:@"取消收藏成功" titleText:nil AferTime:1.f containerView:self.view];
//        } fail:^(NSDictionary *tJsonDic) {
//
//        }];
//    }else
//    {
////        [MineRequest RequestAddCollectionWithuserToken:globe.loginModel.user_token vid:_vid success:^(NSDictionary *tJsonDic) {
////            _favoriteButton.selected = YES;
////            _isFavorite = 1;
////            [tMBManager showHubAutoDiss:@"收藏成功" titleText:nil AferTime:1.f containerView:self.view];
//
//        } fail:^(NSDictionary *tJsonDic) {
//
//        }];
//    }
//}



# pragma mark -
# pragma mark 单双屏切换

//单双屏切换
- (void)screenButtonTouched:(UIButton *)sender {
    sender.selected = !sender.selected;
    _glkViewController.isUsingTwoScreen =sender.selected;
    _glkViewController2.isUsingTwoScreen =sender.selected;
    NSUserDefaults* tUserDef = [NSUserDefaults standardUserDefaults];
    
    if (sender.selected) {
        //        [_glkViewController stopDeviceMotion];
        //        [_glkViewController2 stopDeviceMotion];
        //        [self gyroButtonTouched:_gyroButton];
        //_gyroButton.enabled = NO;
        [_glkViewController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(_glkViewController.view.superview);
            make.width.equalTo(@(SCREENWIDTH/2));
            //左右横屏
            
            //            make.top.left.right.equalTo(_glkViewController.view.superview);
            //            make.height.equalTo(@(SCREENH_HEIGHT/2));
            //上下屏
            
            
        }];
        
        [_glkViewController2.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(_glkViewController2.view.superview);
            make.width.equalTo(@(SCREENWIDTH/2));
            
            //上下分屏
            // make.left.right.bottom.equalTo(_glkViewController2.view.superview);
            // make.height.equalTo(@(SCREENH_HEIGHT/2));
            
            
            
        }];
        
        isDoubleScreen = @"YES";
    }else
    {
        //_gyroButton.enabled = YES;
        [_glkViewController2.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_glkViewController2.view.superview);
        }];
        isDoubleScreen = @"NO";
        
    }
    [tUserDef setObject:isDoubleScreen forKey:@"DoubleScreen"];
    [tUserDef synchronize];
    
}
- (void)updateFullScreenConstraint {
    
    
    [self.playPauseButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_playPauseButton.superview);
        make.bottom.equalTo(_playPauseButton.superview).offset(-7);
    }];
    
    [self.progressSlider mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_progressSlider.superview).offset(-25);
        make.left.equalTo(_playPauseButton.mas_right).offset(20);
        make.right.equalTo(_gyroButton.mas_left).offset(-15);
    }];
    [self.progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_progressView.superview).offset(-30);
        make.left.equalTo(_playPauseButton.mas_right).offset(20);
        make.right.equalTo(_gyroButton.mas_left).offset(-15);
        make.height.equalTo(@4);
        
    }];
    
    
    [self.bottomProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bottomProgressView.superview).offset(0);
        make.left.equalTo(_bottomProgressView.superview).offset(0);
        make.right.equalTo(_bottomProgressView.superview).offset(0);
        make.height.equalTo(@2);
        
    }];
    
    
    
    
    [self.timeElapsedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_timeElapsedLabel.superview).offset(-10);
        make.left.equalTo(_progressSlider.mas_left);
        make.width.equalTo(@60);
        make.height.equalTo(@12);
    }];
    
    [self.timeRemainingLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_timeRemainingLabel.superview).offset(-10);
        make.left.equalTo(_progressSlider.mas_left).offset(60);
        make.width.equalTo(@60);
        make.height.equalTo(@12);
    }];
    [self.screenButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_screenButton.superview);
        make.bottom.equalTo(_screenButton.superview).offset(-7);
        //        make.width.equalTo(@27);
        //        make.height.equalTo(@20);
    }];
    [self.gyroButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_screenButton.mas_left);
        make.bottom.equalTo(_gyroButton.superview).offset(-7);
        //        make.width.equalTo(@22);
        //        make.height.equalTo(@22);
    }];
    
    [self.favoriteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_gyroButton.mas_left);
        make.bottom.equalTo(_favoriteButton.superview).offset(-7);
        //        make.width.equalTo(@22);
        //        make.height.equalTo(@22);
    }];
    
    
}
# pragma mark - PlayEndViewDelegate
- (void)playEndReplay
{
    
    [self play];
}
- (void)playEndShare
{
    [self backButtonTouched:nil];
    [_delegate htyPlayerEndShare];
}
-(void)playEndBack
{
    [self backButtonTouched:nil];
}
-(void)hty360Play
{
    titleLabel.text = _videoTitle;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(canPlay:)
                                                 name:AVPlayerItemNewAccessLogEntryNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(paused:)
                                                 name:AVPlayerItemPlaybackStalledNotification
                                               object:nil];
    
    //    [_delegate htyPlayerRefer:model];
    AVURLAsset *asset2 = [AVURLAsset URLAssetWithURL:_videoURL options:nil];
    
    [_playerItem removeObserver:self forKeyPath:kStatusKey];
    
    _playerItem = [AVPlayerItem playerItemWithAsset:asset2];
    [_playerItem removeOutput:_videoOutput];
    NSDictionary *pixBuffAttributes = @{(id)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange)};
    _videoOutput = [[AVPlayerItemVideoOutput alloc] initWithPixelBufferAttributes:pixBuffAttributes];
    _myVideoOutputQueue = dispatch_queue_create("myVideoOutputQueue", DISPATCH_QUEUE_SERIAL);
    [_videoOutput setDelegate:self queue:_myVideoOutputQueue];
    
    [_playerItem addOutput:_videoOutput];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:_playerItem];
    
    [_playerItem addObserver:self
                  forKeyPath:kStatusKey
                     options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                     context:AVPlayerDemoPlaybackViewControllerStatusObservationContext];
    [_player replaceCurrentItemWithPlayerItem:_playerItem];
    [self playButtonTouched:_playPauseButton];
    
    //[_player play];
}
//播放完点击推荐视频
/*
-(void)playReferVideo:(PlayDictionaryModel *)model
{
    [playEndView removeFromSuperview];
    _videoTitle = model.title;
    _vid = model.id;
    _videoURL = [NSURL URLWithString:model.playUrl];
    [self hty360Play];
}
 */
@end
