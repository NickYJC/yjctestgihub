//
//  ZMWPopMenuViewController.h
//  TeaLeaves
//
//  Created by 张美文 on 2016/12/15.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMWPopMenuViewController : UIViewController
@property (nonatomic, copy) void (^block)(NSInteger index);
@property (nonatomic, strong) NSArray *dataArray;

@end
