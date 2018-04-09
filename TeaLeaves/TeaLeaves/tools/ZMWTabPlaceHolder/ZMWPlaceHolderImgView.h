//
//  ZMWPlaceHolderImgView.h
//  TeaLeaves
//
//  Created by 张美文 on 2016/10/13.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMWPlaceHolderImgView : UIView
@property (nonatomic, copy) NSString *imageName;

- (instancetype)initWithFrame:(CGRect)frame placeHodlerImageName:(NSString *)name;

@end
