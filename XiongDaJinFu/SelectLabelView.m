//
//  SelectLabelViw.m
//  Blinroom
//
//  Created by Blinroom on 16/8/16.
//  Copyright © 2016年 Blinroom. All rights reserved.
//

#import "SelectLabelView.h"

static CGFloat leftSpace = 80.0;
static CGFloat button_width = 80.0;
static CGFloat button_height = 28.0;

@interface SelectLabelView () {
    
    CGFloat viewWidth,viewHeight;
    
    NSInteger max_select;
    
    NSInteger selectCount;
    NSArray*namearray;
    NSInteger tag;
   // NSString*seletedname;
}

@end
// self.slenamearray=[[NSMutableArray alloc]init];
@implementation SelectLabelView
- (NSMutableArray *)slenamearray {
    if (!_slenamearray) {
        _slenamearray = @[].mutableCopy;
    }
    return _slenamearray;
}
-(id)initWithLabelNamesArray:(NSArray*)labelnames andMaxSelect:(NSInteger)max andStartY:(CGFloat)startY {
    
    self = [super init];
    
    if (self ) {
        
        max_select = max;
        
        viewWidth = SCREENHEIGHT+100 - leftSpace*3;
        LRLog(@"%f----w",viewWidth);
        {//循环 创建 按钮 设置选择状态和正常状态的 属性
            namearray=[[NSArray alloc]init];
            namearray=labelnames;
            self.allLabels = [NSMutableArray arrayWithCapacity:5];
            
            CGFloat buttonMidSpace_horizontal = (viewWidth - button_width*3)/2.0/3;
            CGFloat buttonMidSpace_vertical = 20;
            
            NSInteger buttontag = 0;
            
            for (int vertical = 0; buttontag < labelnames.count ; vertical ++) {
                
                for (int horizontal = 0; horizontal < 4
                     && buttontag < labelnames.count; horizontal ++) {
                    
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag=buttontag;
                    button.frame = CGRectMake(horizontal*(button_width + buttonMidSpace_horizontal)+23, vertical*(button_height + buttonMidSpace_vertical), button_width, button_height) ;
                     [button setImage:[UIImage imageNamed:@"icon_list_unselected"] forState:UIControlStateNormal];
                    button.titleLabel.font = [UIFont systemFontOfSize:14];
                    button.titleLabel.textAlignment=NSTextAlignmentRight;
                    button.titleLabel.textColor=[UIColor grayColor];
                    button.backgroundColor = [UIColor whiteColor];
                  [button setTitle:[labelnames objectAtIndex:buttontag] forState:UIControlStateNormal];
                     button.imageEdgeInsets=UIEdgeInsetsMake(1, 2, 2, button.titleLabel.bounds.size.width+5);
                    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                   // button.titleEdgeInsets=UIEdgeInsetsMake(1,button.bounds.size.width-button.titleLabel.bounds.size.width+2, 2,0);
                    button.layer.borderWidth=0;
                    button.layer.cornerRadius = 5;
                    
                    if (max_select > 0) {
                        
                        [button setTitleColor:[UIColor colorWithHexString:@"29a7e1"] forState:UIControlStateSelected];
                       
                       
                       // button.layer.borderColor = [UIColor grayColor].CGColor;
                        
                        button.layer.borderWidth = 0;
                        
                        button.layer.masksToBounds = YES;
                       // button.tag=0;
                        [button addTarget:self action:@selector(onButtonInSelf:) forControlEvents:UIControlEventTouchUpInside];
                       // tag=buttontag;
                        [button setTitle:[labelnames objectAtIndex:buttontag] forState:UIControlStateNormal];
                        //buttontag=button.tag;
                       // labelnames
                        
                    }else {
                        
                        //button.layer.borderColor = [UIColor blueColor].CGColor;
                        
                       // button.layer.borderWidth = .5;
                        
                        button.layer.masksToBounds = YES;
                        button.titleLabel.textColor=[UIColor colorWithHexString:@"808080"];
                      //  [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        button=0;
                        [button setTitle:[labelnames objectAtIndex:buttontag] forState:UIControlStateNormal];
                        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                       // button.tag=buttontag;
                    }
                    
                    
                    
                    [self addSubview:button];
                    
                    [self.allLabels addObject:button];
                    
                    buttontag++;
                    
                    
                }
                
            }
            
            //计算 当前视图的 高度
            NSInteger lines = buttontag/3 + (buttontag%3?1:0);
            viewHeight = lines * button_height + (lines-1)*buttonMidSpace_vertical;
        }
    }
    
    return self;
}

-(void)onButtonInSelf:(UIButton*)sender {
    
    {//改变 选择的按钮的 颜色等 属性
        
        if (sender.selected == YES) {
            
            selectCount--;
            
            sender.selected  = NO;
            
            sender.layer.borderWidth = 0;
            [sender setImage:[UIImage imageNamed:@"icon_list_unselected"] forState:UIControlStateNormal];
           
            
            
            
            sender.backgroundColor = [UIColor whiteColor];
             LRLog(@"你取消了%ld",sender.tag);
             LRLog(@"你取消了%@",[namearray objectAtIndex:sender.tag]);
            
            // NSMutableArray*basearray=[CommonTool requestDataApplictionNsstring:[namearray objectAtIndex:sender.tag]];
           // [self.slenamearray removeObject:[namearray objectAtIndex:sender.tag]];
           // NSString*name=[basearray lastObject];

          //  [self.slenamearray removeObject:name];
            LRLog(@"11111%@",self.slenamearray);

            NSDictionary*dic=@{@"nsarray":self.slenamearray};
            NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dic];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }else {
            
            if (selectCount < max_select) {
                
                selectCount++;
                
                sender.selected = YES;
                
                sender.layer.borderWidth = 0;
                [sender setImage:[UIImage imageNamed:@"icon_list_selected"] forState:UIControlStateNormal];
                sender.backgroundColor =[UIColor whiteColor];
              
                NSLog(@"%ld",(long)sender.tag);
                LRLog(@"你选中了%@",[namearray objectAtIndex:sender.tag]);
                NSString*seleted=[namearray objectAtIndex:sender.tag];
             /*
                if ([seleted isEqualToString:@"电视"]||[seleted isEqualToString:@"空调"]||[seleted isEqualToString:@"阳台"]||[seleted isEqualToString:@"桌椅"]) {
                     NSMutableArray*basearray=[CommonTool requestDataApplictionNsstring:[namearray objectAtIndex:sender.tag]];
                    NSString*strbase=[basearray lastObject];
                   // NSArray *arra=@[strbase];
                   //  NSString*name=[arra firstObject];
                    [self.slenamearray addObject:strbase];
                }else{
                     NSMutableArray*basearray=[CommonTool requestDataApplictionNsstring:[namearray objectAtIndex:sender.tag]];
                    NSString*name=[basearray firstObject];
                     [self.slenamearray addObject:name];
                }
                
               
                
                
                //[self.slenamearray addObject:[namearray objectAtIndex:sender.tag]];
               
               // [namearray objectAtIndex:sender.tag];
                LRLog(@"11111%@",self.slenamearray);
                */
                NSDictionary*dic=@{@"nsarray":self.slenamearray};
                NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dic];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
                
            }else {
                
                //输出一个提示信息
                [XDCommonTool  alertWithMessage:@"最多选择七项"];
            
            }
            
            
        }
        
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
