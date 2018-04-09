//
//  MainSetViewController.m
//  TeaLeaves
//
//  Created by 张美文 on 15/11/13.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "MainSetViewController.h"
#import "ExtendTextField.h"
#import "VerticalLineScrollView.h"
#import "MainWebViewController.h"

//#import "LoginViewController.h"
#import "GetBannerModel.h"
#import "ADScrollView.h"
#import "MYBlurIntroductionView.h"
//#import "NoticeDetailViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>

@interface MainSetViewController ()<UIScrollViewDelegate,MYIntroductionDelegate>

@property (nonatomic, strong) MYBlurIntroductionView *introductionView;
@property (strong, nonatomic)  VerticalLineScrollView *verticalLineView;
@property (strong, nonatomic)  ADScrollView *adBannerView;
@property (nonatomic, strong) dispatch_source_t bannerTimer;

@end

@implementation MainSetViewController
{
    UIScrollView *baseScrollView;
    ZMWAssistiveTouchView *mwindow;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat height =(kScreenHeight-64-49-30);
    [baseScrollView scrollRectToVisible:CGRectMake(0, -64, kScreenWidth, height+30) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGRect screenSize = [UIScreen mainScreen].bounds;
    if (screenSize.size.height == 812) {
        return;
    }
    CGFloat height =(kScreenHeight-64-49-30);
    [baseScrollView scrollRectToVisible:CGRectMake(0, -64, kScreenWidth, height+30) animated:YES];
}

-(void)createUI
{
    CGFloat height =(kScreenHeight-64-49-30);
   
    
    baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height+30)];
    baseScrollView.backgroundColor = [UIColor backgroundColor];
    baseScrollView.scrollEnabled = YES;
    baseScrollView.bounces = YES;
    baseScrollView.delegate = self;
    baseScrollView.showsVerticalScrollIndicator = NO;
    baseScrollView.contentSize = CGSizeMake(kScreenWidth,height+30);
    [self.view addSubview:baseScrollView];
    
    self.adBannerView = [[ADScrollView alloc] initWithFrame :CGRectMake(0,0,kScreenWidth,height/5*2)];
    self.adBannerView.backgroundColor = [UIColor backgroundColor];
    
    self.verticalLineView = [[VerticalLineScrollView alloc] initWithFrame:CGRectMake(0,height/5*2,kScreenWidth,30+10)];
    [baseScrollView addSubview:self.adBannerView];
    
    [baseScrollView addSubview:self.verticalLineView];
    
    
    
  
}
- (void)buttonPressed:(UIButton*)button
{
    
}
#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.viewController = self;
    
    __weak typeof(self) weakSelf = self;
    
    self.title = @"首页";

    [self createUI];
    
    
    //垂直广告条
    self.verticalLineView.block = ^(ZMWGetNewArticle *model){
        
//        NoticeDetailViewController * noticeDVC = [[NoticeDetailViewController alloc] initWithNibName:@"NoticeDetailViewController" bundle:nil];
//        noticeDVC.hidesBottomBarWhenPushed = YES;
//        noticeDVC.ID = model.ID;
//        [weakSelf.navigationController pushViewController:noticeDVC animated:YES];

    };
    
    self.adBannerView.block = ^(NSString *bannerUrl){
        
        MainWebViewController *webVctr = [[MainWebViewController alloc] initWithNibName:@"MainWebViewController" bundle:nil];
        webVctr.hidesBottomBarWhenPushed = YES;
        webVctr.webURL = bannerUrl;
        DebugLog(@"bannerUrlbannerUrl=%@",bannerUrl);
        [weakSelf.navigationController pushViewController:webVctr animated:YES];
    };
    
    // 获取广告列表
    [self requestBanner];
    
    // alert广告页面
    if ([self newfeatureInterface]) {
       // [self initializeLoadingView];
    }else {
        if ([LoginMessage checkLogin]) {
//            [self requestShowTip];
        }
        if (![[NSUserDefaults standardUserDefaults] boolForKey:ZMWMainSetViewAlert]) {
            //
            //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:ZMWMainSetViewAlert];
          //  [self requestShowTip];

        }


    }

    
}

// 加载loading页面
- (BOOL)newfeatureInterface {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleShortVersionString"];
    //    DebugLog(@"sdkfljsdlkfjslkdfjl: %@-%@", sandboxVersion, [sandboxVersion class]);
    
    if ([currentVersion compare:sandboxVersion] == NSOrderedDescending) {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"CFBundleShortVersionString"];
        return YES;
    }
    
    return NO;
    
}


