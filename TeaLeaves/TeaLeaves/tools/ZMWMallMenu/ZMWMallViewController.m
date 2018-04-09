//
//  ZMWMallViewController.m
//  TeaLeaves
//
//  Created by 张美文 on 2016/11/18.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWMallViewController.h"
#import "ZMWSubMallViewController.h"
#import "ZMWScrollTitleView.h"
#import "ZMWMallContentView.h"
#import "ZMWPopoverAnimator.h"
#import "ZMWPopMenuViewController.h"

#import "TakeViewController.h"

static CGFloat const titleH = 44;
static CGFloat const navBarH = 64;
static CGFloat const maxTitleScale = 1.0;//1.3
static int  const buttonTag = 100;
#define YCKScreenW [UIScreen mainScreen].bounds.size.width
#define YCKScreenH [UIScreen mainScreen].bounds.size.height

@interface ZMWMallViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)TakeViewController *oneViewController;
@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
// 选中按钮
@property (nonatomic, weak) UIButton *selTitleButton;

@property (nonatomic, strong) NSMutableArray *buttons;





@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ZMWScrollTitleView *topView;
@property (nonatomic, strong) ZMWMallContentView *bottomView;
@property (nonatomic, strong) ZMWPopMenuViewController *popMenuVctr;
@property (nonatomic, strong) ZMWPopoverAnimator *popverAnimator;

@end

