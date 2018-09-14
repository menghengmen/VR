//
//  AssetCell.m
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "ELCAssetCell.h"
#import "ELCAsset.h"
#import "ELCConsole.h"
#import "ELCOverlayImageView.h"
#define HEIGHT [UIScreen mainScreen].bounds.size.height/568
#define WIDTH [UIScreen mainScreen].bounds.size.width/320
@interface ELCAssetCell ()

@property (nonatomic, strong) NSArray *rowAssets;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) NSMutableArray *overlayViewArray;

@property (nonatomic, strong) NSMutableArray *subscriptImageArray;

//@property(nonatomic,strong)NSMutableArray *imageArray;

@end

@implementation ELCAssetCell

//Using auto synthesizers

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	if (self) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
        [self addGestureRecognizer:tapRecognizer];
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:4];
        self.imageViewArray = mutableArray;
        
        NSMutableArray *subscriptArray = [[NSMutableArray alloc] initWithCapacity:4];
        self.subscriptImageArray = subscriptArray;
        
        NSMutableArray *overlayArray = [[NSMutableArray alloc] initWithCapacity:4];
        self.overlayViewArray = overlayArray;
        
        self.alignmentLeft = YES;
        
//        self.imageArray = [NSMutableArray array];
        
	}
	return self;
}

- (void)setAssets:(NSArray *)assets
{
    self.rowAssets = assets;
	for (UIImageView *view in _imageViewArray) {
        [view removeFromSuperview];
	}
    
    for (UIImageView *view in _subscriptImageArray) {
        [view removeFromSuperview];
    }
    
    for (ELCOverlayImageView *view in _overlayViewArray) {
        [view removeFromSuperview];
	}
    //set up a pointer here so we don't keep calling [UIImage imageNamed:] if creating overlays
    UIImage *overlayImage = nil;
    for (int i = 0; i < [_rowAssets count]; ++i) {

        ELCAsset *asset = [_rowAssets objectAtIndex:i];

        if (i < [_imageViewArray count]) {
            UIImageView *imageView = [_imageViewArray objectAtIndex:i];
            imageView.image = [UIImage imageWithCGImage:asset.asset.thumbnail];
//            [self.imageArray addObject:imageView.image];
            
        } else {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:asset.asset.thumbnail]];
            [_imageViewArray addObject:imageView];
        }
        
        if (i < [_subscriptImageArray count]) {
            UIImageView *imageView = [_subscriptImageArray objectAtIndex:i];
            imageView.image = [UIImage imageNamed:@"radio_btn_off.png"];
            
        } else {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"radio_btn_off.png"];
            [_subscriptImageArray addObject:imageView];
        }
        
        if (i < [_overlayViewArray count]) {
            ELCOverlayImageView *overlayView = [_overlayViewArray objectAtIndex:i];
            
            overlayView.hidden = asset.selected ? NO : YES;
            overlayView.labIndex.text = [NSString stringWithFormat:@"%d", asset.index + 1];
            
        } else {
            if (overlayImage == nil) {
                overlayImage = [UIImage imageNamed:@"radio_btn_on@2x.png"];//选择了图片的标记图
            }
            ELCOverlayImageView *overlayView = [[ELCOverlayImageView alloc] initWithImage:overlayImage];
            
            [_overlayViewArray addObject:overlayView];
            overlayView.hidden = asset.selected ? NO : YES;
            overlayView.labIndex.text = [NSString stringWithFormat:@"%d", asset.index + 1];
        }
    }
}

- (void)cellTapped:(UITapGestureRecognizer *)tapRecognizer
{
    CGPoint point = [tapRecognizer locationInView:self];
    
    
    int c = (int32_t)self.rowAssets.count;
    CGFloat totalWidth = c * 75*WIDTH + (c - 1) * 4*WIDTH;
    CGFloat startX;
    
    if (self.alignmentLeft) {
        startX = 4*WIDTH;
    }else {
        startX = (self.bounds.size.width - totalWidth) / 2;
    }
    
	CGRect frame = CGRectMake(startX*WIDTH, 2*HEIGHT, 75*WIDTH, 75*WIDTH);
    CGRect framePoint = CGRectMake(startX*WIDTH+48*WIDTH, 5*HEIGHT, 20, 20);
	
	for (int i = 0; i < [_rowAssets count]; ++i) {
        if (CGRectContainsPoint(framePoint, point)) {
            ELCAsset *asset = [_rowAssets objectAtIndex:i];
            asset.selected = !asset.selected;
            ELCOverlayImageView *overlayView = [_overlayViewArray objectAtIndex:i];
            overlayView.hidden = !asset.selected;
            if (asset.selected) {
                
                overlayView.transform = CGAffineTransformIdentity;
                [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations: ^{
                    [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
                        
                        overlayView.transform = CGAffineTransformMakeScale(1.5, 1.5);
                    }];
                    [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
                        
                        overlayView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                    }];
                    [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
                        
                        overlayView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    }];
                } completion:nil];

                
                
                asset.index = [[ELCConsole mainConsole] numOfSelectedElements];
                [overlayView setIndex:asset.index+1];
                [[ELCConsole mainConsole] addIndex:asset.index];
            }
            else
            {
                int lastElement = [[ELCConsole mainConsole] numOfSelectedElements] - 1;
                [[ELCConsole mainConsole] removeIndex:lastElement];
                
            }
            break;
        }
        else
        {
            
            if (CGRectContainsPoint(frame, point)) {
                
                if ([self.celldelegate respondsToSelector:@selector(showPhotos:imageViewArray:)]) {
                    [self.celldelegate showPhotos:1 imageViewArray:nil];
                }
                
                NSLog(@"点击了图片。。。。");
                break;
            }
            
           
        }
            
            
        frame.origin.x = frame.origin.x + frame.size.width + 4*WIDTH;
        framePoint.origin.x = framePoint.origin.x + 75*WIDTH + 4*WIDTH;
    }
}

- (void)layoutSubviews
{
    int c = (int32_t)self.rowAssets.count;
    CGFloat totalWidth = c * 75*WIDTH + (c - 1) * 4*WIDTH;
    CGFloat startX;
    
    if (self.alignmentLeft) {
        startX = 4;
    }else {
        startX = (self.bounds.size.width - totalWidth) / 2;
    }
    
	CGRect frame = CGRectMake(startX*WIDTH, 2*HEIGHT, 75*WIDTH, 75*WIDTH);
    CGRect framePoint = CGRectMake(startX*WIDTH+48*WIDTH, 5*HEIGHT, 20, 20);
	
	for (int i = 0; i < [_rowAssets count]; ++i) {
		UIImageView *imageView = [_imageViewArray objectAtIndex:i];
		[imageView setFrame:frame];
		[self addSubview:imageView];
        
//        CGRect framePoint = CGRectMake(startX*WIDTH+48*WIDTH, 5*HEIGHT, 20*WIDTH, 20*WIDTH);
        
        UIImageView *subscriptImage = [_subscriptImageArray objectAtIndex:i];
        [subscriptImage setFrame:framePoint];
        [self addSubview:subscriptImage];
        
        ELCOverlayImageView *overlayView = [_overlayViewArray objectAtIndex:i];;
       [overlayView setFrame:framePoint];
//        overlayView.center = subscriptImage.center;
        [self addSubview:overlayView];
		
        
		frame.origin.x = frame.origin.x + frame.size.width + 4*WIDTH;
        framePoint.origin.x = framePoint.origin.x + 75*WIDTH + 4*WIDTH;
	}
}


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com