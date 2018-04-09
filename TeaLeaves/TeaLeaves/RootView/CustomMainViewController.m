//
//  CustomMainViewController.m
//  TeaLeaves
//
//  Created by 张美文 on 15/11/27.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "CustomMainViewController.h"
#import "SearchBarView.h"
#import "PullTableView.h"


@interface CustomMainViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property (nonatomic, retain) PullTableView *pullTab;
@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) SearchBarView *searchView;
@property (nonatomic, retain) UIButton *rightBtn;


@end

@implementation CustomMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor yellowColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.f],NSFontAttributeName, nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];

    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.98f green:0.98f blue:0.98f alpha:1.00f]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条"] forBarMetrics:UIBarMetricsDefault];
    
    //    UIView *barView = [[UIView alloc] init];
    //    barView.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 20);
    //    barView.backgroundColor = [UIColor colorWithRed:0.19f green:0.19f blue:0.19f alpha:1.00f];
    //    [self.navigationController.navigationBar addSubview:barView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //右边消息按钮
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 20, 20);
    _rightBtn.backgroundColor = [UIColor clearColor];
    [_rightBtn setImage:[UIImage imageNamed:@"有信息了"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self createNavItem1];

}

- (void)rightButtonAction:(UIButton *)button{
    
    [_searchView.textfield resignFirstResponder];
    
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        
        if ([view isKindOfClass:[PullTableView class]]) {
            return;
        }
    }
    
    if (self.messageBlock) {
        self.messageBlock();
    }
    if (![LoginMessage checkLogin]) {
        CustomNavigationController *navVctr = (CustomNavigationController *)[self viewController:button];
        
        if ([[ZMWMallViewController class] isSubclassOfClass:[navVctr.childViewControllers[0] class]]) {
            //
            [self.view popLoginAlertView:[ZMWMallViewController class] type:kTabBarSubNavTypeTake];
        }else {
            [self.view popLoginAlertView];
        }
        
    }else {
//        NewsViewController * newsVC = [[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
//        [self.navigationController pushViewController:newsVC animated:YES];
//                
    }
}


- (PullTableView *)pullTab{
    
    if (_pullTab == nil) {
        
        _pullTab = [[PullTableView alloc] initWithPullFrame:CGRectMake(0, 70, KScreenW, 10) didSelectedBlock:^(NSString *cellTitle) {
            //
            if (self.cellBlock) {
                self.cellBlock(cellTitle);
            }
        }];
    }
    return _pullTab;
}

- (void)createNavItem1{
    
    _searchView = [[SearchBarView alloc] initWithFrame:CGRectMake(20, 20, KScreenW-100, 35) fetchCompletionHandlerTextFieldChanged:^{
        //textfield changed
        NSMutableArray *array;
        static int i;
        if (i%2 == 0) {
            array = [[NSMutableArray alloc] initWithArray:@[@"1", @"2", @"3", @"4", @"5", @"6"]];
            i++;
        }else{
            array = [[NSMutableArray alloc] initWithArray:@[@"1", @"2", @"3"]];
            i++;
        }
        
        //测试数据, 搜索的地方在这个类请求
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.pullTab.pullDataArray = array;
            
        });

    } fetchCompletionHandlerSearchButtonAction:^{
        if (self.searchBlock) {
            self.searchBlock();
        }
        
    }];
    
    self.navigationItem.titleView = _searchView;
    
    
}

- (void)handleSearchBarWithSelectedTabCell:(CustomMainViewControllerCellBlock)cellBlock :(CustomMainViewControllerSearchButtonBlock)searchButtonBlock :(CustomMainViewControllerMessageBlock)messageBlock{
    self.cellBlock = cellBlock;
    self.searchBlock = searchButtonBlock;
    self.messageBlock = messageBlock;
}

- (void)setViewController:(UIViewController *)viewController{
    _viewController = viewController;
    
    if (!([viewController isKindOfClass:[MainSetViewController class]] || [viewController isKindOfClass:[ZMWMallViewController class]])) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(-10, 0, 20, 44);
        //点击有发光效果
        //        backButton.showsTouchWhenHighlighted = YES;
        //设置标题图片
        [_backButton setImage:[UIImage imageNamed:@"返回圆"] forState:UIControlStateNormal];
        // UIImage *i= [UIImage imageNamed:]
        //        [backButton setImage:[UIImage imageNamed:t] forState:UIControlStateHighlighted];
        //添加点击事件

        _backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //创建导航按钮
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:_backButton];
        //添加到导航栏上去现实
        
        self.navigationItem.leftBarButtonItem = backItem;

    }

}

- (void)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (UIViewController *)viewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    // If the view controller isn't found, return nil.
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
