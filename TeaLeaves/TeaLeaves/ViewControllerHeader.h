//
//  ViewControllerHeader.h
//  TeaLeaves
//
//  Created by xueliaunt on 15/10/16.
//  Copyright (c) 2015年 walter. All rights reserved.
//

#ifndef TeaLeaves_ViewControllerHeader_h
#define TeaLeaves_ViewControllerHeader_h

#import "Masonry.h"
#import "Y_StockChartView.h"
#import "Y_StockChartView.h"
#import "Y_KLineGroupModel.h"
#import "UIColor+Y_StockChart.h"
#import "AppDelegate.h"

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define SCREEN_MAX_LENGTH MAX(kScreenWidth,kScreenHeight)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)



#import "AFNetworkingTool.h"
#import "ZMWUUID.h"
//#import "ZMWAssistiveTouchView.h"
#import "MJExtension.h"
#import "CustomModel.h"
#import "ReactiveObjC.h"
#import "CategoryWF.h"
#import "WZLBadgeImport.h"
//#import "PasswordView.h"
#import "UIView+TYAlertView.h"
#import "SVProgressHUD.h"
#import "MyMD5.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "MJRefresh.h"
#import "MBProgressHUD+define.h"
#import "Masonry.h"
#import "KeyboardManager.h"
#import "ZMWNewWeb.h"
#import "ZMWCardView.h"
#import "UINavigationBar+Awesome.h"
#import "ZMWTeaAlertView.h"
//#import "ZMWShareSheetView.h"
#import "ZMWTabPlaceHolder.h"
#import "ZMWCustomPlaceHolderTab.h"

#import "UIView+TYLaunchAnimation.h"
#import "TYLaunchFadeScaleAnimation.h"
#import "UIImage+TYLaunchImage.h"
#import "TAdLaunchImageView.h"

#import "SPayClient.h"
#import "NSString+SPayUtilsExtras.h"
#import "NSDictionary+SPayUtilsExtras.h"
#import "SPRequestForm.h"
#import "SPHTTPManager.h"
#import "SPConst.h"
#import "XMLReader.h"
#import "UICountingLabel.h"
#import "MarqueeLabel.h"
#import "ZMWScrollLab.h"



//正则验证
#import "Verify.h"

//#import "ZMWImgCodeView.h"

#import "Singleton.h"

//微信
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"

#import "GetWarehouseListModel.h"
//产品交易详情模型
//#import "GetProductDetailModel.h"

// 垂直广告条
#import "ZMWGetNewArticle.h"

// 支持的银行卡列表
//#import "ZMWGetSupportBankList.h"

//用户信息
#import "UserObject.h"
#import "LoginMessage.h"

//#import "ServiceAlertView.h"
//#import "ZMWPurchaseView.h"

#import "TabBarViewController.h"
#import "CustomNavigationController.h"
#import "CustomViewController.h"
#import "CustomMainViewController.h"
#import "MainSetViewController.h"
#import "IndividualViewController.h"
#import "ZMWMallViewController.h"

#import "ZMWMineSetViewController.h"
#import "TakeViewController.h"
#import "FullScreenViewController.h"
#import "AppDelegate.h"
//#import "WarningSetViewController.h"

//#import "ZMWQualificationByUserNoModel.h"

//#import "MineViewController.h"
#import "CycleScrollView.h"
//#import "LoginViewController.h"

//新增Cell 我的
//#import "ZMWMineCellCollectionView.h"
//#import "ZMWMineCell1.h"
//#import "ZMWMineCell2.h"
//#import "ZMWMineCell3.h"
//#import "ZMWMineCell4.h"
//#import "ZMWMineCell5.h"

/**
 *  9个模块的类
 */
//#import "NoticeViewController.h"
//#import "PreSellViewController.h"
//
//#import "ZMWPreSellViewController.h"
//
//#import "OptionalViewController.h"
//#import "BuyViewController.h"
//#import "EntrustViewController.h"
//#import "InformationViewController.h"
//#import "ServeViewController.h"
//#import "HelpViewController.h"
//#import "SellViewController.h"

//login
//#import "RegisterOneViewController.h"
//#import "RegisterTwoViewController.h"
//#import "RegisterThreeViewController.h"
//#import "RegisterFourViewController.h"
//#import "RegisterFiveViewController.h"
//#import "RegisterSixViewController.h"
//#import "RegisterSevenViewController.h"
//#import "RegisterFinishViewController.h"

/**
 *  我的页面的类
 */
//#import "EntrustViewController.h"
//#import "OptionalViewController.h"
//#import "SetViewController.h"
//#import "FundManagerViewController.h"
//#import "ZMWPrePurchaseViewController.h"
//
//#import "RecordViewController.h"
//#import "NewsViewController.h"
//#import "AgreementViewController.h"
//#import "ConsignViewController.h"
//#import "HistoryViewController.h"
////#import "TakeAllViewController.h"
//#import "DrawCashViewController.h"

/**
 *  历史记录
 */
//#import "Entrust_hisViewController.h"
//#import "Turnover_hisViewController.h"
//#import "Consign_hisViewController.h"
//#import "Take_hisViewController.h"
//#import "DrawCash_hisViewController.h"


//日历
#import "HZQDatePickerView.h"

//自定义textfield
#import "CustomTextField.h"

#import "PullSelectView.h"
#import "SWTableViewCell.h"

#import "MBProgressHUD.h"

#import "ZMWRefreshView.h"

/**
 *  设置
 */
//#import "AccountViewController.h"
//#import "WarningViewController.h"
//#import "LawViewController.h"
//#import "ProvisionViewController.h"
//#import "AboutViewController.h"
//#import "AddressListViewController.h"
//#import "AddressViewController.h"
//#import "ChangeTradeViewController.h"
//#import "Reachability.h"

//#import "ZMWNewAwardViewController.h"
//#import "ZMWWebAwardController.h"
//#import "ZMWQuickPayViewController.h"
//#import "ZMWPWDPayViewController.h"
//
//#import "ZMWExplainContainsViewController.h"

/**
 * k线界面
 */
#import "DetailTakeOneViewController.h"
#import "TakeDetailViewController.h"
#import "LeverageViewController.h"
#import "LockViewController.h"
/**
 *  登录
 */
#import "LoginViewController.h"
#import "AppDefault.h"
#import "commond.h"
#endif