@implementation ZMWMallViewController
{
    BOOL isRight;
}
- (NSMutableArray *)buttons
{
    if (!_buttons)
    {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
    [self leftAndRightView];
    
    [self setupTitleScrollView];
    [self setupContentScrollView];
    [self addChildViewController];
    [self setupTitle];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * YCKScreenW, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.delegate = self;
}
-(void)leftAndRightView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, KScreenW, 44)];
    headerView.backgroundColor = [UIColor backgroundColor];
    [self.view addSubview:headerView];
     NSArray *array = [NSArray arrayWithObjects:@"家具",@"灯饰", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    segment.frame = CGRectMake(KScreenW/2-80, 7, 160, 30);
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;
    segment.tintColor = [UIColor whiteColor];
   // [segment setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
    segment.backgroundColor =[UIColor backgroundColor];
    //添加到视图
    [headerView addSubview:segment];
    
//    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
//    leftButton.backgroundColor = [UIColor backgroundColor];
//    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
//    [leftButton setTitle:@"左边" forState:UIControlStateNormal ];
//    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
//    [headerView addSubview:leftButton];
//    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 0, 100, 44)];
//    rightButton.backgroundColor = [UIColor backgroundColor];
//    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
//    [rightButton setTitle:@"右边" forState:UIControlStateNormal ];
//    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
//    [headerView addSubview:rightButton];
    
    
}
-(void)change:(UISegmentedControl *)sender{
   
    if (sender.selectedSegmentIndex == 0) {
        [AppDefault shareDefault].isRightAboutTakeVC =NO;
        
        self.contentScrollView.contentSize = CGSizeMake((self.childViewControllers.count-0) * YCKScreenW, 0);
        self.contentScrollView.contentOffset = CGPointMake(KScreenW, 0);
        
        UIButton *btn1 = (UIButton*)[self.view viewWithTag:buttonTag];
        [btn1 setTitle:@"头条" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        UIButton *btn2 = (UIButton*)[self.view viewWithTag:buttonTag+1];
        [btn2 setTitle:@"热点" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIButton *btn3 = (UIButton*)[self.view viewWithTag:buttonTag+2];
        [btn3 setTitle:@"视频" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        UIButton *btn4 = (UIButton*)[self.view viewWithTag:buttonTag+3];
        btn4.userInteractionEnabled =YES;
        btn4.alpha=1;
        [self chick:btn2];
    }else if (sender.selectedSegmentIndex == 1){
        [AppDefault shareDefault].isRightAboutTakeVC =YES;
        
        self.contentScrollView.contentSize = CGSizeMake((self.childViewControllers.count-1) * YCKScreenW, 0);
        self.contentScrollView.contentOffset = CGPointMake(KScreenW, 0);
        
        UIButton *btn1 = (UIButton*)[self.view viewWithTag:buttonTag];
        [btn1 setTitle:@"语文" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        UIButton *btn2 = (UIButton*)[self.view viewWithTag:buttonTag+1];
        [btn2 setTitle:@"数学" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIButton *btn3 = (UIButton*)[self.view viewWithTag:buttonTag+2];
        [btn3 setTitle:@"英语" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        UIButton *btn4 = (UIButton*)[self.view viewWithTag:buttonTag+3];
        btn4.userInteractionEnabled =NO;
        btn4.alpha=0;
        [self chick:btn2];
    }else if (sender.selectedSegmentIndex == 2){
        NSLog(@"3");
    }else if (sender.selectedSegmentIndex == 3){
        NSLog(@"4");
    }
}


#pragma mark - 设置头部标题栏
- (void)setupTitleScrollView
{
   
    
    // 判断是否存在导航控制器来判断y值
    CGFloat y = self.navigationController ? navBarH : 0;
    CGRect rect = CGRectMake(0, y, YCKScreenW, titleH);
    
    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
    titleScrollView.backgroundColor = [UIColor backgroundColor];
    [self.view addSubview:titleScrollView];
    //设置按页滚动
    self.titleScrollView.pagingEnabled = NO;
    
    //设置不许出界
    self.titleScrollView.bounces = NO;
    
    //隐去滚动条
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView = titleScrollView;
    
}

#pragma mark - 设置内容
- (void)setupContentScrollView
{
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect rect = CGRectMake(0, y, YCKScreenW, YCKScreenH - navBarH);
    
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    contentScrollView.backgroundColor = [UIColor backgroundColor];
    [self.view addSubview:contentScrollView];
    
    self.contentScrollView = contentScrollView;
}

#pragma mark - 添加子控制器
- (void)addChildViewController
{
    TakeViewController *vc = [[TakeViewController alloc] init];
    vc.title = @"头条";
    [self addChildViewController:vc];
    
    TakeViewController *vc1 = [[TakeViewController alloc] init];
    vc1.title = @"热点";
    [self addChildViewController:vc1];
    
    TakeViewController *vc2 = [[TakeViewController alloc] init];
    vc2.title = @"视频";
    [self addChildViewController:vc2];
    
    TakeViewController *vc3 = [[TakeViewController alloc] init];
    vc3.title = @"社会";
    [self addChildViewController:vc3];
    
   
    
}

#pragma mark - 设置标题
- (void)setupTitle
{
    NSUInteger count = self.childViewControllers.count;
   
    CGFloat x = 0;
    CGFloat w = 60;
    CGFloat h = titleH;
    
    for (int i = 0; i < count; i++)
    {
        UIViewController *vc = self.childViewControllers[i];
        
        x = i * w;
        CGRect rect = CGRectMake(x, 0, w, h);
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
        
        btn.tag = i+buttonTag;
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [btn addTarget:self action:@selector(chick:) forControlEvents:UIControlEventTouchDown];
        
        [self.buttons addObject:btn];
        [self.titleScrollView addSubview:btn];
        
        if (i == 0)
        {
            
            [self chick:btn];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        
    }
    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
  
}

// 按钮点击
- (void)chick:(UIButton *)btn
{
    [self selTitleBtn:btn];
    
    NSUInteger i = btn.tag-buttonTag;
    CGFloat x = i * YCKScreenW;
    
    [self setUpOneChildViewController:i];
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
     _oneViewController  =(TakeViewController *)self.childViewControllers[i] ;
    [_oneViewController.tableView reloadData];
    
    
}
// 选中按钮
- (void)selTitleBtn:(UIButton *)btn
{
    [self.selTitleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.selTitleButton.transform = CGAffineTransformIdentity;
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(maxTitleScale, maxTitleScale);
    
    self.selTitleButton = btn;
    [self setupTitleCenter:btn];
}

- (void)setUpOneChildViewController:(NSUInteger)i
{
    CGFloat x = i * YCKScreenW;
    
    UIViewController *vc = self.childViewControllers[i];
    
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(x, 0, YCKScreenW, YCKScreenH - self.contentScrollView.frame.origin.y);
    
    [self.contentScrollView addSubview:vc.view];
    _oneViewController  =(TakeViewController *)self.childViewControllers[i] ;
     [_oneViewController.tableView reloadData];
}

- (void)setupTitleCenter:(UIButton *)btn
{
//    CGFloat offset = btn.center.x - YCKScreenW * 0.5;
//
//    if (offset < 0)
//    {
//        offset = 0;
//    }
//
//    CGFloat maxOffset = self.titleScrollView.contentSize.width - YCKScreenW;
//    if (offset > maxOffset)
//    {
//        offset = maxOffset;
//    }
//
//    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
//
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger i = self.contentScrollView.contentOffset.x / YCKScreenW;
    [self selTitleBtn:self.buttons[i]];
    [self setUpOneChildViewController:i];
    
    _oneViewController  =(TakeViewController *)self.childViewControllers[i] ;
     [_oneViewController.tableView reloadData];
}

// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger leftIndex = offsetX / YCKScreenW;
    NSInteger rightIndex = leftIndex + 1;
    
    //    NSLog(@"%zd,%zd",leftIndex,rightIndex);
    
    UIButton *leftButton = self.buttons[leftIndex];
    
    UIButton *rightButton = nil;
    if (rightIndex < self.buttons.count) {
        rightButton = self.buttons[rightIndex];
    }
    
    CGFloat scaleR = offsetX / YCKScreenW - leftIndex;
    
    CGFloat scaleL = 1 - scaleR;
    
    
    CGFloat transScale = maxTitleScale - 1;
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    
    rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
    
    
    //UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    //UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    
   // [leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    self.viewController = self;
//    self.title = @"商城";
//
//    // 创建顶部标题栏
//    [self createTopView];
//
//    // 创建底部内容栏
//    //1. 子视图
//    [self setupChildViewController];
//    //2. 容器
//    [self createBottomView];
//
//    // 初始化时默认0
//    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:ZMWPopMenuViewControllerIndex];
//
//}
//
//- (void)setupChildViewController {
//
//    for (int i = 0; i < self.dataArray.count; i++) {
//        TakeViewController *childVctr = [[TakeViewController alloc] init];
//        childVctr.title = self.dataArray[i];
//        NSString *tmpString = [self.dataArray[i] componentsSeparatedByString:@"年"].firstObject;
//        childVctr.marketYear = tmpString;
//        [self addChildViewController:childVctr];
//    }
//}
//
//- (void)createTopView {
//    ZMWWeakSelf(self)
//
//    // 容器视图控制器
//    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, KScreenW, 60)];
//    containerView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
//    [self.view addSubview:containerView];
//
//    // 左边视图
//    ZMWMallTitleLab *leftLab = [[ZMWMallTitleLab alloc] initWithFrame:CGRectMake(0, 30, KScreenW/5, 30)];
//    leftLab.backgroundColor = [UIColor orangeColor];
//    leftLab.text = @"全部";
//    leftLab.scale = 1.0;
//    [containerView addSubview:leftLab];
//
//    // 中间视图
//    ZMWScrollTitleView *topView = [[ZMWScrollTitleView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 44) titleItems:self.dataArray fetchCompletionHandler:^(NSInteger index) {
//        //
//        [weakself scrollViewDidEndScroll:index];
//
//    }];
//
//    [containerView addSubview:topView];
//    self.topView = topView;
//
////    // 右边视图
//    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenW-0, 0,KScreenW/4, 0)];
//    rightBtn.backgroundColor = [UIColor whiteColor];
//    [rightBtn setImage:[UIImage imageNamed:@"popmenu_down"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
//    [containerView addSubview:rightBtn];
//
//}
//
//- (void)menuAction: (UIButton *)sender {
//    ZMWWeakSelf(self)
//    _popMenuVctr = [[ZMWPopMenuViewController alloc] initWithNibName:@"ZMWPopMenuViewController" bundle:nil];
//    _popMenuVctr.dataArray = self.dataArray;
//    _popMenuVctr.transitioningDelegate = self.popverAnimator;
//    _popMenuVctr.modalPresentationStyle = UIModalPresentationCustom;
//    _popMenuVctr.block = ^(NSInteger index){
//        [weakself scrollViewDidEndScroll:index];
//    };
//    [self presentViewController:_popMenuVctr animated:YES completion:nil];
//
//}
//
//// 滚动到具体位置
//- (void)scrollViewDidEndScroll:(NSInteger)index {
//    CGPoint offset = self.bottomView.contentOffset;
//    offset.x = index * self.bottomView.frame.size.width;
//    [self.bottomView setContentOffset:offset animated:YES];
//
//}
//
//- (void)createBottomView {
//    ZMWWeakSelf(self)
//
//    ZMWMallContentView *bottomView = [[ZMWMallContentView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) contentItems:self.dataArray fetchCompletionHandler:^(CGFloat scale, ZMWMallContentViewType type, UIScrollView *scrollView) {
//        //
//        switch (type) {
//            case kZMWMallContentViewTypeDidScroll:{
//                NSInteger leftIndex = scale;
//                ZMWMallTitleLab *leftLab = weakself.topView.dataArray[leftIndex];
//
//                NSInteger rightIndex = leftIndex + 1;
//
//                ZMWMallTitleLab *rightLab = (rightIndex == weakself.topView.dataArray.count) ? nil : weakself.topView.dataArray[rightIndex];
//
//                CGFloat rightScale = scale - leftIndex;
//                CGFloat leftScale = 1 - rightScale;
//
//                leftLab.scale = leftScale;
//                rightLab.scale = rightScale;
//
//                // progress
//                weakself.topView.slideLab.progress = scale;
//
//                break;
//            }
//            case kZMWMallContentViewTypeUnDidScroll:{
//                //
//                CGFloat width = scrollView.frame.size.width;
////                CGFloat height = scrollView.frame.size.height;
//                CGFloat offsetX = scrollView.contentOffset.x;
//                CGFloat topWidth = scrollView.frame.size.width-KScreenW;
//
//                NSInteger index = offsetX / width;
//                ZMWMallTitleLab *lab = weakself.topView.dataArray[index];
//                CGPoint topOffset = weakself.topView.contentOffset;
//                topOffset.x = lab.center.x - topWidth * 0.5;
//
//                // 菜单栏
//                [[NSUserDefaults standardUserDefaults] setInteger:index forKey:ZMWPopMenuViewControllerIndex];
//
////                DebugLog(@"lab.center.x: %f, width.half: %f --%f", lab.center.x, width*0.5, weakself.topView.contentSize.width - width);
//
//                if (topOffset.x < 0) {
//                    topOffset.x = 0;
//                }
//
//                CGFloat maxTopOffsetX = weakself.topView.contentSize.width - topWidth;
//                if (topOffset.x > maxTopOffsetX) {
//                    topOffset.x = maxTopOffsetX;
//                }
//
//                [weakself.topView setContentOffset:topOffset animated:YES];
//
//                for (ZMWMallTitleLab *otherLabel in self.topView.dataArray) {
//                    if (otherLabel != lab) {
//                        otherLabel.scale = 0.0;
//                        otherLabel.userInteractionEnabled = YES;
//                    }
//                }
//
//                break;
//            }
//            default:
//                break;
//        }
//    }];
//    bottomView.mallVctr = self;
//    [self.view addSubview:bottomView];
//    self.bottomView = bottomView;
//}
//
//- (NSArray *)dataArray {
//    if (_dataArray == nil) {
//        _dataArray = [NSMutableArray array];
//        [_dataArray addObjectsFromArray:@[@"全部", @"2016年", @"2017年", @"2018年"]];
//        // 自动获取年份
//        /*
//         [_dataArray addObject:@"全部"];// , @"第七栏", @"第八栏", @"第九栏"
//        for (NSInteger i = 2016; i <= [self NSDateComponentsForYear]; i++) {
//            [_dataArray addObject:[NSString stringWithFormat:@"%ld年", i]];
//        }
//         */
//    }
//
//    return _dataArray;
//}
//
//- (NSInteger)NSDateComponentsForYear {
//    // 获取代表公历的NSCalendar对象
//    NSCalendar *gregorian = [[NSCalendar alloc]
//                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    // 获取当前日期
//    NSDate* dt = [NSDate date];
//    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
//    unsigned unitFlags = NSCalendarUnitYear |
//    NSCalendarUnitMonth |  NSCalendarUnitDay |
//    NSCalendarUnitHour |  NSCalendarUnitMinute |
//    NSCalendarUnitSecond | NSCalendarUnitWeekday;
//    // 获取不同时间字段的信息
//    NSDateComponents* comp = [gregorian components: unitFlags
//                                          fromDate:dt];
//    // 获取各时间字段的数值
//    /*
//    NSLog(@"现在是%ld年" , comp.year);
//    NSLog(@"现在是%ld月 " , comp.month);
//    NSLog(@"现在是%ld日" , comp.day);
//    NSLog(@"现在是%ld时" , comp.hour);
//    NSLog(@"现在是%ld分" , comp.minute);
//    NSLog(@"现在是%ld秒" , comp.second);
//    NSLog(@"现在是星期%ld" , comp.weekday);
//     */
//
//    return comp.year;
//}
//
//- (ZMWPopoverAnimator *)popverAnimator {
//    if (_popverAnimator == nil) {
//        _popverAnimator = [[ZMWPopoverAnimator alloc] init];
//
//        _popverAnimator.presentFrame = CGRectMake(0, navBarHeight, KScreenW, ZMWPopoverController_H);
//    }
//
//    return _popverAnimator;
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [AppDefault  shareDefault].adressPathNum = 2;
//
//}
//
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
