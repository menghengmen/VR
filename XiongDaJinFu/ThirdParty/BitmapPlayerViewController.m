//
//  BitmapPlayerViewController.m
//  MD360Player4iOS
//
//  Created by ashqal on 16/5/21.
//  Copyright © 2016年 ashqal. All rights reserved.
//

#import "BitmapPlayerViewController.h"
#import "UIImage+Scale.h"

@interface BitmapPlayerViewController ()<IMDImageProvider>

@end

@implementation BitmapPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initPlayer{
    
    /////////////////////////////////////////////////////// MDVRLibrary
    MDVRConfiguration* config = [MDVRLibrary createConfig];
    
    [config displayMode:MDModeDisplayGlass];
    [config interactiveMode:MDModeInteractiveMotion];
    [config asImage:self];
    // [config asVideo:playerItem];
    [config setContainer:self view:self.view];
    [config pinchEnabled:true];
    
    self.vrLibrary = [config build];
    /////////////////////////////////////////////////////// MDVRLibrary
   
}

-(void) onProvideImage:(id<TextureCallback>)callback{
    //
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:self.mURL options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                LRLog(@"progress:%ld/%ld",receivedSize,expectedSize);
                                // progression tracking code
                                if (self.activity == nil && self.str.length <=0) {
                                    self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];//指定进度轮的大小
                                    
                                    [self.activity setCenter:CGPointMake(SCREENWIDTH/2,SCREENHEIGHT/2)];//指定进度轮中心点
                                    //                                self.activity.backgroundColor = [UIColor whiteColor];
                                    [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置进度轮显示类型
                                    [self.view addSubview:self.activity];
                                    [self.activity startAnimating];
                                    self.activity.hidesWhenStopped = YES;
                                }
                                
                            }
                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                               if ( image && finished) {
                                   // do something with image
                                   if ([callback respondsToSelector:@selector(texture:)]) {
                                       self.str = @"yes";
                                       [callback texture:[image scaleToSize:CGSizeMake(2048, 1024)]];
//                                       [callback texture:image];
                                       self.activity.hidden = YES;
                                       if([self.activity isAnimating]){
                                           [self.activity stopAnimating];
                                           self.activity.hidden = YES;
//                                           [self.activity removeFromSuperview];
                                           self.activity = nil;
                                       }
                                   }
                               }
                           }];
    
    
}







@end
