//
//  LockViewController.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/4.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "LockViewController.h"
#import "YLSwipeLockView.h"
#import "YLInitSwipePasswordController.h"
#import "YLCheckToUnlockViewController.h"

@interface LockViewController ()
@property (nonatomic, weak) UIButton *setButton;
@property (nonatomic, weak) UIButton *checkButton;
@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    label.text = @"hello world";
    CGFloat margin = 20.0f;
    CGFloat width = self.view.bounds.size.width - margin * 2;
    
    UIButton *setButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 60, width, 20)];
    [setButton setTitle:@"set gesture password" forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(setButtonBeTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setButton];
    
    UIButton *checkButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, width, 20)];
    [checkButton setTitle:@"check gesture password" forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(checkButtonBeTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkButton];
    
    UIButton *checkButton3 = [[UIButton alloc] initWithFrame:CGRectMake(20, 130, width, 20)];
    [checkButton3 setTitle:@"返回" forState:UIControlStateNormal];
    [checkButton3 addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkButton3];
    
}
-(void)backClick
{
     [self.navigationController popViewControllerAnimated:YES];
}
-(void)setButtonBeTouched
{
    YLInitSwipePasswordController *controller = [YLInitSwipePasswordController new];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)checkButtonBeTouched
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"gesturePassword"]) {
        YLCheckToUnlockViewController *controller = [YLCheckToUnlockViewController new];
        [self presentViewController:controller animated:YES completion:nil];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"no gesture password set" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert show];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com


