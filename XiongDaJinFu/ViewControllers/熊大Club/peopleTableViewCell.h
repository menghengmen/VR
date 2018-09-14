//
//  peopleTableViewCell.h
//  XiongDaJinFu
//
//  Created by room Blin on 2017/4/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "labelview.h"
#import "peopleModel.h"
@interface peopleTableViewCell : UITableViewCell

@property(nonatomic,strong)  UIImageView   * iconImageView;

@property(nonatomic,strong)  UILabel   *  nameLabel;
@property(nonatomic,strong)  UIImageView   * sexImageView;
@property(nonatomic,strong)  UILabel   * birthdayLabel;

@property(nonatomic,strong)  UILabel   *  placeLabel;

@property(nonatomic,strong)  labelview   *  labelView;

@property(nonatomic,strong)  UILabel   *  universityLabel;
@property(nonatomic,strong)  UILabel   *  majorLabel;
@property(nonatomic,strong)  peopleModel   *  peopleModel;

//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *label2Space;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lable3Space;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *label4Space;
@property (weak, nonatomic) IBOutlet UILabel *nameLabelG;
@property (weak, nonatomic) IBOutlet UIImageView *sexIamgeViewG;
@property (weak, nonatomic) IBOutlet UILabel *placeLabelG;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabelG;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *universityLabelG;
@property (weak, nonatomic) IBOutlet UILabel *majorLabelG;

@end
