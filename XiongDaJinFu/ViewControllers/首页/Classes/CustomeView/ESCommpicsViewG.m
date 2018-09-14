//
//  ESCommpicsViewG.m
//  Essential-New
//
//  Created by 奕赏 on 16/3/12.
//  Copyright © 2016年 上海逸衫袖电子商务有限公司. All rights reserved.
//

#import "ESCommpicsViewG.h"
#import <UITableView+SDAutoTableViewCellHeight.h>
//#define angelToRandian(x) ((x)/180.0*M_PI)
@implementation ESCommpicsViewG
{
    NSArray *_imageViewsArray;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    NSMutableArray *array =[NSMutableArray array];
    for (int i =0; i<9; i++) {
        UIImageView *imageView =[[UIImageView alloc]init];
        [self addSubview:imageView];
        imageView.userInteractionEnabled =YES;
//        imageView.tag =i;
//        imageView.image =[UIImage imageNamed:comPlaceImageName];
        [array addObject:imageView];
    }
    _imageViewsArray =[array copy];
}

-(void)setPicsPathArray:(NSArray *)picsPathArray{
    _picsPathArray =picsPathArray;
    //隐藏不需要显示的图片
    for (long i=_picsPathArray.count; i<_imageViewsArray.count; i++) {
        UIImageView *imageView =[_imageViewsArray objectAtIndex:i];
        imageView.hidden =YES;
    }
    //如果没有图片
    if (_picsPathArray.count ==0) {
        self.height =0;
        self.fixedWidth =@(0);
        return;
    }
    //获取图片的尺寸
    CGFloat picItemWidth =[self getPicItemWidthWithPicPathArray:_picsPathArray];
    CGFloat picItemHeight =picItemWidth;
    
    long perItemCount =[self perRowItemCountForPicPathArray:_picsPathArray];
    
    for (int i=0;i<_picsPathArray.count;i++) {
        UIImageView *imageView =[_imageViewsArray objectAtIndex:i];
        imageView.hidden =NO;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        imageView.tag =i+1;
//        PicPath *path =_picsPathArray[i];
        NSString *smallPic =_picsPathArray[i];
        [imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:smallPic] placeholderImage:[UIImage imageNamed:comPlaceImageName] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        imageView.frame =CGRectMake(i%3 * (picItemWidth + 5), i/3 * (picItemHeight + 5), picItemWidth, picItemHeight);
        CGFloat w = [self getSelfWidth:_picsPathArray];
        int columnCount = ceilf(_picsPathArray.count * 1.0 / perItemCount);
        CGFloat h = columnCount * picItemHeight + (columnCount - 1) * 5;
        if (_picsPathArray.count ==0) {
            h =0;
        }
//        if (_picsPathArray.count ==1) {
//            CGSize size =[ESCustomCalculate getImageSizeWithURL:_picsPathArray[0]];
//            LxDBAnyVar(size);
//            if (size.width>size.height) {
//                imageView.frame =CGRectMake(0, 0, SCREEN_SIZE.width*3/5.0, SCREEN_SIZE.width*3/5.0/(size.width/size.height));
//                h =SCREEN_SIZE.width*3/5.0/(size.width/size.height);
//            }else{
//                imageView.frame =CGRectMake(0, 0, 44*5*size.width/size.height, 44*5);
//                h =44*5;
//            }
//        }
        self.width = w;
        self.height = h;
        
        self.fixedHeight = @(h);
        self.fixedWidth = @(w);
    }
}

-(CGFloat)getSelfWidth:(NSArray *)picsPathArray{
    if (picsPathArray.count ==0) {
        return 0;
    }else if (picsPathArray.count<3){
//        if (picsPathArray.count ==1) {
//            return SCREEN_SIZE.width*3/5.0;
//        }
//        return picsPathArray.count*[self getPicItemWidthWithPicPathArray:_picsPathArray]+(picsPathArray.count-1)*5;
        return SCREEN_MAIN.width-30;
    }else{
        return SCREEN_MAIN.width-30;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    } else{
        return 3;
    }
}

-(CGFloat)getPicItemWidthWithPicPathArray:(NSArray *)array{
    CGFloat w =(SCREEN_MAIN.width - 45 -10)/3.0;
    return w;
}

-(void)tapImageView:(UITapGestureRecognizer *)tap{
    NSMutableArray *picArray =[[NSMutableArray alloc]init];
    if (self.imageViewClickBlock) {
        for (int i=0; i<_picsPathArray.count; i++) {
            UIImageView *imageView =(UIImageView *)[self viewWithTag:i+1];
            [picArray addObject:imageView];
//            if (tap.state==UIGestureRecognizerStateBegan) {
//                CAKeyframeAnimation* anim=[CAKeyframeAnimation animation];
//                anim.keyPath=@"transform.rotation";
//                anim.values=@[@(angelToRandian(-7)),@(angelToRandian(7)),@(angelToRandian(-7))];
//                anim.repeatCount=MAXFLOAT;
//                anim.duration=0.2;
//                [imageView.layer addAnimation:anim forKey:nil];
//            }
        }
        UIImageView *image = (UIImageView *)tap.view;
    self.imageViewClickBlock(tap.view.tag-1,_picsPathArray,image,picArray);
//        LxDBAnyVar(tap.view);
    }
}

//-(void)setImaegsWithModel:(ESCommunityGroupsModelG *)model{
//    NSArray *arr =[NSArray arrayWithArray:model.pics];
//    _picsPathArray =arr;
//    //如果有图片
//    CGFloat ImageWidth =(SCREEN_SIZE.width-10*2-30)/3.0;
//    if (arr.count>0) {
//        for (int i=0; i<arr.count/3; i++) {
//            for (int j=0; j<arr.count%(i+1); j++) {
//                UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake((ImageWidth+10)*j, (ImageWidth+10)*i, ImageWidth, ImageWidth)];
//                [imageView sd_setImageWithURL:[NSURL URLWithString:arr[i*3+j]]];
//                imageView.tag =i*3+j;
//                imageView.userInteractionEnabled =YES;
//                UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
//                [imageView addGestureRecognizer:tap];
//                [self addSubview:imageView];
//            }
//        }
//    }
//}
//
//-(void)imageViewClick:(UITapGestureRecognizer *)sender{
//    LxDBAnyVar(@"lalala");
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
