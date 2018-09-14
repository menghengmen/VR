//
//  XYNewIntroduceView.m
//  testDemo
//
//  Created by 威威孙 on 2017/4/30.
//  Copyright © 2017年 威威孙. All rights reserved.
//

#import "XYNewIntroduceView.h"

@implementation XYIntroduceItemObj
+(instancetype)itemWithRect:(CGRect)rect type:(XYIntrodeceItemType)type cornerRadius:(CGFloat)cornerRadius{
    XYIntroduceItemObj *obj = [XYIntroduceItemObj new];
    obj.rect = rect;
    obj.type = type;
    obj.cornerRadius = cornerRadius;
    return obj;
}

@end

@implementation XYNewIntroduceView

static XYNewIntroduceView *introduce;
+(instancetype)sharedIntroudence{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        introduce = [[XYNewIntroduceView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        introduce.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
        introduce.userInteractionEnabled  =true;
    });
    return introduce;
}


//圆
//    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width - 30, 42) radius:30 startAngle:0 endAngle:2*M_PI clockwise:NO]];
;
//矩形
//    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(frame.size.width/2.0-1, 234, frame.size.width/2.0+1, 55) cornerRadius:5] bezierPathByReversingPath]];
//圆角矩形
//    [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, 150, 100) byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(30, 30)]
//椭圆
//    [path appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]]
-(void)showIntroduceWithItems:(NSArray<XYIntroduceItemObj *> *)items{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    
    //create path 重点来了（**这里需要添加第一个路径）
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    for (XYIntroduceItemObj *objc in items) {
        switch (objc.type) {
            case XYIntrodeceItemTypeRectangle:
                [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:objc.rect cornerRadius:objc.cornerRadius] bezierPathByReversingPath]];
                break;
                
            case XYIntrodeceItemTypeRound:
                [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:objc.rect cornerRadius:objc.cornerRadius] bezierPathByReversingPath]];
                break;
            case XYIntrodeceItemTypeOval:
                [path appendPath:[[UIBezierPath bezierPathWithOvalInRect:objc.rect] bezierPathByReversingPath]];
                break;
            default:
                break;
        }
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        [self.layer setMask:shapeLayer];
        
        //判断在第几象限
        NSInteger quadrant = [self itemLocalInCoordinate:objc.rect];
        //箭头，label，button
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"jiantou%ld",quadrant]]];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor whiteColor];
        label.text = @"点击“筛选”切换房源所在国家\n及附近院校";
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 2;
        [self addSubview:label];
        
        UIButton *button = [UIButton buttonWithTitle:@"我知道了" titleColour:[UIColor whiteColor] image:nil backgroundImage:nil target:self action:@selector(knowBtnClick:) borderColour:nil borderWidth:0 cornerRadius:5 backgroundColour:[UIColor colorWithHex:0x29a7e1]];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:button];
        
        
        CGRect imageRect;
        CGRect labelRect;
        CGRect buttonRect;
        //imageViewRect
        switch (quadrant) {
            case 1:
                imageRect = CGRectMake(self.frame.size.width/2.0f, CGRectGetMaxY(objc.rect) -10, objc.rect.origin.x-self.frame.size.width/2.0f , 120);
                labelRect = CGRectMake(80, CGRectGetMaxY(imageRect) +10, self.frame.size.width - 100, 60);
                buttonRect = CGRectMake(self.frame.size.width - 220, CGRectGetMaxY(labelRect), 80, 25);
                break;
                
            default:
                break;
        }
        
        imageView.frame = imageRect;
        label.frame = labelRect;
        button.frame = buttonRect;
        
    }
    
}

-(NSInteger)itemLocalInCoordinate:(CGRect)rect{
    if (((CGRectGetMaxX(rect)-self.frame.size.width /2.0f) >=rect.size.width/2.0f) &&((CGRectGetMaxY(rect) - self.frame.size.height /2.0f) <=rect.size.height/2.0f)) {//第一象限
        return 1;
    }else if (((CGRectGetMaxX(rect)-self.frame.size.width /2.0f) < rect.size.width/2.0f) &&((CGRectGetMaxY(rect) - self.frame.size.height /2.0f) <=rect.size.height/2.0f)){
        return 2;
    }else if (((CGRectGetMaxX(rect)-self.frame.size.width /2.0f) < rect.size.width/2.0f) &&((CGRectGetMaxY(rect) - self.frame.size.height /2.0f) > rect.size.height/2.0f)){
        return 3;
    }else{
        return 4;
    }
}

-(void)knowBtnClick:(UIButton *)sender{
    if (self.clickBlock) {
        self.clickBlock();
    }
    
}

-(void)hiddenIntroduce{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}

@end
