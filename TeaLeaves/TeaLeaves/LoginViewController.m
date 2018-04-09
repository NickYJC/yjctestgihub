//
//  LoginViewController.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/6.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UIScrollViewDelegate>

@end

@implementation LoginViewController
{
    UIScrollView *baseScrollView;
    
}-(void)createUI
{
    CGFloat height =(kScreenHeight*3);
    
    
    baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenH)];
    baseScrollView.backgroundColor = [UIColor backgroundColor];
    baseScrollView.scrollEnabled = YES;
    baseScrollView.bounces = YES;
    baseScrollView.delegate = self;
    baseScrollView.showsVerticalScrollIndicator = NO;
    baseScrollView.contentSize = CGSizeMake(kScreenWidth,height+30);
    [self.view addSubview:baseScrollView];
    //第一部分
    UIView *onePartView= [[UIView alloc] initWithFrame :CGRectMake(0,0,kScreenWidth,kScreenWidth/3)];
    onePartView.backgroundColor = [UIColor backgroundColor];
    onePartView.alpha=0.9;
    [baseScrollView addSubview:onePartView];
    
    
    
    
    NSArray *arr =@[@"返回",@"全屏",@"手势密码"];
    for (int i =0; i<arr.count; i++) {
        UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(onePartView.frame.size.width/5*i, 35,onePartView.frame.size.width/5, 25)];
        leftButton.titleLabel.font =[UIFont systemFontOfSize:11];
        [leftButton setTitle:arr[i] forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(oneBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        leftButton.tag = 100+i;
        [onePartView addSubview:leftButton];
    }
}
- (void)oneBtnClick:(UIButton*)button
{
    switch (button.tag-100) {
        case 0:
        {
            self.navigationController.navigationBarHidden = NO;
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
            break;
        case 1:
        {
            
//            FullScreenViewController *vc =[[FullScreenViewController alloc]init];
//            
//            
//            
//            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 2:
        {
            
//            LockViewController *vc =[[LockViewController alloc]init];
//
//
//
//            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor =[UIColor backgroundColor];
    // Do any additional setup after loading the view.
    [self createUI];
}
#pragma mark  view周期
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   
    self.navigationController.navigationBarHidden=YES;
    self.tabBarController.tabBar.hidden = YES;
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
