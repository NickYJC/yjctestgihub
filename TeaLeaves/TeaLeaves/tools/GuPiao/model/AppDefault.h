//
//  AppDefault.h
//  TeaLeaves
//
//  Created by YangJingcai on 15/11/21.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Y_KLineModel.h"
//#import "SendRegisterModel.h"
@interface AppDefault : NSObject
/**

 *单例对象
 */
+(AppDefault*)shareDefault;
/**
 *
 *传入的参数：1、生成图片的大小 2、压缩比 3、存放图片的路径
 *  @param image
 *  @param thumbSize
 *  @param percent
 *  @param thumbPath 
 */
+ (void)createThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent toPath:(NSString *)thumbPath;

/**
 *
 判断null
 */
+(NSString*)APPDefaultWith:(id)ower;

/**
 *
 判断null
 */
+(NSString*)APPDefaultWithBackAccoss:(id)ower;
/**
 *用户登录信息
 */
//@property(nonatomic,strong)SendRegisterModel *RegisterSendModel;

@property(nonatomic,strong)NSString *serverDate;
@property(nonatomic,assign)BOOL isDifferentServerDate;

@property(nonatomic,strong)NSString *goodsNameStr;
@property(nonatomic,strong)NSString *productID;
@property(nonatomic,strong)NSString *klineTitleVCString;
//1 首页系列界面点完善资料，,地址传值
//2 商城系列界面点完善资料,地址传值
//3 交易系列界面点完善资料,地址传值
//4 我的系列界面点完善资料,地址传值
@property(nonatomic,assign)NSInteger adressPathNum;



@property(nonatomic,assign)  CGFloat initialPrice;



//***kLine相关
//传倒数第二的模型，算涨跌幅
@property(nonatomic,retain)Y_KLineModel *reciprocalYestodayMoveModel;
@property(nonatomic,retain)Y_KLineModel *reciprocalCenterModel;
@property(nonatomic,retain)Y_KLineModel *reciprocalFirstModel;
@property(nonatomic,retain)Y_KLineModel *reciprocalFirstModelLast;
@property(nonatomic,retain)Y_KLineModel *reciprocalSecondModelLast;
@property(nonatomic,retain)Y_KLineModel *reciprocalLastModel;


@property(nonatomic,retain)Y_KLineModel *reciprocalMoveModel;
@property(nonatomic,retain)Y_KLineModel *reciprocalMaxModel;
@property(nonatomic,retain)Y_KLineModel *reciprocalMinModel;
@property(nonatomic,assign)CGPoint reciprocalMaxPoint;
@property(nonatomic,assign)CGPoint reciprocalMinPoint;
@property(nonatomic,assign)BOOL isRightAboutTakeVC;
@property(nonatomic,assign)int  RSIOrWRNum; //1,2
@property(nonatomic,assign)BOOL  isDeleteRSIStartModel; //1,2
@property(nonatomic,assign)CGFloat  verticalViewXFrame;
@property(nonatomic,assign)NSInteger  moveModelIndex;
//@property(nonatomic,assign)CGFloat  verticalViewScreenXFrame;

@property(nonatomic,retain)Y_KLineModel *reciprocalYestodayTempModel;
@property(nonatomic,retain)Y_KLineModel *reciprocalYestodayTempModelVolue;
@property(nonatomic,strong)NSMutableArray *positionsArray;
@property (nonatomic,assign)BOOL isNewKlineOnlyOne;
@property(nonatomic,assign)NSInteger isNewFenShiNum;
@property(nonatomic,assign)NSInteger isNewScreenFenShiNum;
@property (nonatomic,assign)BOOL isNewTakeDetailKline;
@property (nonatomic,assign)CGFloat klineOfWidth;
@property (nonatomic,assign)CGFloat klineOfHeight;
//@property(nonatomic)NSInteger kLineAndPay;
@property (nonatomic,assign)BOOL isFenShi;
@property (nonatomic,assign)BOOL isPinchGesture;

//@property (nonatomic)CGFloat maxCurrentNum;
//@property (nonatomic)CGFloat minCurrentNum;


//@property (nonatomic)CGFloat fenshiXianNum;
//判断创建蒙版
//@property (nonatomic)BOOL isDetailShowAnimationView;
//@property(nonatomic,strong)NSMutableArray *takeViewControllerArray;
@property(nonatomic,strong)NSMutableDictionary *takeViewControllerDict;

//@property(nonatomic,strong)NSMutableDictionary *allProductDict;
//@property (nonatomic)BOOL isGoToFullScreen;
//@property (nonatomic)BOOL isTakeVCGoToTakeDetailVC;
//@property (nonatomic)BOOL isOptionVCGoToTakeDetailVC;//自选


//@property (nonatomic)BOOL isTakeDetailVCTimerISNill;
@property(nonatomic,strong)NSMutableArray *arrLine;

@property(nonatomic,assign)BOOL isMinuteLastPart;
@property(nonatomic,assign)BOOL isSameCloseOfFenShi;
@property(nonatomic,assign)CGFloat sameCloseOfFenShiFloat;

@property(nonatomic,assign)CGFloat rateTemp;
@property(nonatomic,assign)CGFloat turnoverFloatSum;
@property(nonatomic,assign)CGFloat volumeFloatSum;
//@property(nonatomic,assign)NSUInteger volume9Num;
@end
