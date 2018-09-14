//
//  fullViewController.m
//  Blinroom
//
//  Created by room Blin on 16/7/26.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "fullViewController.h"
#import "PanoramaView.h"


@interface fullViewController()
{
    PanoramaView *panoramaView;
}
@end


@implementation fullViewController

- (void)viewDidLoad{
    [super viewDidLoad];

//    panoramaView = [[PanoramaView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
//    [panoramaView setImageWithName:@"1472011422098.jpg"];
//    [panoramaView setOrientToDevice:YES];
//    [panoramaView setTouchToPan:NO];
//    [panoramaView setPinchToZoom:YES];
//    [panoramaView setShowTouches:NO];
//    
//    
//    //    [self setView:panoramaView];
//    self.view = panoramaView;
//    

    [self judgeTime];

}


//判断是否同一天打开长程序
- (void)judgeTime{

    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlag = NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlag fromDate:now];
    NSInteger day = [dateComponent day];

    
    NSInteger beforeDay = [[NSUserDefaults standardUserDefaults] integerForKey:@"day"];
    [self setImage];

    if (beforeDay == 0) {
        [[NSUserDefaults standardUserDefaults] setInteger:day forKey:@"day"];
        [self setImage];
    } else if (beforeDay != day && beforeDay != 0) {
        [self setImage];
        [[NSUserDefaults standardUserDefaults] setInteger:day forKey:@"day"];
    }
    
    



}

- (void)setImage{

    
    
    
    
    panoramaView = [[PanoramaView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    
    
    
    
    NSString  * imageNameStr =  [NSString stringWithFormat:@"%d",arc4random() %6];
    
    [panoramaView setImageWithName:[NSString stringWithFormat:@"000%@.jpg",imageNameStr]];
    [panoramaView setImageWithName:@"002.jpg"];
    [panoramaView setOrientToDevice:YES];
    [panoramaView setTouchToPan:NO];
    [panoramaView setPinchToZoom:YES];
    [panoramaView setShowTouches:NO];
    
    //    [self setView:panoramaView];
    self.view = panoramaView;
    



}


-(void) glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [panoramaView draw];
}

@end
