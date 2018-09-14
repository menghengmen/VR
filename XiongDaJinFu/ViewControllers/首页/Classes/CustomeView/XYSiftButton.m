//
//  XYSiftButton.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/14.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYSiftButton.h"

@interface  XYSiftButton()
@end

@implementation XYSiftButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    if (self =[super init]) {
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.cornerRadius = 3;
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageview.image = [UIImage imageNamed:@"shape_sanjiao"];
        self.imageView1 = imageview;
        [self addSubview:imageview];
        imageview.hidden = true;
    }
    return self;
}


-(void)setIsSelectOnly:(BOOL)isSelectOnly{
    _isSelectOnly = isSelectOnly;
    self.imageView1.frame = CGRectMake(self.frame.size.width/2.0 -5, self.frame.size.height, 10, 5);
    if (isSelectOnly) {
        self.imageView1.hidden = false;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor colorWithHex:0x29a7e1]];
    }else{
        self.imageView1.hidden = true;
        [self setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor colorWithHex:0xd9d9d9]];
    }
}

-(void)setIsOpen:(BOOL)isOpen{
    _isOpen = isOpen;
    if (isOpen) {
        self.imageView1.hidden = false;
    }else{
        self.imageView1.hidden = true;
    }
}

@end
