//
//  XYHourseTypeTVCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYHourseTypeTVCell.h"
#import "XYSettingInfoModel.h"
#import "XYHourseTypeSettingCollectionCell.h"
@interface XYHourseTypeTVCell()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@end

@implementation XYHourseTypeTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.hourseIamgeView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.hourseIamgeView addGestureRecognizer:tap];
    
//    CGFloat itemWidth = (SCREEN_MAIN.width - 187 -15 -10)/3.0;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.itemSize = CGSizeMake(itemWidth, 20);
    layout.itemSize = CGSizeMake(40, 15);
    layout.minimumInteritemSpacing =4;
    layout.minimumLineSpacing = 5;
    self.settingCollectionView.delegate = self;
    self.settingCollectionView.dataSource = self;
    [self.settingCollectionView setCollectionViewLayout:layout];
    [self.settingCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ XYHourseTypeSettingCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([XYHourseTypeSettingCollectionCell class])];
    
}

//-(void)updateConstraints{
//    [super updateConstraints];
//    self.moreBtnHeight.constant = 0;
//}


-(void)tap:(UITapGestureRecognizer *)tap{
    if (self.imageClickBlock) {
        self.imageClickBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(XYHourseTypeModel *)model{
    
    _model = model;
    
    
    if (self.settingInfo) {
        self.labelStringArray = [XYToolCategory getInfoFormDictStrings:self.settingInfo andPropertyKey:@"fjss" privateKeys:model.facility];
    }else{
        
        NSMutableArray *labelsArrOld = [NSMutableArray array];
        for (NSString *str in model.facility) {
            [labelsArrOld addObject:[XDCommonTool getDictValueWithSectionKey:@"fjss" andKey:str]];
        }
        self.labelStringArray = labelsArrOld;
    }
    
    self.nameLabel.text = model.type_alias;
    [self.hourseIamgeView sd_setImageWithURL:[NSURL URLWithString:model.title_image] placeholderImage:[UIImage imageNamed:@"room_default_img"]];
    
    //最短入住时长
    self.timeLength.text = [NSString stringWithFormat:@"%@%@",model.shortest_lease,model.shortest_lease_unit];
    
    //入住时间
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.check_in_time integerValue]/1000];
    self.dateLabel.text = [dataFormatter stringFromDate:date];
    
    //剩余房间数
    self.hourseNum.text = [NSString stringWithFormat:@"%@间",model.onhand.length ==0?@"-":model.onhand];
    self.priceLabel.text = model.price;
    
    //单位
    
//    NSString *unit2 = [XDCommonTool getDictValueWithSectionKey:@"hbdw" andKey:model.currency?model.currency:@""];
    NSString *unit2 =self.settingInfo? [XYToolCategory getInfoFormDict:self.settingInfo andPropertyKey:@"hbdw" privateKey:model.currency?model.currency:@""]:[XDCommonTool getDictValueWithSectionKey:@"hbdw" andKey:model.currency?model.currency:@""];
    
    //时间单位
//    NSString *week2 = [XDCommonTool getDictValueWithSectionKey:@"dateUnit" andKey:model.date_unit?model.date_unit:@""];
    NSString *week2 =self.settingInfo? [XYToolCategory getInfoFormDict:self.settingInfo andPropertyKey:@"dateUnit" privateKey:model.date_unit?model.date_unit:@""]:[XDCommonTool getDictValueWithSectionKey:@"dateUnit" andKey:model.date_unit?model.date_unit:@""];
    
    self.unitAndWeekLabel.text = [NSString stringWithFormat:@"%@/%@", unit2,week2];
    
    //隐藏查看更多按钮
    if (self.labelStringArray.count <= [self numberOfItemInLine] *2) {
        self.moreBtnHeight.constant = 0;
        self.moreBtn.hidden = true;
    }else{
        self.moreBtnHeight.constant = 20;
        self.moreBtn.hidden = false;
    }
    
    //隐藏。。。
    if (model.isOpen || (self.labelStringArray.count <= [self numberOfItemInLine] *2 &&self.labelStringArray.count >0)) {
        self.pointLabel.hidden = true;
        self.pointLabelHeight.constant = 0;
    }else{
        self.pointLabel.hidden = false;
        self.pointLabelHeight.constant = 10;
        if (self.labelStringArray.count == 0) {
            self.pointLabelTop.constant = 40;
            self.pointLabel.text = @"---";
            self.pointLabel.textColor = [UIColor blackColor];
        }
    }
    [self.settingCollectionView reloadData];
    
    //费用包含
    NSMutableString *freed = [NSMutableString string];
    if (model.include_cost && model.include_cost.count >0) {
        for (NSString *str in model.include_cost) {
            [freed appendString:[NSString stringWithFormat:@" %@",[XYToolCategory getInfoFormDict:self.settingInfo andPropertyKey:@"bhfy" privateKey:str]]];
            
        }
        self.annotateLabel.text = [NSString stringWithFormat:@"包含：%@",freed];
    }else{
        self.annotateLabel.text = @"";
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.model.isOpen) {
        return self.labelStringArray.count;
    }else{
        NSInteger count = [self numberOfItemInLine];
        if (self.labelStringArray.count <=count *2) {
            return self.labelStringArray.count;
        }else{
            return count *2;
        }
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYHourseTypeSettingCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XYHourseTypeSettingCollectionCell class]) forIndexPath:indexPath];
    
//    NSString *set1 = [XYToolCategory getInfoFormDict:self.settingInfo andPropertyKey:@"fjss" privateKey:self.model.facility[indexPath.item]];
    cell.textLabel.text = self.labelStringArray[indexPath.item];
    
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(NSInteger)numberOfLines{
    NSInteger countInLine = [self numberOfItemInLine];
    
    return self.labelStringArray.count/countInLine +(self.labelStringArray.count%countInLine !=0?1:0);
}

-(NSInteger)numberOfItemInLine{
    NSInteger width = self.settingCollectionView.width;
    NSInteger countInLine = width/(40 +3) + (width % 43 >= 40?1:0);
    
    return countInLine;
}

- (IBAction)scheduleBtnClick:(UIButton *)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
}

- (IBAction)moreBtnClick:(id)sender {
    if (self.moreBtnClickBlock) {
        self.moreBtnClickBlock(!self.model.isOpen);
    }
}
@end
