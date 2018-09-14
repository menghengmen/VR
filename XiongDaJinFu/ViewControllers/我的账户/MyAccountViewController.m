//
//  MyAccountViewController.m
//  XiongDaJinFu
//
//  Created by 码动 on 16/10/13.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import "MyAccountViewController.h"
#import "LoginViewController.h"
#import "CollectionViewController.h"
#import "AccountManagerTableViewController.h"
#import "MHUserInfoTableViewController.h"
#import "userInfoHeaderCell.h"
@interface MyAccountViewController ()

@end

@implementation MyAccountViewController
NSString *const cityHeaderView = @"CityHeaderView";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.userInteractionEnabled = YES;
    //self.tableView.sectionHeaderHeight = 200;

  
}
# pragma  mark -
# pragma mark UITableViewDelegate

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    userInfoHeaderCell *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cityHeaderView];
    headerView.userNameLabel.text = @"dsadsa";
    headerView.bgImageView.backgroundColor = [UIColor redColor];
    
    return nil;


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 200;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView * containerView = [UIView new];
        [cell addSubview:containerView];
        containerView.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(cell);
            make.height.equalTo(@50);
            make.centerY.equalTo(cell);
        }];
        
        UIImageView *picImage = [UIImageView new];
        [cell addSubview:picImage];
        [picImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(containerView).offset(15);
            make.width.equalTo(@22);
            make.height.equalTo(@22);
            make.centerY.equalTo(containerView);
        }];
        
        UILabel * cellLabel = [XDCommonTool newlabelWithTextColor:[UIColor colorWithHexString:@"595959"] withTitle:nil fontSize:15];
        cellLabel.textAlignment = NSTextAlignmentLeft;
        [cell addSubview:cellLabel];
        [cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(redView).offset(8);
            make.left.equalTo(picImage.mas_right).offset(16);
            make.centerY.equalTo(containerView);
            make.width.equalTo(@200);
            make.height.equalTo(@17);
        }];
        switch (indexPath.row) {
           
            
            
            
            
            case 0:
                picImage.image = [UIImage imageNamed:@"我的订单"];
                cellLabel.text = @"生日";
                break;
            case 1:
                
                picImage.image = [UIImage imageNamed:@"地址管理"];
                cellLabel.text = @"我的家乡";
                break;
                
            case 2:
                
                picImage.image = [UIImage imageNamed:@"退货管理"];
                cellLabel.text = @"留学院校";
                break;
            case 3:
                
                picImage.image = [UIImage imageNamed:@"经销商"];
                cellLabel.text = @"就读专业";
                break;
            
                default:
                break;
        }
        
        
        
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
       

    switch (indexPath.row) {
        case 0:{
           // [self.navigationController pushViewController:[MHUserInfoTableViewController new] animated:YES];
        }
            break;
        case 1:
           // [self.navigationController pushViewController:[CollectionViewController new] animated:YES];
            break;
        case 2:
          
            break;
        
        
        case 3:{
            //[self.navigationController pushViewController:[AccountManagerTableViewController new] animated:YES];
        }
            break;
        
        default:
            break;
    }



}
# pragma mark
# pragma mark - 进入个人详情
- (void)personInfo{


}



@end
