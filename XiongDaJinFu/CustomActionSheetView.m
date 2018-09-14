//
//  CustomActionSheetView.m
//  VideoPlay
//
//  Created by gary on 16/12/2.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import "CustomActionSheetView.h"

@implementation CustomActionSheetView
{
    UIView              *_BGView;
    float               MaxH;
}
@synthesize delegate;
-(id)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)]) {
        
    }
    return self;
}
-(id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)]) {
        
    }
    return self;
}

-(void) initBottons:(NSArray*) wordArr
{
    MaxH =([wordArr count]+1)*60+10;
    int StartH = SCREENHEIGHT -MaxH;
    for (int i=0; i<[wordArr count]; i++) {
        NSDictionary* tDic = wordArr[i];
        UIButton* tBtt = [UIButton buttonWithType:UIButtonTypeCustom];
        tBtt.frame =CGRectMake(0, StartH, SCREENWIDTH, 60);
        [tBtt addTarget:self action:@selector(pressedIndexBtt:) forControlEvents:UIControlEventTouchUpInside];
        tBtt.tag =i+1;
        [tBtt setBackgroundColor:RGB(255, 255, 255)];
        [tBtt setTitle:[tDic objectForKey:@"word"] forState:UIControlStateNormal];
        [tBtt setTitleColor:[tDic objectForKey:@"wordcolor"] forState:UIControlStateNormal];
        [self addSubview:tBtt];
        if (i<[wordArr count]-1) {
            CALayer* tlinelay2 = [CALayer layer];
            tlinelay2.frame =CGRectMake(0, 59, SCREENWIDTH, 1);
            [tlinelay2 setBackgroundColor:RGB(241, 241, 241).CGColor];
            [tBtt.layer addSublayer:tlinelay2];
        }
        StartH+=60;
    }
    UIView* tTableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(-1, StartH, SCREENWIDTH, 10)];
    [tTableHeaderView setBackgroundColor:RGB(238, 238, 238)];
    CALayer* tlinelay1 = [CALayer layer];
    tlinelay1.frame =CGRectMake(0, 0, SCREENWIDTH, 1);
    [tlinelay1 setBackgroundColor:RGB(241, 241, 241).CGColor];
    [tTableHeaderView.layer addSublayer:tlinelay1];
    CALayer* tlinelay2 = [CALayer layer];
    tlinelay2.frame =CGRectMake(0, 9, SCREENWIDTH, 1);
    [tlinelay2 setBackgroundColor:RGB(241, 241, 241).CGColor];
    [tTableHeaderView.layer addSublayer:tlinelay2];
    [self addSubview:tTableHeaderView];
    
    StartH+=10;
    
    UIButton* tCancelBtt = [UIButton buttonWithType:UIButtonTypeCustom];
    tCancelBtt.frame =CGRectMake(0, StartH, SCREENHEIGHT, 60);
    [tCancelBtt addTarget:self action:@selector(cancelSelf) forControlEvents:UIControlEventTouchUpInside];
    [tCancelBtt setBackgroundColor:RGB(255, 255, 255)];
    [tCancelBtt setTitle:@"取消" forState:UIControlStateNormal];
    [tCancelBtt setTitleColor:RGB(121, 120, 153) forState:UIControlStateNormal];
    [self addSubview:tCancelBtt];
    

}

-(void) pressedIndexBtt:(UIButton*)sender
{
    [delegate didSelectIndex:(int)sender.tag];
    [self cancelSelf];
}


-(void) pressedCancelBtt
{
    [delegate didSelectIndex:-1];
}


-(void) cancelSelf
{
    [UIView beginAnimations:nil context: nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dissSelfAnimateEnd)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];
    _BGView.alpha = 0;
    self.frame =CGRectMake(0, MaxH, SCREENWIDTH, SCREENHEIGHT);
    [UIView commitAnimations];
}

-(void) showSelf:(UIView*) tSuperView
{
    _BGView = [[UIView alloc] initWithFrame:self.frame];
    [_BGView setBackgroundColor:RGB(0, 0, 0)];
    _BGView.alpha = 0;
    [tSuperView addSubview:_BGView];
    
    UIButton* _BGBtt = [UIButton buttonWithType:UIButtonTypeCustom];
    _BGBtt.frame =CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-MaxH);
    [_BGBtt addTarget:self action:@selector(cancelSelf) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_BGBtt];
    
    
    [tSuperView addSubview:self];
    
    self.frame =CGRectMake(0, MaxH-100, SCREENWIDTH, SCREENHEIGHT);
    
    [UIView beginAnimations:nil context: nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];
    _BGView.alpha = 0.5f;
    self.frame =CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [UIView commitAnimations];
}

-(void) dissSelfAnimateEnd
{
    [_BGView removeFromSuperview];
    [self removeFromSuperview];
}
@end
