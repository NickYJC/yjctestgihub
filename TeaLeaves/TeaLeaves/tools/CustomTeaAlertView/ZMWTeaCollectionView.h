//
//  ZMWTeaCollectionView.h
//  TeaLeaves
//
//  Created by 张美文 on 16/9/28.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMWTeaCollectionView : UICollectionView
@property (nonatomic, copy) void(^block)(int number, ZMWPreSellCardType);
@property (nonatomic, strong) NSString *urlString;

@end
