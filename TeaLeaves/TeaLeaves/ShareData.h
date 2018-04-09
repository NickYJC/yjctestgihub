//
//  ShareData.h
//  TeaLeaves
//
//  Created by xueliaunt on 15/10/16.
//  Copyright (c) 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef TeaLeaves_ShareData_h
#define TeaLeaves_ShareData_h

#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...){}
#endif

#ifdef DEBUG
# define DebugLog(format, ...) NSLog((@"[%s Line:%d]" format), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DebugLog(...);
#endif

/**
 配置颜色
 */
#define ColorWithRGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]



#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//仓库
#define GETWAREHOUSELISTINFO @"getWarehouseList.plist"

//消息
#define GETOFFLINEMESSAGEINFO @"getOffLineMessage.plist"

//退到后台时间间隔
#define ENTERBACKGROUNDINTERVALNOTICE @"enterBackgroundIntervalNotice"

//交易密码时间间隔
#define TRADEPASSWORDINTERVALNOTICE @"tradePasswordIntervalNotice"

#define LOGINREQUESTHOSTPARMDIC @"LoginRequestHostParmDic"

//通知资金管理界面title的变化
#define FundManagerViewControllerMenuViewNotice @"FundManagerViewControllerMenuViewNotice"

//添加银行卡成功的通知
#define AddCardViewControllerAddSuccessNotice @"AddCardViewControllerAddSuccessNotice"

//微信支付回调
#define WeChatRefreshUserInfoNotice @"WeChatRefreshUserInfoNotice"

//资料补全
//#define INSPECTUSERINFO @"inspectUserInfo"

//
#define kRequestTime 3.0f
#define kDelay 0.01f

#define kRecordTimeDelay 5 // 交易密码

#define LoginDelay 0.5

// 延时是为了捕捉到服务器最新的信息，添加完成之后马上请求，服务器那边还没有入库
#define delayCarTimer 1.5

//#define PARTNERS @"2088021100510961"//合伙人
#define PARTNERS @"2088121217586621"//合伙人
//#define SELLERS @"18576753755@163.com"//收钱账号
#define SELLERS @"szpztea@163.com"//收钱账号
//#define PRIVATEKEYS @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAN4ReRuIOLjHtEPr+mv6klach3kgwHmtsrkx48V3bnzQCxnHC42bL1xchtmKcmvg5CUisLUhX+WOqZzvOufvi7o0WJDKE6Bqus3ifFZ0OXL2d7OU2djFt28nK/HdZiA29OG/RBrf45bzP7wkco3/6FzM7VrXDxdwyOGpaoPnpSJ/AgMBAAECgYAgSrYrtMFazV9/SP9fWE6TXauth3+1sfZ9S63tdxKP/8i9dN5PNzPJ4IKTe7hry4YhiEvd6v6A6R/s/DS6qXDN2392VNW1TlePmbqBOmOf5QqLC/rIaZ7MVbcKw24pK95odbMqq5NzHqTQ6lCxh6i7mkcXHCEFnEQeUUJxLfB3wQJBAPwMZ7FZ2oGW4VZVe93kbaWCwHFk0+cC1/zh/MQKkQ11JFE3iNznCr+T3+hjcGxQMfpoJFTawa5Q8lQov1U+BdECQQDhjL4fObBP1uJAV8WOhOHW/TiXSv7XhwhnZBvSeC20OnrBEHt7HNFX7/7bXUoorKgHQoC5UqSX7O60fbaX1qdPAkAzTOcSDuLNe4MzykRi3mp+xIUcz1Pd8hM6ElkbIbdyUMRqj24Y4CGs6pEpQIwST6RMfkPezYOcUjdwb7a5x9zxAkAg+F3iWqB3S0YPecUbLDmHH8Th+Mh/4PFNi8i1X3Pu4I2JI0upl3DSlfZ/QofQokx9oy8F6Bq/SpcqMyY509rpAkEAyGIya/0ndAQtbsAz47oXgvaE/jzXMhT8MLGcnjLzwsnK/5YNqkq80/wquiXnfauWmByXH0FdSBApsB349V0k+g=="
#define PRIVATEKEYS @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALx3jjRqsDATE0gcpYfWIfXVCCPF4N6gNZvy1LA4E89oOy5Rf+M0icuW84nPItlFxadwXlYkrFPEtECfm/ujMiKfgRXzY5zguWFSfE6H/McjxseVdz/2bXfZg6AyZHPHdEVuo0mvP7l1gZ4VlEgkk9eeycO1FGXM9Ua1RMYM2Cv/AgMBAAECgYBdJSFtGoV1XRgcfbv5xIUIQH9DXtribH/SUVN4vF5eFX+aRsFUA3VO344BwBPTGj6zoD+fh4R76i3D+p5W4bM2u6RHn918/Z6xAy3Yrn3ZfzUo1uiWzYpSj473M/FaIIoT3frRJxF6qJh6VGDk4vyvLozrqvnNkx4nk2f5pMYJUQJBAO1gm9BcOuSLcoP1q6BHxqwaIP4dWywUQu6WZuEq8irlS5+KNgyAQf9lo564LCxtrT0ratfB1bEKilTh9T+xLnsCQQDLQKaeGJcWySPjivwGNgWAbS8SQf7K4IRNmZC9lGHW8wBiZrakWvMrSLzLBjXEkraZOl0qOrylmeAzDdfEOUNNAkB8RaWNEZvrZm3PU+BECw+hrhQztR60Fu9rhOXbX+ZkOqK6pVridIsYsBdW0sidgdW+PmqzBdFf3ErLYXhJnfLdAkAjAgeww1uCuTJNRusRxsw7ypKI+oUAPJuNIh4kCSKw+znduQNMW732fpjF/1PTf9GjosHZPDSx8UcEhCXdzl8hAkBph4AFKHFlK9LXn7TvFmfN2XZrPfOCu1z1sh5QPj5UH2u1++nRioS55UCUkWYJwz+eLuSymLw5UIFDuA2wQmGY"

