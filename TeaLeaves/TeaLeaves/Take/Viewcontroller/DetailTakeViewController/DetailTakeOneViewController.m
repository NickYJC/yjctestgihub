//
//  DetailTakeOneViewController.m
//  TeaLeaves
//
//  Created by YangJingcai on 16/12/1.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "DetailTakeOneViewController.h"
#import "LockViewController.h"
#import "MenuView.h"

@interface DetailTakeOneViewController ()<UIScrollViewDelegate,Y_StockChartViewDataSource>

@property (nonatomic, strong) Y_StockChartView *stockChartView;

@property (nonatomic, strong) Y_KLineGroupModel *groupModel;

@property (nonatomic, copy) NSMutableDictionary <NSString*, Y_KLineGroupModel*> *modelsDict;


@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) MenuView *menuView;//kxian之上
@property (nonatomic, assign) NSInteger tempIndex;//kxian点击记录
@property (nonatomic, strong) NSString *klineString;//kxian点击记录  按钮的String

/**
 *  弹出视图下方
 */
//@property (nonatomic, strong) UIView *popTitleView;
@property (nonatomic, strong) UIView *popUpView;
@property (nonatomic, strong) UIView *popMinuteView;


//其他视图
@property (nonatomic, strong)UIView *secondPartView;

@end

@implementation DetailTakeOneViewController
{
    UIScrollView *baseScrollView;
   
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    CGFloat height =(kScreenHeight*2);
//    [baseScrollView scrollRectToVisible:CGRectMake(0, -64, kScreenWidth, height+30) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    CGRect screenSize = [UIScreen mainScreen].bounds;
//    if (screenSize.size.height == 812) {
//        return;
//    }
//    CGFloat height =(kScreenHeight-64-49-30);
//    [baseScrollView scrollRectToVisible:CGRectMake(0, -64, kScreenWidth, height+30) animated:YES];
}

-(void)createUI
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
    
    
    
    
    //第2部分
    self.secondPartView= [[UIView alloc] initWithFrame :CGRectMake(0,kScreenWidth/3,kScreenWidth,kScreenWidth+15)];
    self.secondPartView.backgroundColor = [UIColor backgroundColor];
    
    [baseScrollView addSubview:self.secondPartView];
    
    
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
          
            FullScreenViewController *vc =[[FullScreenViewController alloc]init];
            
           
         
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 2:
        {
            
            LockViewController *vc =[[LockViewController alloc]init];
            
            
            
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        default:
            break;
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
        DebugLog(@"DetailTakeOneViewController 33333333333333");
}




#pragma mark ----------------------生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=NO;
    self.viewController = self;
    [AppDefault shareDefault].isDeleteRSIStartModel =YES;
    [AppDefault shareDefault].RSIOrWRNum =KDJNUM;
    [self createUI];
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    
   
    self.view.backgroundColor = [UIColor backgroundColor];
    
  
    [AppDefault shareDefault].klineOfWidth = self.secondPartView.frame.size.width;
    [AppDefault shareDefault].klineOfHeight = self.secondPartView.frame.size.height;
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor = [UIColor backgroundColor];
    [self newBTCKline];
    
    [self createLine];
    
}

