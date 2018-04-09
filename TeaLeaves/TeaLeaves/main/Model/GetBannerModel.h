//
//  GetBannerModel.h
//  TeaLeaves
//
//  Created by 张美文 on 15/12/11.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "CustomModel.h"
/**
 *  广告列表
 */
@interface GetBannerModel : CustomModel
/**
 *  广告URL
 */
@property (nonatomic, retain) NSString *bannerPicture;
/**
 *  是否跳转web
 */
@property (nonatomic, retain) NSString *skip;
/**
 *  webURL
 */
@property (nonatomic, retain) NSString *bannerUrl;

@end