// 首页alter广告栏
- (void)requestShowTip {
    /**
     GET /showTip 弹出公告
     Implementation Notes
     弹出公告
     旧接口： showTip
     */
    [AFNetworkingTool getJSONWithUrl:@"showTip" parameters:nil success:^(id responseObject) {
        //
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        DebugLog(@"resultDic>>showTip: %@", resultDic);
        
        if ([[resultDic objectForKey:@"code"] isEqualToString:@"000000"]) {
            //
            
            ZMWTeaAlertView *shareView = [[ZMWTeaAlertView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
            shareView.urlString = [[resultDic objectForKey:@"data"] objectForKey:@"url"];
            [shareView showInWindowWithBackgoundTapDismissEnable:YES];
            
        }
        
    } fail:^(NSError *error) {
        //
        
    }];
}

- (void)shareSDKShow{
    
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
//    __weak MainSetViewController *theController = self;
    
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    [shareParams SSDKSetupShareParamsByText:shareContent
                                     images:imageArray
                                        url:[NSURL URLWithString:@"http://www.mob.com"]
                                      title:shareTitle
                                       type:SSDKContentTypeAuto];
    
    //2、分享
    [ShareSDK showShareActionSheet:self.view
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   //assistive
                   [self.view.window makeKeyAndVisible];

                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
//                           [theController showLoadingView:YES];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           //Facebook Messenger、WhatsApp等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                           if (platformType == SSDKPlatformTypeFacebookMessenger)
                           {
                               break;
                           }
                           
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
                   
                   if (state != SSDKResponseStateBegin)
                   {
//                       [theController showLoadingView:NO];
//                       [theController.tableView reloadData];
                   }
                   
               }];
    
}

#pragma mark - 首页请求

static int bannerCnt = 0;
- (void)requestBanner{
    [AFNetworkingTool getJSONWithUrl:@"getBanner" parameters:nil success:^(id json) {
        //
//        NSDictionary *resulteDic = (NSDictionary *)json;
        NSDictionary *resulteDic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];

        DebugLog(@"getBanner>>>dic:%@", resulteDic);
        GetBannerModel *model;
        if ([[resulteDic objectForKey:@"code"] isEqualToString:@"000000"]) {
            if (self.bannerTimer) {
                dispatch_cancel(self.bannerTimer);
            }
            [self.adBannerView.bannerListURL removeAllObjects];
            
            for (NSDictionary *dic in [resulteDic objectForKey:@"data"]) {
               
                
                
            }
          GetBannerModel  *model1 = [GetBannerModel new];
            model1.bannerPicture =@"http://img2.imgtn.bdimg.com/it/u=3964650152,879817888&fm=200&gp=0.jpg";
            [self.adBannerView.bannerListURL addObject:model1];
             GetBannerModel  *model2 = [GetBannerModel new];
            model2.bannerPicture =@"http://img4.imgtn.bdimg.com/it/u=662325007,922095177&fm=200&gp=0.jpg";
            [self.adBannerView.bannerListURL addObject:model2];
             GetBannerModel  *model3 = [GetBannerModel new];
            model3.bannerPicture =@"http://img3.imgtn.bdimg.com/it/u=3118293396,1228778665&fm=27&gp=0.jpg";
            [self.adBannerView.bannerListURL addObject:model3];
             GetBannerModel  *model4 = [GetBannerModel new];
            model4.bannerPicture =@"http://imgsrc.baidu.com/image/c0%3Dpixel_huitu%2C0%2C0%2C294%2C40/sign=3faf09c20146f21fdd3956139f5c0e0c/5243fbf2b2119313581bb8896e380cd791238dab.jpg";
            [self.adBannerView.bannerListURL addObject:model4];
             GetBannerModel  *model5 = [GetBannerModel new];
            model5.bannerPicture =@"http://imgsrc.baidu.com/image/c0%3Dpixel_huitu%2C0%2C0%2C294%2C40/sign=971909346c09c93d13ff06b7f6459db0/5366d0160924ab18c925a20d3efae6cd7b890bdc.jpg";
            [self.adBannerView.bannerListURL addObject:model5];
            
            [self.adBannerView setNeedsLayout];
            [self.adBannerView layoutIfNeeded];
        }
                
        DebugLog(@"dlksjflksdjf:%@==%@", model.declare, model.status);
        
    } fail:^(NSError *error){
        //
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)),5.0*NSEC_PER_SEC, 0);
        self.bannerTimer = _timer;
        
        dispatch_source_set_event_handler(_timer, ^{
            if (bannerCnt < 100) {
                [self requestBanner];

            }else {
                dispatch_cancel(self.bannerTimer);
            }
            bannerCnt++;
        });
        dispatch_resume(_timer);
    }];
}








- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [AppDefault  shareDefault].adressPathNum = 1;
   
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)initializeLoadingView{
    MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) nibNamed:@"ZMWLoadingFirstView"];
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) nibNamed:@"ZMWLoadingSecondView"];
    MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) nibNamed:@"ZMWLoadingThirdView"];
    MYIntroductionPanel *panel4 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) nibNamed:@"ZMWLoadingFourView"];
//    [panel4 addSubview:[self panelButton]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        ZMWAssistiveTouchView *touchView = [ZMWAssistiveTouchView sharedZMWAssistiveTouchView];
//        touchView.alpha = 0;
    });
    NSArray *panels = @[panel1, panel2, panel3, panel4];
    MYBlurIntroductionView *introductionView = [[MYBlurIntroductionView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    introductionView.RightSkipButton.hidden = YES;
    introductionView.PageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"C50000"];
    introductionView.PageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"CCCCCC"];
    introductionView.delegate = self;
    [introductionView setBackgroundColor:[UIColor backgroundColor]];
    [introductionView buildIntroductionWithPanels:panels];
    [self.tabBarController.view addSubview:introductionView];
    
    self.introductionView = introductionView;
}

- (UIButton *)panelButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((KScreenW-124)*0.5, KScreenH-137, 124, 34);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithHexString:@"C50000"].CGColor;
    [button setTitle:@"马上体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"C50000"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)buttonAction:(UIButton *)button{
    [self.introductionView didPressSkipButton];
}

- (void)introduction:(MYBlurIntroductionView *)introductionView didFinishWithType:(MYFinishType)finishType{
  
}

- (void)introduction:(MYBlurIntroductionView *)introductionView alpha:(CGFloat)alpha{
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
