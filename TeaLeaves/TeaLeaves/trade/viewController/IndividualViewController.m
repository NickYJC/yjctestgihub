//
//  IndividualViewController.m
//  TeaLeaves
//
//  Created by xueliaunt on 15/11/4.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "IndividualViewController.h"
//#import "GoodsNameTableViewCell.h"
//#import "ScrollTableViewCell.h"
//#import "GetTradingCenterModel.h"
#define onePartButtonTag 100
#define onePartViewTag 1100
#define secondPartViewTag 200
#define secondPartTableTag 2200
#import "commond.h"
#import "CacheDataBase.h"
#import "TakeDetailViewController.h"
@interface IndividualViewController ()<UITableViewDataSource,UITableViewDelegate>//<UIScrollViewDelegate>

@property (nonatomic,strong) UIView *rightView;

@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic, strong)  UITableView * leftTableView;
@property (nonatomic, strong)  UITableView * rightTableView;
@property (nonatomic, copy)  NSString * moveString;
@end

@implementation IndividualViewController
{
    NSMutableArray * dataSourceArray;
     NSMutableArray * dataSourceRightArray;
}
-(void)createUI
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    _scrollView.frame = CGRectMake(0, 0, KScreenW, KScreenH);
    _scrollView.contentSize = CGSizeMake(KScreenW+KScreenW-50, 0);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [_scrollView setScrollEnabled:NO];
    _scrollView.contentOffset = CGPointMake(KScreenW-50, 0);
    self.view.backgroundColor =[UIColor backgroundColor];
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW-50, KScreenH)];
    //scroll.delegate = self;
    _leftView.backgroundColor = [UIColor grayColor];
    [_scrollView addSubview:_leftView];
    
   
    
    
    
    _rightView = [[UIView alloc]initWithFrame:CGRectMake(KScreenW-50, 0, KScreenW, KScreenH)];
    [_scrollView addSubview:_rightView];
    _rightView.backgroundColor = [UIColor backgroundColor];
    
   
  
    
    
}
- (void)createLeftUI
{
    
    
    UIView *topLeftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, _leftView.frame.size.width, 60)];
    topLeftView.backgroundColor =[UIColor darkGrayColor];
    [_leftView addSubview:topLeftView];
    NSArray *arr =@[@"自选",@"USDT",@"BTC",@"ETC",@"返回"];
    for (int i =0; i<arr.count; i++) {
        UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(_leftView.frame.size.width/5*i, 35,_leftView.frame.size.width/5, 25)];
        leftButton.titleLabel.font =[UIFont systemFontOfSize:11];
        [leftButton setTitle:arr[i] forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(leftBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        leftButton.tag = 200+i;
        [topLeftView addSubview:leftButton];
    }
    
    
}
- (void)leftBtnClick:(UIButton*)button
{
    switch (button.tag-200) {
        case 4:
        {
            self.navigationController.navigationBar.hidden = YES;
            self.tabBarController.tabBar.hidden = NO;
            [UIView animateWithDuration:0.1 animations:^{
                
                    _scrollView.contentOffset = CGPointMake(KScreenW-50, 0);
            }];
        }
            break;
        default:
            break;
    }
    self.moveString =button.titleLabel.text;
    [_leftTableView reloadData];
}
- (void)createRightUI
{
    UIView *topRightView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, _rightView.frame.size.width, 60)];
    topRightView.backgroundColor =[UIColor backgroundColor];
    topRightView.alpha =0.9;
    [_rightView addSubview:topRightView];
    NSArray *arr =@[@"抽屉",@"k线",@"登录"];
    for (int i =0; i<arr.count; i++) {
        UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(_rightView.frame.size.width/5*i, 35,_rightView.frame.size.width/5, 25)];
        leftButton.titleLabel.font =[UIFont systemFontOfSize:11];
        [leftButton setTitle:arr[i] forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(rightBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        leftButton.tag = 100+i;
        [_rightView addSubview:leftButton];
    }
    
    
   
    
}
- (void)rightBtnClick:(UIButton*)button
{
    switch (button.tag-100) {
        case 0:
        {
            self.navigationController.navigationBar.hidden = YES;
            self.tabBarController.tabBar.hidden = YES;
            [UIView animateWithDuration:0.1 animations:^{
               
                _scrollView.contentOffset = CGPointMake(0, 0);
            }];
        }
            break;
        case 1:
        {
            TakeDetailViewController *detailVC = [[TakeDetailViewController alloc]init];
            detailVC.hidesBottomBarWhenPushed = YES;
            
            
            detailVC.AAAClickIndex =0 ;
            detailVC.AAAcreateVCIndex = @"1";
            
            [self.navigationController pushViewController:detailVC animated:NO];
           
        }
            break;
        case 2:
        {
            
           
        }
            break;
        default:
            break;
    }
}










- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewController = self;
     self.moveString =@"USDT";
    self.view.backgroundColor = [UIColor backgroundColor];
    [self createUI];
    [self createLeftUI];
    [self createRightUI];
    
    
    //成员变量不能使用autorelease
    dataSourceArray = [[NSMutableArray alloc] init];
    
    //存储数据
    //这里没有数据，制造一些假数据
    for (int  i = 0; i <20; i++) {
        NSString * str = [NSString stringWithFormat:@"这是第%d行", i];
        [dataSourceArray addObject:str];
    }
    
    //成员变量不能使用autorelease
    dataSourceRightArray = [[NSMutableArray alloc] init];
    
    //存储数据
    //这里没有数据，制造一些假数据
    for (int  i = 0; i <20; i++) {
        NSString * str = [NSString stringWithFormat:@"Right 这是第%d行", i];
        [dataSourceRightArray addObject:str];
    }
    
    self.moveString =@"USDT";
    [self createLeftTableView];
    [self createRightTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)createLeftTableView
{
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,60, _leftView.frame.size.width, _leftView.frame.size.height-60) style:UITableViewStylePlain];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.backgroundColor =[UIColor grayColor];
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.showsHorizontalScrollIndicator =NO;
    _leftTableView.showsVerticalScrollIndicator =NO;
    [_leftView addSubview:_leftTableView];
    
    _leftTableView.tableFooterView = [UIView new];
   
    
    
}
-(void)createRightTableView
{
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,60, _rightView.frame.size.width, _rightView.frame.size.height-60) style:UITableViewStylePlain];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.backgroundColor =[UIColor backgroundColor];
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableView.showsHorizontalScrollIndicator =NO;
    _rightTableView.showsVerticalScrollIndicator =NO;
    
    [_rightView addSubview:_rightTableView];
    
    _rightTableView.tableFooterView = [UIView new];
    
    
    
}
#pragma mark tableView  Delegate
//返回某一组的cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //section是组号，这个参数由tableView传入。
    //tableView问我们第0组的Cell个数是？
    
    //这里只有一个分组，所以section必为0
    
    if (tableView ==_leftTableView) {
         return dataSourceArray.count;
    }
    else  {
         return dataSourceRightArray.count;
    }
   
    //返回第0组的cell个数
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
//创建cell，填入数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当某个cell即将被滚动到屏幕上，tableView委托这个方法。
    //找出是否还有空闲的cell
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //@“Cell”是创建cell时给cell的自定义命名，通过命名可以找到cell
    //这方法表示从空闲cell队列里找出空闲的cell。
    //在太空侵略者中，飞出屏幕的子弹会归位。滚出屏幕的cell会被添加到队列。
    
    static NSUInteger count = 0;
    
    //如果没有空闲的cell
    if (!cell) {
        //创建新的cell 命名为@“Cell”
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"Cell"];
        count++;
        
    }
   
    
    if (indexPath.section != 0) {
        return nil;
        //实际上这种情况不可能。
    }
    
    if (tableView ==_leftTableView) {
        cell.textLabel.text = dataSourceArray[indexPath.row];
        cell.textLabel.textColor =[UIColor whiteColor];
        //cell上填充图片
        cell.imageView.image = nil;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ ",self.moveString];
        
         cell.backgroundColor =[UIColor grayColor];
    }
    else  {
        cell.textLabel.text = dataSourceArray[indexPath.row];
        cell.textLabel.textColor =[UIColor whiteColor];
        //cell上填充图片
        cell.imageView.image = nil;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ ",self.moveString];
        
        
        
        cell.backgroundColor =[UIColor backgroundColor];
      
    }
    
    
    cell.detailTextLabel.textColor =[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    

   
    if (tableView ==_leftTableView) {
        self.navigationController.navigationBar.hidden = YES;
        self.tabBarController.tabBar.hidden = NO;
        [UIView animateWithDuration:0.1 animations:^{
            
            _scrollView.contentOffset = CGPointMake(KScreenW-50, 0);
        }];
    }
    else  {
            TakeDetailViewController *detailVC = [[TakeDetailViewController alloc]init];
            detailVC.hidesBottomBarWhenPushed = YES;
        
        
            detailVC.AAAClickIndex =0 ;
            detailVC.AAAcreateVCIndex = @"1";
        
            [self.navigationController pushViewController:detailVC animated:NO];
    }
}


#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   //3 交易系列界面点完善资料,地址传值
    [AppDefault  shareDefault].adressPathNum = 3;
   
   
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
}


@end
