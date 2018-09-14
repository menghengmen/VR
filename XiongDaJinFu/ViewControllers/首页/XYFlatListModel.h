//
//  XYFlatListModel.h
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/3/15.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYFlatListModelImages,XYFlatListModelFullShotIamges,XYFlatListModelVideos,XYFlatListModelFullShotVideos,XYFatilityModel,XYHourseTypeModel,XYSupplyerModel;
@interface XYFlatListModel : NSObject
@property (nonatomic,strong) NSString *faltId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSArray  *images;
@property (nonatomic,strong) NSArray  *full_shot_images;
@property (nonatomic,strong) NSArray  *videos;
@property (nonatomic,strong) NSArray  *full_shot_videos;
@property (nonatomic,strong) NSString *title_image;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *intro_en;
@property (nonatomic,strong) NSString *intro_zh;
@property (nonatomic,strong) NSArray  *facility;//配套设施
@property (nonatomic,strong) NSArray *include_cost;//费用包含
@property (nonatomic,strong) NSString *lng;//经度
@property (nonatomic,strong) NSString *lat;
@property (nonatomic,strong) NSArray  *label;//特色标签（字典库）
@property (nonatomic,strong) NSString *currency;//货币类型（字典库）
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *room_count;
@property (nonatomic,strong) NSString *max_people;
@property (nonatomic,strong) NSString *check_in_time;//可办理入住时间
@property (nonatomic,strong) NSString *shortest_lease;//最短入住时长
@property (nonatomic,strong) NSString *type_id;//标准房间类型
@property (nonatomic,strong) NSString *shortest_lease_unit;//最短入住时长单位
@property (nonatomic,strong) NSString *charge_unit;//计价单位(数据字典别名)
@property (nonatomic,strong) NSString *date_unit;
@property (nonatomic,strong) NSString *add_date;//上架日期
@property (nonatomic,strong) NSString *updata_date;//更新日期
@property (nonatomic,strong) NSString *order;//排列顺序
@property (nonatomic,strong) NSString *hot;//房源热度指数
@property (nonatomic,strong) XYSupplyerModel *provider;//供应商对象
@property (nonatomic,assign) BOOL like;//是否被当前登录用户收藏
@property (nonatomic,strong) NSString *like_id;//收藏的id
@property (nonatomic,strong) NSArray  *apartment_types;//该公寓包含的房型(此字段只在查询详情时返回！)
@end

@interface XYHourseListModel : NSObject
@property (nonatomic,strong) NSString *faltId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSArray  *images;
@property (nonatomic,strong) NSArray  *full_shot_images;
@property (nonatomic,strong) NSArray  *videos;
@property (nonatomic,strong) NSArray  *full_shot_videos;
@property (nonatomic,strong) NSString *title_image;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *intro_en;
@property (nonatomic,strong) NSString *intro_zh;
@property (nonatomic,strong) NSArray  *facility;//配套设施
@property (nonatomic,strong) NSString *lng;//经度
@property (nonatomic,strong) NSString *lat;
@property (nonatomic,strong) NSArray  *label;//特色标签（字典库）
@property (nonatomic,strong) NSString *currency;//货币类型（字典库）
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *charge_unit;//计价单位(数据字典别名)
@property (nonatomic,strong) NSString *add_date;//上架日期
@property (nonatomic,strong) NSString *updata_date;//更新日期
@property (nonatomic,strong) NSString *order;//排列顺序
@property (nonatomic,strong) NSString *hot;//房源热度指数
@property (nonatomic,strong) NSString *provider;//供应商对象
@property (nonatomic,assign) BOOL like;//是否被当前登录用户收藏
@property (nonatomic,strong) NSString *like_id;//收藏的id
//@property (nonatomic,strong) NSArray  *apartment_types;//该公寓包含的房型(此字段只在查询详情时返回！)

@end

@interface XYFlatListModelImages : NSObject
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *url;
@end

@interface XYFlatListModelFullShotIamges : NSObject
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *url;
@end

@interface XYFlatListModelVideos : NSObject
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *url;
@end

@interface XYFlatListModelFullShotVideos : NSObject
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *url;
@end



@interface XYHourseTypeModel : NSObject
@property (nonatomic,strong) NSString *hourseId;//ID(国际公寓房型编号)
@property (nonatomic,strong) NSString *apartment_id;//隶属公寓ID
@property (nonatomic,strong) NSString *type_id;//标准房型名称(数据字典别名)
@property (nonatomic,strong) NSString *type_alias;//公寓方指定的房型名称
@property (nonatomic,strong) NSArray  *images;//普通图片
@property (nonatomic,strong) NSArray  *full_shot_images;//
@property (nonatomic,strong) NSArray  *videos;//
@property (nonatomic,strong) NSArray  *full_shot_videos;//
@property (nonatomic,strong) NSString *title_image;//
@property (nonatomic,strong) NSString *date_unit;
@property (nonatomic,strong) NSString *check_in_time;//
@property (nonatomic,strong) NSString *shortest_lease;//
@property (nonatomic,strong) NSString *shortest_lease_unit;//
@property (nonatomic,strong) NSString *currency;//
@property (nonatomic,strong) NSString *price;// 
@property (nonatomic,strong) NSArray  *facility;
@property (nonatomic,strong) NSString *charge_unit;
@property (nonatomic,strong) NSArray *include_cost;
@property (nonatomic,strong) NSString *onhand;

@property (nonatomic,assign) BOOL isOpen;
@end

@interface XYFatilityModel : NSObject

@end

@interface XYSupplyerModel : NSObject
@property (nonatomic,strong) NSString *supplyId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *portrait;
@property (nonatomic,strong) NSString *intro;
@end
