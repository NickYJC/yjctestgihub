//
//  TakeDetailViewController.m
//  TeaLeaves
//
//  Created by YangJingcai on 15/11/4.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "TakeDetailViewController.h"


#import "DetailTakeOneViewController.h"


//#import "GetMallModel.h"
//#import "GetBuyPriceModel.h"




#import "MenuView.h"
#import "SGTopTitleView.h"


@interface TakeDetailViewController ()<SGTopTitleViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong)DetailTakeOneViewController *oneViewController;
@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSMutableArray *titles;

@property (nonatomic, strong) UIView *chooseYearView;
@property (nonatomic, strong)UIButton *changeBtn;

@property (nonatomic, strong) NSString *titleVC;

@end

@implementation TakeDetailViewController
{

    
    
    BOOL isBackVc;
    NSInteger scrolNum;
    
    
 
}
- (void)backAction:(UIButton *)button
{
    isBackVc = YES;
   
    [super backAction:button];
}

-(void)dealloc
{
   
    DebugLog(@"TakeDetailViewController 222222222");

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
   
   
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
 
}

-(void)viewDidLoad
{
    [super viewDidLoad];
   
   
    
    _titles = [[NSMutableArray alloc]init];
   
   
   
    
    for (int i = 0; i<self.AAAcreateVCIndex.intValue; i++) {
        
        [_titles addObject:@" "];
    }
    

    
     [self setupChildViewController];
    
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth,0.0001)];
    _topTitleView.scrollTitleArr = [NSArray arrayWithArray:_titles];
    _topTitleView.titleAndIndicatorColor = [UIColor colorWithHexString:@"C50000"];
    _topTitleView.delegate_SG = self;
    _topTitleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topTitleView];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _mainScrollView.contentSize = CGSizeMake(kScreenWidth * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    
    [_mainScrollView setContentOffset:CGPointMake(kScreenWidth * self.AAAClickIndex,0) animated:YES];
    
    //赋初值
    if(!_oneViewController)
    {
        _oneViewController = [[DetailTakeOneViewController alloc]init];
        
    }
   
    _oneViewController  =(DetailTakeOneViewController *)self.childViewControllers[self.AAAClickIndex] ;
    _oneViewController.tagVCNum = 100+self.AAAClickIndex;
   
     _titleVC =_oneViewController.tagVCString;
    
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    

    
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];
 
    
    [self showVc:self.AAAClickIndex];
    
   
}


//=============================
#pragma mark - - - SGTopScrollMenu代理方法
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index {
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * kScreenWidth;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}

// 添加所有子控制器
- (void)setupChildViewController {
    
    
    for (int i =0 ; i<self.AAAcreateVCIndex.intValue; i++) {
        
     
        DetailTakeOneViewController *oneVC = [[DetailTakeOneViewController alloc] init];
       
        oneVC.createVCIndex = self.AAAcreateVCIndex;
      
        oneVC.tagVCNum = i+100;
        oneVC.titleIndex = i+1;
       
        [self addChildViewController:oneVC];
      
    }

}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * kScreenWidth;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, kScreenWidth, kScreenHeight);
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    

    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
    

    [self.topTitleView scrollTitleLabelSelecteded:selLabel];
    // 3.让选中的标题居中
    [self.topTitleView scrollTitleLabelSelectededCenter:selLabel];
    
   
    scrolNum =index;
    if(!_oneViewController)
    {
        _oneViewController = [[DetailTakeOneViewController alloc]init];
        _titleVC = _oneViewController.tagVCString;
        
    }
    _oneViewController  =(DetailTakeOneViewController *)self.childViewControllers[index] ;
     self.title  =[AppDefault APPDefaultWith:_oneViewController.tagVCString];
     
   [AppDefault shareDefault].klineTitleVCString =_oneViewController.tagVCString;
    
}




@end