//提醒音重复次数
#define REPEATSOUND @"repeatSound" 
#define Y_StockChartSegmentStartTag  2000
typedef enum _tagServiceAlertViewType{
    kServiceAlertViewTypeTelphone,
    kServiceAlertViewTypeEntrust,
    kServiceAlertViewTypeBandCard,
    kServiceAlertViewTypeCheDan,
    kServiceAlertViewTypeDrawCash,
    kServiceAlertViewTypeSetTradePassword
}ServiceAlertViewType;

typedef enum _tagViewSVProgressType{
    kViewSVProgressTypeSuccess = 0,
    kViewSVProgressTypeError,
    kViewSVProgressTypeInfo
}ViewSVProgressType;

typedef enum _tagPasswordType{
    kPasswordTypeMaiRu = 0,
    kPasswordTypeMaiChu,
    kPasswordTypeTiHuo,
    kPasswordTypeEntrust,
    kPasswordTypeFundManagerFirst,
    kPasswordTypeFundManagerSecond,
    kPasswordTypeSell
}PasswordType;

//typedef enum _tagPasswordTextfieldType{
//    kPasswordTextfieldTypeMaiRu = 0,
//    kPasswordTextfieldTypeMaiChu,
//    kPasswordTextfieldTypeTiHuo
//}PasswordTextfieldType;


//无网络或无数据时
typedef enum _tagWithNetOrData{
    ktagWithNet = 0,
    ktagWithData,
}tagWithStatus;

//点击收藏或者预警设置时
typedef enum _tagWithType{
    ktagWithTypeCollect = 0,
    ktagWithTypeWarning,
}tagWithType;


typedef enum _tagPlaySoundType{
    kTabBarSubNavTypeMainSet = 0,
    kTabBarSubNavTypeTake,
    kTabBarSubNavTypeIndividua,
     kTabBarSubNavTypeLeverage,
    kTabBarSubNavTypeMineSet
}TabBarSubNavType;

typedef enum _tagTabBarSubNavType{
    kPlaySoundTypeOnce = 0,
    kPlaySoundTypeOneMinite,
    kPlaySoundTypeFiveMinite,
    kPlaySoundTypeAlways
}PlaySoundType;


typedef enum _tagTiHuoViewType{
    kTiHuoViewTypeZiTiBtn = 1,  //自取
    kTiHuoViewTypeYouJiBtn,     //邮寄
    kTiHuoViewTypeDateBtn,      //日期选择
    kTiHuoViewTypeChooseBtn,    //
    kTiHuoViewTypeXieyiBtn,     //
    kTiHuoViewTypeAgreeBtn      //
}TiHuoViewType;

typedef enum _tagMainSetViewType{
    kMainSetViewTypeGongGao = 0,    //中心公告
    kMainSetViewTypeYuShou,         //预售商品
    kMainSetViewTypeZiXuan,         //自选商品
    kMainSetViewTypeZhuCe,          //注册开户
    kMainSetViewTypeYiGou,          //已购商品
    kMainSetViewTypeWeiTuo,         //委托管理
    kMainSetViewTypeCaiYe,          //茶叶资讯
    kMainSetViewTypeTiHuo,          //提货服务
    kMainSetViewTypeBangZhu         //帮助中心
}MainSetViewType;