- (void)createLine
{
    
    CGFloat height = (KScreenH-30)*0.65;
    if ( KScreenW == 480) {
        height = (KScreenH-40)*0.65;
    }
    
    ZMWWeakSelf(self)
    NSArray * array = @[@"分时",@"15分",@"30分",@"1小时",
                        @"4小时",@"1天",@"1周",@"1月",
                        @"5分钟",@"指标"
                        ];
    MenuView * menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 15) buttonTitleArr:array completeBlock:^(NSInteger index) {
        NSLog(@"index11111 = %ld",index);
        
        switch (index) {
            case 1://分时
            {
                weakself.klineString =@"分时";
                weakself.tempIndex = 1;
            }
                break;
            case 2://5分
            {
                weakself.klineString =@"15分";
                weakself.tempIndex = 2;
            }
                break;
            case 3://30分
            {
                weakself.klineString =@"30分";
                weakself.tempIndex = 3;
            }
                break;
            case 4://1小时
            {
                weakself.klineString =@"1小时";
                weakself.tempIndex = 4;
            }
                break;
                
            case 5://4小时
            {
                weakself.tempIndex = 5;
                weakself.klineString =@"4小时";
            }
                break;
            case 6://1天
            {
                weakself.klineString =@"1天";
                weakself.tempIndex = 6;
            }
                break;
            case 7://1周
            {
                weakself.klineString =@"1周";
                weakself.tempIndex = 7;
            }
                break;
            case 8://1月
            {
                weakself.klineString =@"1月";
                weakself.tempIndex = 8;
            }
                break;
            case 9://5分钟 1分钟
            {
                weakself.klineString =@"5分钟";
                weakself.tempIndex = 9;
            }
                break;
            case 10://指标
            {
                weakself.klineString =@"指标";
                weakself.tempIndex = 10;
            }
                break;
            default:
                break;
        }
        menuView.backgroundColor = [UIColor clearColor];
        menuView.isFullScreen = YES;
        if (weakself.tempIndex ==9) {
            _popUpView.hidden = YES;
            
            
            if (_popMinuteView.hidden == NO) {
                
                
                _popMinuteView.hidden = YES;
            }else
            {
                _popMinuteView.hidden = NO;
                
                
            }
            
        }
        else  if ([weakself.klineString isEqualToString:@"指标"]) {
            _popMinuteView.hidden = YES;
            
            if (_popUpView.hidden == NO) {
                
                
                _popUpView.hidden = YES;
            }else
            {
                _popUpView.hidden = NO;
                
                
            }
        }
        else
        {
            
            _popUpView.hidden = YES;
            _popMinuteView.hidden = YES;
            if (weakself.tempIndex>7) {
                weakself.tempIndex =7;
            }
            
            
            UIButton *btnType = (UIButton*)[weakself.view viewWithTag:Y_StockChartSegmentStartTag+ weakself.tempIndex];
            
            //NSLog(@"btnType1241254136=%ld",(long)Y_StockChartSegmentStartTag+ weakself.tempIndex);
            [_stockChartView.segmentView event_segmentButtonClicked:btnType];
            //
            
        }
        
        
        
        
    }];
    
    
    [self.secondPartView addSubview:menuView];
    self.menuView = menuView;
    
