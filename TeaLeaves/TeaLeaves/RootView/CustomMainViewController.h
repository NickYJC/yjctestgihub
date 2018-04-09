//
//  CustomMainViewController.h
//  TeaLeaves
//
//  Created by 张美文 on 15/11/27.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CustomMainViewControllerCellBlock)(NSString *selectedCell);
typedef void (^CustomMainViewControllerSearchButtonBlock)();
typedef void (^CustomMainViewControllerMessageBlock)();

@interface CustomMainViewController : UIViewController
@property (nonatomic, copy) CustomMainViewControllerCellBlock cellBlock;
@property (nonatomic, copy) CustomMainViewControllerSearchButtonBlock searchBlock;
@property (nonatomic, copy) CustomMainViewControllerMessageBlock messageBlock;
@property (nonatomic, strong) UIViewController *viewController;

- (void)handleSearchBarWithSelectedTabCell:(CustomMainViewControllerCellBlock)cellBlock :(CustomMainViewControllerSearchButtonBlock)searchButtonBlock :(CustomMainViewControllerMessageBlock)messageBlock;

@end
