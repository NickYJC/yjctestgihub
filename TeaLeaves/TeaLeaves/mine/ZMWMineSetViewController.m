//
//  ZMWMineSetViewController.m
//  TeaLeaves
//
//  Created by 张美文 on 16/7/5.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWMineSetViewController.h"

#import "Quartz2D1BasicViewController.h"
@interface ZMWMineSetViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)  UITableView * tableView;
 @property (nonatomic, strong) NSMutableArray * dataSourceArray;
@end

@implementation ZMWMineSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.viewController = self;
    self.view.backgroundColor =[UIColor backgroundColor];
   
    
  
    
    [self createTableView];
    
    
    
    
    
    //成员变量不能使用autorelease
    _dataSourceArray = [[NSMutableArray alloc] init];
    
    //存储数据
    //这里没有数据，制造一些假数据
    NSArray *arrTitle=@[
                        @"Quartz2D 基本图形绘制 ",@"Quartz2D",
                        @"Quartz2D",@"Quartz2D",
                        @"Quartz2D",@"Quartz2D",
                        @"Quartz2D",@"Quartz2D",
                        @"Quartz2D",@"Quartz2D",
                        @"Quartz2D",@"Quartz2D",
                        @"Quartz2D",@"Quartz2D",
                        @"Quartz2D",@"Quartz2D",
                        @"Quartz2D",@"Quartz2D",
                        @"Quartz2D",@"Quartz2D"
                        
                        
                        ];
    [_dataSourceArray addObjectsFromArray:arrTitle];

}



#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
    //4 我的系列界面点完善资料,地址传值
    [AppDefault  shareDefault].adressPathNum = 4;
   
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor =[UIColor backgroundColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor = [UIColor backgroundColor];
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView = [UIView new];
    
    
    
}




#pragma mark tableView  Delegate
//返回某一组的cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //section是组号，这个参数由tableView传入。
    //tableView问我们第0组的Cell个数是？
    
    //这里只有一个分组，所以section必为0
    return _dataSourceArray.count;
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
    cell.backgroundColor =[UIColor backgroundColor];
    
    if (indexPath.section != 0) {
        return nil;
        //实际上这种情况不可能。
    }
    
    //在cell上填充数据
    cell.detailTextLabel.text = _dataSourceArray[indexPath.row];
    cell.detailTextLabel.textColor =[UIColor whiteColor];
    //cell上填充图片
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    Quartz2D1BasicViewController *detailVC = [[Quartz2D1BasicViewController alloc]init];
   
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:NO];
    
    
}





- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
