//
//  labelview.m
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/14.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "labelview.h"

#define TAGCOLOR1 @"#EEAFE1"
#define TAGCOLOR2 @"#F6E8A4"
#define TAGCOLOR3 @"#9EDDF9"
#define TAGCOLOR4 @"#F5AB8D"


@interface labelview()



@end
@implementation labelview
-(UIButton*)itemBtn{
    if (!_itemBtn) {
        _itemBtn = [UIButton new];
    }

    return _itemBtn;
}

-(instancetype) initWithFrame:(CGRect)frame dataArr:(NSArray *)array{
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
    
}

-(void)setDataArray:(NSArray *)dataArray{
    [self.itemBtn removeFromSuperview];
    //随机颜色数组
    NSArray  * colorArr = [[NSArray alloc] initWithObjects:TAGCOLOR1,TAGCOLOR2,TAGCOLOR3,TAGCOLOR4, nil];
    
    
    
    for (int i = 0; i < dataArray.count; i ++){
        
       
        //得到的随机颜色数组

//        NSMutableSet *randomSet = [[NSMutableSet alloc] init];
//        
//        while ([randomSet count] < dataArray.count) {
//            int r = arc4random() % [colorArr count];
//            [randomSet addObject:[colorArr objectAtIndex:r]];
//        }
//        
//        NSArray *randomArray = [randomSet allObjects];
//        NSLog(@"随机取出的数组元素为%@",randomArray);
//        

        
        NSString *name = dataArray[i];
        
        static UIButton *recordBtn =nil;
        static dispatch_once_t predicate;
        dispatch_once(&predicate, ^{
            recordBtn = [[UIButton alloc] init];
        });
        
        if (self != nil) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.itemBtn = btn;

        }
        _itemBtn.contentEdgeInsets = UIEdgeInsetsMake(2, 4, 2, 4);
        _itemBtn.titleLabel.font = [UIFont systemFontOfSize:9];
        _itemBtn.layer.cornerRadius = 4;
        [_itemBtn setTitleColor:[UIColor colorWithHexString:@"#fcfffd"] forState:UIControlStateNormal];
        CGRect rect = [name boundingRectWithSize:CGSizeMake(320-20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_itemBtn.titleLabel.font} context:nil];
        if (i == 0)
        {
            _itemBtn.frame =CGRectMake(0, 10, rect.size.width+12, rect.size.height+4);
           // btn.backgroundColor = [UIColor colorWithHexString:randomArray[1]];
            _itemBtn.backgroundColor = c1;
            _itemBtn.layer.borderColor =LabelBorderColor1.CGColor;
            _itemBtn.layer.borderWidth = 1;
        }
        else{
                _itemBtn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + 10, recordBtn.frame.origin.y, rect.size.width+12, rect.size.height+4);
                //btn.backgroundColor = [UIColor colorWithHexString:randomArray[2]];
                _itemBtn.backgroundColor = c2;
                _itemBtn.layer.borderColor =LabelBorderColor2.CGColor;
            if (i==2) {
                _itemBtn.backgroundColor = c3;
                _itemBtn.layer.borderColor =LabelBorderColor3.CGColor;
            }if (i==3) {
                _itemBtn.backgroundColor = c4;
                _itemBtn.layer.borderColor =LabelBorderColor4.CGColor;
            }
            
               _itemBtn.layer.borderWidth = 1;
                
        }
        
        recordBtn = _itemBtn;

        [recordBtn setTitle:name forState:UIControlStateNormal];
        

        [self addSubview:self.itemBtn];
        
    }
    
    




}

-(void) BtnClick:(UIButton *)sender{
    
    __weak typeof(self) weakSelf = self;
    
    if (weakSelf.btnBlock) {
        
        weakSelf.btnBlock(sender.tag);
    }
    
}

-(void) btnClickBlock:(BtnBlock)btnBlock{
    
    self.btnBlock = btnBlock;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
