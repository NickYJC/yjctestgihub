//
//  GetWarehouseListModel.h
//  TeaLeaves
//
//  Created by 张美文 on 16/1/8.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "CustomModel.h"

/*
 address = 456;
 cityId = "\U7389\U6eaa\U5e02";
 code = 456;
 contactNumber = 456;
 contacts = 456;
 districtId = "\U7ea2\U5854\U533a";
 id = 7201AE4EB52511E5B90C00163E000271;
 name = 456;
 provinceId = "\U4e91\U5357\U7701";
 subdistrictId = "<null>";
 zipCode = 456;
 */

@interface GetWarehouseListModel : CustomModel
/**
 *  详细地址
 */
@property (nonatomic, copy) NSString *address;
/**
 *  市
 */
@property (nonatomic, copy) NSString *cityId;
/**
 *  仓库编号
 */
@property (nonatomic, copy) NSString *code;
/**
 *  联系电话
 */
@property (nonatomic, copy) NSString *contactNumber;
/**
 *  联系人
 */
@property (nonatomic, copy) NSString *contacts;
/**
 *  区
 */
@property (nonatomic, copy) NSString *districtId;
/**
 *  编号 -> warehouseId
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  仓库名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  省
 */
@property (nonatomic, copy) NSString *provinceId;
/**
 *  街道办
 */
@property (nonatomic, copy) NSString *subdistrictId;
/**
 *  邮政编码
 */
@property (nonatomic, copy) NSString *zipCode;


@end