typedef enum _tagZMWMineCellCollectionViewType{
    kZMWMineCellCollectionViewTypeChongZhi = 0,
    kZMWMineCellCollectionViewTypeYiGou,
    kZMWMineCellCollectionViewTypeWeiTuo,
    kZMWMineCellCollectionViewTypeTiXian, // 自选 -> 提现
    kZMWMineCellCollectionViewTypeYuShenGou,
    kZMWMineCellCollectionViewTypeTiHuo,
    kZMWMineCellCollectionViewTypeChengJiao,
    kZMWMineCellCollectionViewTypeJiShou,
    kZMWMineCellCollectionViewTypeShouCang, // 消息 -> 收藏
    kZMWMineCellCollectionViewTypeHistory
    
}ZMWMineCellCollectionViewType;

typedef enum _tagWeiXinPayType{
    kWeiXinPayTypeSuccess = 0,
    kWeiXinPayTypeError
}WeiXinPayType;

typedef enum _tagZMWSocketType{
    kZMWSocketTypeStateTokenFail = 90000,//token失效
    kZMWSocketTypeStateLoginData = 90001 //登录信息刷新
//    kZMWSocketTypeState
}ZMWSocketType;

typedef enum _tagZMWAssistiveTouchViewType{
    /**
     *  充值（未登录，直接跳转到登录界面）
     */
    kZMWAssistiveTouchViewTypeRecharge = 0,
    /**
     *  资料补全
     */
    kZMWAssistiveTouchViewTypeAddInformation
}ZMWAssistiveTouchViewType;

typedef enum _tagZMWPreSellCardType{
    kZMWPreSellCardTypeNum = 0,
    kZMWPreSellCardTypeCurrent
}ZMWPreSellCardType;

typedef enum _tagZMWPreCustomViewControllerType{
    kZMWPreCustomViewControllerTypeAll = 0,
    kZMWPreCustomViewControllerTypeOther
}ZMWPreCustomViewControllerType;

typedef enum _tagZMWShareSheetViewType{
    kZMWShareSheetViewTypeWechatSession = 0,
    kZMWShareSheetViewTypeWechatTimeline,
    kZMWShareSheetViewTypeCancel
}ZMWShareSheetViewType;

typedef enum _tagZMWCustomPlaceHodlerType{
    kZMWCustomPlaceHodlerTypeImage = 0,
    kZMWCustomPlaceHodlerTypeButton,
    kZMWCustomPlaceHodlerTypeShareButton
}ZMWCustomPlaceHodlerType;


//ZMWAssistiveTouchView
// 坤哥
//#define HOSTURL @"http://192.168.1.185:88/tea_leaf/app/"
//#define HOSTURL @"http://192.168.1.238:80/tea_interface/app/"
//#define HOSTURL @"http://192.168.1.17:8080/tea_leaf/app/"

// 陈贱
//#define HOSTURL @"http://192.168.1.7:8082/tea_leaf/app/"
// 子豪
//#define HOSTURL @"http://192.168.1.44:8089/abel_mobileApp/"
//#define HOSTURL @"http://192.168.1.11:8089/tea_leaf/app/"
// 志聪
//#define HOSTURL @"http://192.168.1.20:8080/tea_leaf/app/"

// 坑逼
//#define HOSTURL @"http://192.168.1.7:8082/abel_mobileApp"

// 志聪
//#define HOSTURL @"http://192.168.1.10:8080/abel_mobileApp/"
//#define HOSTURL_AppPay @"http://192.168.1.10:8080/abel_payment/"


// 测试环境
//#define HOSTURL @"https://192.168.1.250/app/"
//#define HOSTURL_AppPay @"https://192.168.1.250/appay/"
//#define HOSTURL_Small @"http://192.168.1.250/small/"

//#define HOSTURL @"http://192.168.1.12:8082/abel_mobileApp"
//#define HOSTURL_AppPay @"https://192.168.1.250/appay/"
//#define HOSTURL_Small @"http://192.168.1.250/small/"



//正式账号
//#define HOSTURL @"http://szpztea.com/tea_interface/app/"
//#define WebSocket @"ws://szpztea.com:80/tea_interface/websocket?token="

#define HOSTURL @"https://chartf.org.cn/app/"
#define HOSTURL_AppPay @"https://chartf.org.cn/appay/"
#define HOSTURL_Small @"http://chartf.org.cn/small/"
#define WebSocket @"ws://chartf.org.cn:80/tea_interface/websocket?token="


//#define HOSTURL @"http://9655128.net/tea_interface/app/"
//#define WebSocket @"ws://9655128.net:80/tea_interface/websocket?token="

//用户信息
#define USER_INFO @"user_info"

#define ZMWWeakSelf(type)  __weak typeof(type) weak##type = type;
#define ZMWStrongSelf(type)  __strong typeof(type) type = weak##type;