//    _popTitleView = [[UIView alloc]init];
//    [self.secondPartView addSubview:_popTitleView];
//    [self.secondPartView bringSubviewToFront:_popTitleView];
//    _popTitleView.backgroundColor = [UIColor backgroundColor];
//    _popTitleView.frame = CGRectMake(5,20,KScreenW,20) ;//40
//
//    NSArray *titleArr = @[@"OMG/ETH",@"0.020792 -2.54%=52.42CNY",@"高0.0218 低0.020721量 146475"];
//    for (int i =0; i<3; i++) {
//        UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(_popTitleView.bounds.size.width/4*i, 0, _popTitleView.bounds.size.width/4,_popTitleView.bounds.size.height)];
//        label.font = [UIFont systemFontOfSize:11];
//        label.text=titleArr[i];
//        label.textAlignment =NSTextAlignmentLeft;
//        label.textColor =[UIColor colorWithRed:0.77f green:0.06f blue:0.00f alpha:1.00f];;
//        [_popTitleView addSubview:label];
//    }

    
    
    
    
    _popUpView = [[UIView alloc]init];
    [self.secondPartView addSubview:_popUpView];
    [self.secondPartView bringSubviewToFront:_popUpView];
    _popUpView.backgroundColor = [UIColor backgroundColor];
    
    _popUpView.hidden = YES;
    _popUpView.frame = CGRectMake(0,15,KScreenW,60) ;//40
    
    NSArray *titleArray = @[@"主图 |",@"MA", @"BOLL"];
    NSArray *titleArray2 = @[@"副图 |",@"MACD",@"KDJ",@"RSI",@"WR"];
    for (int i= 0; i<titleArray.count; i++) {
        UIButton *button =[[ UIButton alloc]initWithFrame:CGRectMake(0+i*50, 0, 50, 30)];
        [button setTitle:titleArray[i] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(chooseBtnViewClick:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 600+i;
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        [_popUpView addSubview:button];
        
    }
    
    for (int i= 0; i<titleArray2.count; i++) {
        UIButton *button =[[ UIButton alloc]initWithFrame:CGRectMake(0+i*50, 30, 50, 30)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button setTitle:titleArray2[i] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(chooseBtnViewClick:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 605+i;
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        [_popUpView addSubview:button];
        
    }
    
    
    _popMinuteView = [[UIView alloc]init];
    [self.secondPartView addSubview:_popMinuteView];
    [self.secondPartView bringSubviewToFront:_popMinuteView];
    _popMinuteView.backgroundColor = [UIColor backgroundColor];
    
    _popMinuteView.hidden = YES;
    _popMinuteView.frame = CGRectMake(0,15,KScreenW,30) ;//40
    
    NSArray *_popMinuteViewArray = @[@"1分钟", @"5分钟"];
    
    for (int i= 0; i<_popMinuteViewArray.count; i++) {
        UIButton *button =[[ UIButton alloc]initWithFrame:CGRectMake(0+i*50, 0, 50, 30)];
        [button setTitle:_popMinuteViewArray[i] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(chooseBtnViewClick:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 690+i;
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        [_popMinuteView addSubview:button];
        
    }
    
    
}
//#pragma mark -退出全屏
//-(void)exitBtn
//{
//
//    [self.navigationController popViewControllerAnimated:YES];
//}




#pragma mark- 点击自定义
-(void)chooseBtnViewClick:(UIButton*)button
{
    
    NSDictionary *dict = @{
                           @"分时":@"1", @"15分":@"2", @"30分":@"3",
                           @"1小时":@"4",@"4小时":@"5", @"1天":@"6",
                           @"1周":@"7",@"1月":@"8", @"5分钟":@"9",
                           @"指标":@"10",@"1分钟":@"11", @"MA":@"12",
                           @"BOLL":@"13",@"MACD":@"14", @"KDJ":@"15",
                           @"RSI":@"16",@"WR":@"17"
                           };
    
    
    NSString *numString= dict[button.titleLabel.text] ;
    
    NSInteger num = [numString integerValue];
    //
    
    _popUpView.hidden = YES;
    _popMinuteView.hidden = YES;
    //NSArray *titleArr = @[@"MACD",@"KDJ",@"关闭",@"MA",@"EMA",@"BOLL",@"关闭"];
    [AppDefault shareDefault].RSIOrWRNum =KDJNUM;
    if (num==9) {
        
        [self.menuView selectedFullScreenIndexButtonWithTag:9 title:button.titleLabel.text];
        
        self.tempIndex =1;
        [self getButtonWithTag: self.tempIndex];
    }
    else if (num==11) {
        
        [self.menuView selectedFullScreenIndexButtonWithTag:9 title:button.titleLabel.text];
        
        self.tempIndex =3;
        [self getButtonWithTag: self.tempIndex];
    }
    else if (num==12) {//ma
        self.tempIndex =103;
        [self getButtonWithTag: self.tempIndex];
    }
    else if (num==13) {
        //@"BOLL":@"13"
        self.tempIndex =105;
        [self getButtonWithTag: self.tempIndex];
    }
    else if (num==14) {//@"MACD":@"14",
        self.tempIndex =100;
        [self getButtonWithTag: self.tempIndex];
    }
    else if (num==15) {
        //2101 KDJ
        self.tempIndex =101;
        [self getButtonWithTag: self.tempIndex];
          [AppDefault shareDefault].RSIOrWRNum =KDJNUM;
    }
    else if (num==16) {
        self.tempIndex =101;
        
          [AppDefault shareDefault].RSIOrWRNum =KDJNUM;
        [self getButtonWithTag: self.tempIndex];
    }
    else if (num==17) {
        self.tempIndex =101;
       
          [AppDefault shareDefault].RSIOrWRNum =KDJNUM;
        [self getButtonWithTag: self.tempIndex];
    }
}
-(void)getButtonWithTag:(NSInteger)tag
{
    UIButton *btnType = (UIButton*)[self.view viewWithTag:Y_StockChartSegmentStartTag+ tag];
    
    NSLog(@"btnType1241254136=%ld",(long)Y_StockChartSegmentStartTag+ tag);
    [_stockChartView.segmentView event_segmentButtonClicked:btnType];
}

#pragma mark-*************************
#pragma mark-newBTCKline-start
-(void)newBTCKline{
    self.currentIndex = -1;
    self.stockChartView.backgroundColor = [UIColor backgroundColor];
    self.view.backgroundColor = [UIColor backgroundColor];
}
- (NSMutableDictionary<NSString *,Y_KLineGroupModel *> *)modelsDict
{
    if (!_modelsDict) {
        _modelsDict = @{}.mutableCopy;
    }
    return _modelsDict;
}
-(id) stockDatasWithIndex:(NSInteger)index
{
    //    NSDictionary *dict = @{
    //                           @"0":@"分时",
    //                           @"1":@"分时", @"2":@"15分", @"3":@"30分",
    //                           @"4":@"1小时",@"5":@"4小时", @"6":@"1天",
    //                           @"7":@"1周",@"8":@"1月", @"9":@"5分钟",
    //                           @"10":@"指标",@"11":@"1分钟", @"12":@"MA",
    //                           @"13":@"BOLL",@"14":@"MACD", @"15":@"KDJ",
    //                           @"16":@"RSI",@"WR":@"17"
    //                           };
    NSString *type;
    //先不管调接口的，的参数只有这几个
    NSLog(@"KKKK=%ld", (long)index);
    
    switch (index) {
        case 0:
        {
            type = @"1min";
        }
            break;
        case 1:
        {
            type = @"1min";
        }
            break;
        case 2:
        {
            type = @"1min";
        }
            break;
        case 3:
        {
            type = @"5min";
        }
            break;
        case 4:
        {
            type = @"30min";
        }
            break;
        case 5:
        {
            type = @"1hour";
        }
            break;
        case 6:
        {
            type = @"1day";
        }
            break;
        case 7:
        {
            type = @"1week";
        }
            break;
            
        default:
            break;
    }
    
    
    if(index>7){
        self.currentIndex  =7;
        self.type = @"1week";
    }else if(index>=0){
        self.type = type;
        self.currentIndex = index;
    }else{
        //请求网址暂时传空
    }
    DebugLog(@"self.type==%@ KKKK index=%ld",self.type,(long)self.currentIndex );
    
    
    if(![self.modelsDict objectForKey:self.type])
    {
        
        [self reloadData];
    } else {
        return [self.modelsDict objectForKey:self.type].models;
    }
    return nil;
}

- (void)reloadData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = self.type;
    param[@"market"] = @"btc_usdt";
    param[@"size"] = @"1000";
    [AFNetworkingTool requestWithApi:@"http://api.bitkk.com/data/v1/kline" param:param thenSuccess:^(NSDictionary *responseObject) {
        
        Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:responseObject[@"data"]];
        self.groupModel = groupModel;
        [self.modelsDict setObject:groupModel forKey:self.type];
        NSLog(@"%@",groupModel);
        [self.stockChartView reloadData];
    } fail:^{
        
    }];
}
- (Y_StockChartView *)stockChartView
{
    if(!_stockChartView) {
        _stockChartView = [Y_StockChartView new];
        _stockChartView.itemModels = @[
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"指标" type:Y_StockChartcenterViewTypeOther],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"分时" type:Y_StockChartcenterViewTypeTimeLine],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"1分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"5分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"30分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"60分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"日线" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"周线" type:Y_StockChartcenterViewTypeKline],
                                       
                                       ];
        _stockChartView.backgroundColor = [UIColor orangeColor];
        _stockChartView.dataSource = self;
        [self.secondPartView addSubview:_stockChartView];
        //        [_stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            if (IS_IPHONE_X) {
        //                make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 30, 0, 0));
        //            } else {
        //                make.edges.equalTo(self.view);
        //            }
        //        }];
        
        //        if (IS_IPHONE_X)
        //        {
        //             _stockChartView.frame = CGRectMake(-47,40, KScreenW+47, KScreenH-15-40);
        //        }else
        //        {
        //             _stockChartView.frame = CGRectMake(-47,40, KScreenW+47, KScreenH-15-40);
        //        }
        
        if (IS_IPHONE_X)
        {
            _stockChartView.frame = CGRectMake(0,40, KScreenW, KScreenH-15-40);
        }else
        {
            _stockChartView.frame = CGRectMake(0,40, KScreenW, KScreenH-15-40);
        }
          _stockChartView.frame = CGRectMake(0,15, KScreenW, KScreenW);
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
//        tap.numberOfTapsRequired = 2;
//        [self.view addGestureRecognizer:tap];
    }
    return _stockChartView;
}
#pragma mark ----------------------横屏
- (void)LandscapePortrait{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationMaskPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
        
        
    }
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}




#pragma mark  view周期
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self LandscapePortrait];
     self.navigationController.navigationBarHidden=YES;
     self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    
}
@end

