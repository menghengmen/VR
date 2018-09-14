//
//  MYSegmentView.m
//  Kitchen
//
//  Created by su on 16/8/8.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "MYSegmentView.h"

@implementation MYSegmentView

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC  lineWidth:(float)lineW lineHeight:(float)lineH
{
    if ( self=[super initWithFrame:frame  ])
    {
        float avgWidth = (frame.size.width/controllers.count);
   
        self.controllers=controllers;
        self.nameArray=titleArray;
        
        self.segmentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 45)];
        self.segmentView.tag=50;
        [self addSubview:self.segmentView];
       
       
        
        self.topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 5)];
        self.topView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        self.topView.layer.shadowRadius = 1;
               [self.segmentView addSubview:self.topView];
        

        UIView*  topTopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
        topTopView.backgroundColor = [UIColor blackColor];
        topTopView.alpha = 0.15;
        [self.segmentView addSubview:topTopView];
        

        
        
        //中间的分割线
        self.middleLabel=[[UILabel alloc]init];
        //self.middleLabel.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
//        [self.segmentView addSubview:self.middleLabel];
//        [self.middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.segmentView);
//            make.width.equalTo(@0.5);
//            make.height.equalTo(@19);
//            
//            
//        }];
        

        
        
        self.segmentScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 45, frame.size.width, frame.size.height -45)];
        self.segmentScrollV.contentSize=CGSizeMake(frame.size.width*self.controllers.count, 0);
        self.segmentScrollV.delegate=self;
        self.segmentScrollV.showsHorizontalScrollIndicator=NO;
        self.segmentScrollV.pagingEnabled=YES;
        self.segmentScrollV.bounces=NO;
        [self addSubview:self.segmentScrollV];
        
        for (int i=0;i<self.controllers.count;i++)
        {
            UIViewController * contr=self.controllers[i];
            contr.view.frame=CGRectMake(i*frame.size.width, 0, frame.size.width,frame.size.height);
            [self.segmentScrollV addSubview:contr.view];
            [parentC addChildViewController:contr];
            [contr didMoveToParentViewController:parentC];
        }
        for (int i=0;i<self.controllers.count;i++)
        {
            UIButton * btn=[ UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(i*(SCREENWIDTH/self.controllers.count), 5,SCREENWIDTH/self.controllers.count, 40);
            btn.tag=i;
            [btn setTitle:self.nameArray[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor colorWithHexString:@"#29a7e1"] forState:(UIControlStateSelected)];
            self.seleBtn = btn;
            [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.font=[UIFont systemFontOfSize:12.];
            
                       [self.segmentView addSubview:btn];
        }
        
        
        //底部会动的线
        self.line=[[UILabel alloc]initWithFrame:CGRectMake((avgWidth-lineW)/2,45-lineH, lineW, lineH)];
        self.line.backgroundColor = [UIColor colorWithHexString:@"#29a7e1"];
        self.line.tag=100;
        [self.segmentView addSubview:self.line];
    }
    
    
    return self;
}

- (void)Click:(UIButton*)sender
{
    self.seleBtn.titleLabel.font= [UIFont systemFontOfSize:12.];;
    self.seleBtn.selected=NO;
    self.seleBtn=sender;
    self.seleBtn.selected=YES;
    self.seleBtn.titleLabel.font= [UIFont systemFontOfSize:12.];;
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag);
        self.line.center=frame;
    }];
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];
    
   
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
      [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)*(self.segmentScrollV.contentOffset.x/self.frame.size.width);
        self.line.center=frame;
    }];

      
}

@end
