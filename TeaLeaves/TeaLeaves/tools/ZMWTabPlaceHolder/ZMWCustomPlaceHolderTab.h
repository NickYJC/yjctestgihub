//
//  ZMWCustomPlaceHolderTab.h
//  TeaLeaves
//
//  Created by 张美文 on 2016/10/13.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZMWCustomPlaceHolderTabBlock)();

@interface ZMWCustomPlaceHolderTab : UITableView
@property (nonatomic, copy) ZMWCustomPlaceHolderTabBlock holderBlock;
@property (nonatomic, assign) ZMWCustomPlaceHodlerType type;
@property (nonatomic, copy) NSString *imageName;

@end
