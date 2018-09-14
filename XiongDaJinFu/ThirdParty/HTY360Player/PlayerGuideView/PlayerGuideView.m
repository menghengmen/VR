//
//  PlayerGuideView.m
//  VR800
//
//  Created by Peng Sheng on 16/3/31.
//  Copyright © 2016年 Peng Sheng. All rights reserved.
//




#import "PlayerGuideView.h"
//#import "UIImageView+AnimationCompletion.h"
@interface PlayerGuideView()
{
    NSArray * imageArrays1;
    NSArray * imageArrays2;
    int currentGuide;
    UIImageView * frameImageView;
}
@end
@implementation PlayerGuideView
-(UIView *)init
{
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

- (void)initData {
    
    imageArrays1 = @[
                     @[@"guide1_1.png",@"guide1_2.png"],
                     @[@"guide2_1.png",@"guide2_2.png"],
                     @[@"guide3_1.png",@"guide3_2.png"]
                     ];
    
    imageArrays2 = @[
                     @[@"guide4_1.png",@"guide4_2.png",@"guide4_3.png",@"guide4_4.png"],
                     @[@"guide5_1.png",@"guide5_2.png"]
                     ];
    currentGuide = 0;
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    currentGuide ++;
    frameImageView.animationImages = nil;
    [frameImageView removeFromSuperview];
    
    NSUserDefaults* tUserDef = [NSUserDefaults standardUserDefaults];
    if ((currentGuide>2 && _kind == 1)) {
        [tUserDef setObject:@"1" forKey:FIRSTPLAY];
        [tUserDef synchronize];
        [self removeFromSuperview];
        [self.delegate guideDidEnd];
        
        return;
    }else if(currentGuide>1 && _kind == 2)
    {
        [tUserDef setObject:@"1" forKey:FIRSTDOUBLE];
        [tUserDef synchronize];
        [self removeFromSuperview];
        [self.delegate guideDidEnd];

        return;
        
    }
    NSMutableArray * dataArray = [NSMutableArray new];
    
    [self animationBegin:_kind];
    
}

- (void)animationBegin:(int)kind {
    
    frameImageView = [[UIImageView alloc] init];
    [self addSubview:frameImageView];
    
    [frameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    NSMutableArray * dataArray = [NSMutableArray new];
    if (kind == 1) {
        for (int i=0; i<[imageArrays1[currentGuide] count]; i++) {
            [dataArray addObject:[UIImage imageNamed:imageArrays1[currentGuide][i]]];
        }
        frameImageView.animationImages = dataArray;
        
    }else
    {
        for (int i=0; i<[imageArrays2[currentGuide] count]; i++) {
            [dataArray addObject:[UIImage imageNamed:imageArrays2[currentGuide][i]]];
        }
        frameImageView.animationImages = dataArray;
        
    }
    frameImageView.animationDuration = 0.3*[dataArray count];
    
    if (kind == 2 && currentGuide == 0) {
        frameImageView.animationDuration = 0.5*4;
        
    }
    frameImageView.animationRepeatCount = 0;
    [frameImageView startAnimating];
}


@end
