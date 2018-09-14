//
//  XYBrawerHeaderImageView.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/21.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYBrawerHeaderImageView.h"
@interface XYBrawerHeaderImageView()
@property (nonatomic,strong)UIImageView *imageView;
@end
@implementation XYBrawerHeaderImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
////     Drawing code
//    [super drawRect:rect];
//}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor colorWithRandomColor];
        self.contentMode =UIViewContentModeScaleAspectFill;
        self.clipsToBounds =YES;
        self.userInteractionEnabled = true;
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2.0f - 40, self.frame.size.height/2.0f - 40, 80, 80)];
        self.imageView = imageview;
        imageview.image = [UIImage imageNamed:@"boFang"];
        [self addSubview:imageview];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)setModel:(XYImageModel *)model{
    _model = model;
    self.url = model.url;
    self.isPlayer = model.isVideo;
}

-(void)tap:(UITapGestureRecognizer *)tap{
    if (self.imageClickBlock) {
        self.imageClickBlock();
    }
}

-(void)setIsPlayer:(XYPhonesType)isPlayer{
    _isPlayer = isPlayer;
    if (isPlayer == XYPhonesTypeFullVideos || isPlayer == XYPhonesTypeFullImage) {
        self.imageView.hidden = false;
    }else{
        self.imageView.hidden = true;
    }
}

-(void)setUrl:(NSString *)url{
    _url = url;
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"main_default_img"]];
}

@end
