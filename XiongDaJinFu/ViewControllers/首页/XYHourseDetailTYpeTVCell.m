//
//  XYHourseDetailTYpeTVCell.m
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "XYHourseDetailTYpeTVCell.h"
#import "XYHourseTypeTVCell.h"
@implementation XYHourseDetailTYpeTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = false;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYHourseTypeTVCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XYHourseTypeTVCell class])];
    self.tableView.bounces = false;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(XYFlatListModel *)model{
    _model = model;
    // TODO:
    for (XYHourseTypeModel *type in model.apartment_types) {
        type.include_cost = model.include_cost;
    }
    self.modelsArray = model.apartment_types;
}

-(void)setModelsArray:(NSArray *)modelsArray{
    _modelsArray = modelsArray;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYHourseTypeModel *model = self.modelsArray[indexPath.row];
    if (model.facility.count <=[self numberOfItemInLine:indexPath.row] *2) {
        return 199;
    }else if(model.isOpen){
        NSInteger lines =[self numberOfLines:indexPath.row];
        return 199 +30 + lines*15 +(lines -1)*5 -30 -20;
    }else{
        return 199 +20;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYHourseTypeTVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XYHourseTypeTVCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    XYHourseTypeModel *model = self.modelsArray[indexPath.row];
    cell.settingInfo = self.settingInfo;
//    model.facility = [XYToolCategory getInfoFormDict:self.settingInfo andPropertyKey:@"fjss" privateKeys:model.facility];
    cell.model = model;
    cell.moreBtnClickBlock = ^(BOOL isOpen){
        if (self.moreBtnClickBlock) {
            self.moreBtnClickBlock(isOpen,indexPath.row);
        }
    };
    cell.btnClickBlock = ^(){
        if (self.scheduleClickBlock) {
            self.scheduleClickBlock(indexPath.row);
        }
    };
    cell.imageClickBlock = ^(){
        if (self.imageClickBlock) {
            self.imageClickBlock(indexPath.row);
        }
    };
    return cell;
}

-(NSInteger)numberOfLines:(NSInteger)index{
    XYHourseTypeModel *model = self.modelsArray[index];
    NSInteger countInLine = [self numberOfItemInLine:index];
    
    return model.facility.count/countInLine +(model.facility.count%countInLine !=0?1:0);
}

-(NSInteger)numberOfItemInLine:(NSInteger)index{
    NSInteger width = SCREEN_MAIN.width - 180 -10;
    NSInteger countInLine = width/(40 +5) + (width % 45 >= 40?1:0);
    
    return countInLine;
}
@end