//Socket Notice
#define SOCKETNOTICETYPELOGIN @"SOCKETNOTICETYPELOGIN"//登录通知
#define SOCKETSHOWEDVIEWCONTROLLER @"SocketShowedViewController"//viewController push 归档
#define SOCKETNOTICETYPETRADE @"SocketNoticeTypeTrade"//商城通知

//微信支付通知
#define WEIXINPAYNOTICE @"WeiXinPayNotice"
//默认银行卡
#define DEFAULTBANKACCOUNTNOTICE @"DefaultBankAccountNotice"
//银行卡的颜色选择
#define BankListTypeColorArr @"BankListTypeColorArr"
//资金界面firstView通知secondView
#define FundManagerFirstViewRefreshSubAccountSecondViewNotice @"FundManagerFirstViewRefreshSubAccountSecondViewNotice"
//交易密码MD5
#define PasswordMD5ChangTradeViewController @"PasswordMD5ChangTradeViewController"
//更新头像通知
#define AccountViewControllerHeaderImgNotice @"AccountViewControllerHeaderImgNotice"
#define KDJNUM 0
#define RSINUM 1
#define WRNUM 2
//适配我的界面
#define ADAPTIVEMINESETVIEWCONTROLLER @"AdaptiveMineSetViewController"
#define TIMEOUTVIEWNOTICE @"TIMEOUTVIEWNOTICE"

//我的界面cell联动通知
#define ZMWMineCellRequestReflushNotice @"ZMWMineCellRequestReflushNotice"

//预售倒计时通知
#define ZMWPreSellViewControllerNotice @"ZMWPreSellViewControllerNotice"

#define shareContent @"千部iPhone7等您来拿！我只能帮到这里了 ，你也帮下我？"
#define shareImage @"mine_new_shareImg"
#define shareTitle @"品众商城"
//#define shareURL(ru, py) [NSString stringWithFormat:@"http://szpztea.com/webApp/webApp/register?ru=%@&&py=%@", ru, py]
//#define shareURL(ru, py) [NSString stringWithFormat:@"http://chartf.org.cn/tea_interface/webApp/register?ru=%@&&py=%@", ru, py]
#define shareURL(ru, py) [NSString stringWithFormat:@"https://chartf.org.cn/small/webApp/register?ru=%@&py=%@", ru, py]
/***********************************************************/

typedef enum _tagZMWPurchaseViewType{
    kZMWPurchaseViewType_Purchase = 0       // 申购
}ZMWPurchaseViewType;

UIKIT_EXTERN const CGFloat ZMWRed;
UIKIT_EXTERN const CGFloat ZMWGreen;
UIKIT_EXTERN const CGFloat ZMWBlue;
UIKIT_EXTERN const CGFloat ZMWAlpha;
// popMenu items height
UIKIT_EXTERN const CGFloat ZMWPopoverController_H;
//UIKIT_EXTERN const int ZMWAssistiveTouchView_YES;
//UIKIT_EXTERN const int ZMWAssistiveTouchView_NO;

// popMenu status
UIKIT_EXTERN NSString *const ZMWPopoverAnimatorWillShow;
UIKIT_EXTERN NSString *const ZMWPopoverAnimatorWillDismiss;
// popMenu selected item
UIKIT_EXTERN NSString *const ZMWPopMenuViewControllerIndex;
// ***button rotation notice***
// click button close notice
UIKIT_EXTERN NSString *const ZMWPopMenuViewControllerButtonNotice;
// click mask close notice
//UIKIT_EXTERN NSString *const ZMWPopMenuViewControllerMaskNotice;

#define KEY_USERNAME_PASSWORD @"com.company.app.usernamepassword"
#define KEY_USERNAME @"com.company.app.username"
#define KEY_PASSWORD @"com.company.app.password"

UIKIT_EXTERN NSString *const ZMWExplainUsable;
UIKIT_EXTERN NSString *const ZMWExplainActivate;
UIKIT_EXTERN NSString *const ZMWExplainFailure;

UIKIT_EXTERN NSString *const ZMWChinaMobile;
UIKIT_EXTERN NSString *const ZMWChinaUnicom;
UIKIT_EXTERN NSString *const ZMWChinaTelecom;
UIKIT_EXTERN NSString *const ZMWChinaOther;

UIKIT_EXTERN NSString *const ZMWMainSetViewAlert;

UIKIT_EXTERN NSString *const ZMWOptionalViewControllerEnshrine;

#define navBarHeight [UIApplication sharedApplication].statusBarFrame.size.height + 44


//SubAPI

//#define ZMW_PZTeaURL(url) [NSString stringWithFormat:@"%@", @#url]

#endif
