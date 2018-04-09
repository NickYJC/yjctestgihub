//
//  Y-KlineModel.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/28.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineModel.h"
#import "Y_KLineGroupModel.h"
#import "Y_StockChartGlobalVariable.h"
@implementation Y_KLineModel

- (NSNumber *)RSV_9
{
    if (!_RSV_9) {
//**RSV(9)=（今日收盘价－9日内最低价）÷（9日内最高价－9日内最低价）×100
        if(self.NineClocksMinPrice == self.NineClocksMaxPrice) {
            _RSV_9 = @100;
        } else {
            _RSV_9 = @((self.Close.floatValue - self.NineClocksMinPrice.floatValue) * 100 / (self.NineClocksMaxPrice.floatValue - self.NineClocksMinPrice.floatValue));
        }
    }
    return _RSV_9;
}
- (NSNumber *)RSV_RSI6_UpSum
{
//_RSV_RSI6_UpSum
//
    /**
     第一天升2元，第二天跌2元，第三至第五天各升3元；第六天跌4元 第七天升2元，第八天跌5元；第九天跌6元，第十至十二天各升1元；第十三至十四天各跌3元。
     2+9+2+3  16
     2+4+5+6+6  23
     那么，计算RSI的步骤如下：
     （一）将14天上升的数目相加，除以14,上例中总共上升16元除以14得1.143（精确到小数点后三位)；
     （二）将14天下跌的数目相加，除以14,上例中总共下跌23元除以14得1.643（精确到小数点后三位）；
     （三）求出相对强度RS,即RS=1.143/1.643=0.696（精确到小数点后三位）；
     （四）1+RS=1+0.696=1.696；
     RS/(1+RS)=0.696/(1+0.696)=0.41038
     （五）RSI=100*0.41028=41.038.
     结果14天的强弱指标RS1为41.038。
     
     
     _RSV_RSI6_UpSum  第一条数据收盘价为10，之后6天收盘价大于10的差和，，再除以6。。。。。
     最开始6天无数据，，，第七天才有第一条数据
     需要一个数组，七个元素，a[0]为收盘价参考值
     
     - (NSNumber *)MA12
     {
         if (!_MA12) {
             NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
             if (index >= 11) {
                 if (index > 11)
                   {
                     _MA12 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 12].SumOfLastClose.floatValue) / 12);
                     } else
                     {
                     _MA12 = @(self.SumOfLastClose.floatValue / 12);
                 }
             }
         }
         return _MA12;
     }
     */
    if (!_RSV_RSI6_UpSum) {
         NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
       
        
        if (index>6) {
 
            CGFloat x =[self calculateRSIUpSunOrDowmSum:YES WithIndex:index TypeNum:6];
            _RSV_RSI6_UpSum =@(x);
            
        }else
        {
            _RSV_RSI6_UpSum =@(0);
            
        }
        // DebugLog(@"type6 UpSum==%f",_RSV_RSI6_UpSum.floatValue);
    }
    return _RSV_RSI6_UpSum;
}
//-(CGFloat)calculateDownSumWithArray:(NSArray*)array
//{
//     __block CGFloat downSum =0;

//
//    return downSum/6;
//}
-(CGFloat)calculateRSIUpSunOrDowmSum:(BOOL)isUp WithIndex:(NSInteger) index TypeNum:(NSInteger)typeNum
{
    //typeNum=6
     CGFloat upSum = 0;
     CGFloat downSum = 0;
    upSum = 0;
    downSum = 0;
    NSMutableArray  *array=[NSMutableArray array];
    Y_KLineModel *modelFirst =self.ParentGroupModel.models[index-typeNum];
    
     CGFloat modelFirstClose = modelFirst.Close.floatValue;
    
    for (NSInteger i =0; i<typeNum; i++) {
        //typeNum+1=7
       
         [array addObject:self.ParentGroupModel.models[index-i]];
    }
    //array最后一个为models[index-5]，共6元素
    if (isUp ==YES) {
       
        for (Y_KLineModel  *model in array) {
            if (model.Close.floatValue >modelFirstClose&&modelFirstClose>0) {
                upSum +=model.Close.floatValue -modelFirstClose;
            }
        }
        upSum =upSum/typeNum;
        return upSum;
    }else{
        for (Y_KLineModel  *model in array) {
            if (model.Close.floatValue>0&&model.Close.floatValue <modelFirstClose) {
                downSum +=modelFirstClose -model.Close.floatValue;
            }
        }
        
         return downSum;
    }
    
}
- (NSNumber *)RSV_RSI6_DownSum
{
    if (!_RSV_RSI6_DownSum) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
 
        if (index>6) {
            CGFloat x =[self calculateRSIUpSunOrDowmSum:NO WithIndex:index TypeNum:6];
            _RSV_RSI6_DownSum =@(x);
            
        }else
        {
            _RSV_RSI6_DownSum =@(0);
            
        }
        
    }
    return _RSV_RSI6_DownSum;
}
- (NSNumber *)RSV_RSI12_DownSum
{
    if (!_RSV_RSI12_DownSum) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        
        if (index>12) {
            CGFloat x =[self calculateRSIUpSunOrDowmSum:NO WithIndex:index TypeNum:12];
            _RSV_RSI12_DownSum =@(x);
            
        }else
        {
            _RSV_RSI12_DownSum =@(0);
            
        }
        
    }
    return _RSV_RSI12_DownSum;
}
- (NSNumber *)RSV_RSI12_UpSum
{
    if (!_RSV_RSI12_UpSum) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        
        if (index>12) {
            CGFloat x =[self calculateRSIUpSunOrDowmSum:YES WithIndex:index TypeNum:12];
            _RSV_RSI12_UpSum =@(x);
            
        }else
        {
            _RSV_RSI12_UpSum =@(0);
            
        }
      
    }
    return _RSV_RSI12_UpSum;
}
- (NSNumber *)RSV_RSI24_DownSum
{
    if (!_RSV_RSI24_DownSum) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        
        if (index>24) {
            CGFloat x =[self calculateRSIUpSunOrDowmSum:NO WithIndex:index TypeNum:24];
            _RSV_RSI24_DownSum =@(x);
            
        }else
        {
            _RSV_RSI24_DownSum =@(0);
            
        }
        
    }
    return _RSV_RSI24_DownSum;
}
- (NSNumber *)RSV_RSI24_UpSum
{
    if (!_RSV_RSI24_UpSum) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        
        if (index>24) {
            CGFloat x =[self calculateRSIUpSunOrDowmSum:YES WithIndex:index TypeNum:24];
            _RSV_RSI24_UpSum =@(x);
            
        }else
        {
            _RSV_RSI24_UpSum =@(0);
            
        }
        
    }
    return _RSV_RSI24_UpSum;
}
-(CGFloat)calculateWRLowOrHigh:(BOOL)isHight WithIndex:(NSInteger) index TypeNum:(NSInteger)typeNum
{
    //typeNum=6
     CGFloat Highist = CGFLOAT_MIN;
     CGFloat Lowist =  CGFLOAT_MAX;
    
    //__block CGFloat minMA7 = CGFLOAT_MAX;
   //__block CGFloat maxMA7 = CGFLOAT_MIN;
    NSMutableArray  *array=[NSMutableArray array];
    for (NSInteger i =0; i<typeNum; i++) {
        //typeNum 10  共十个元素
        
        [array addObject:self.ParentGroupModel.models[index-i]];
    }
    
    if (isHight ==YES) {
        
        for (Y_KLineModel  *model in array) {
            if (model.High.floatValue >Highist) {
                Highist =model.High.floatValue;
            }
        }
      
        return Highist;
    }else{
        for (Y_KLineModel  *model in array) {
            if (model.Low.floatValue <Lowist) {
                Lowist =model.Low.floatValue;
            }
        }
       
        return Lowist;
    }
    
}
- (NSNumber *)RSV_WR_10_LOW
{
    if (!_RSV_WR_10_LOW) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index>10) {
             CGFloat x =[self calculateWRLowOrHigh:NO WithIndex:index TypeNum:10];
           
            _RSV_WR_10_LOW =@(x);
            
        }else
        {
            _RSV_WR_10_LOW =@(0);
            
        }
       
    }
    return _RSV_WR_10_LOW;
}
- (NSNumber *)RSV_WR_6_LOW
{
    if (!_RSV_WR_6_LOW) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
       
        if (index>6) {
            CGFloat x =[self calculateWRLowOrHigh:NO WithIndex:index TypeNum:6];
            
            _RSV_WR_6_LOW =@(x);
            
        }else
        {
            _RSV_WR_6_LOW =@(0);
            
        }
        
    }
    return _RSV_WR_6_LOW;
}

- (NSNumber *)RSV_WR_10_HIGH
{
    if (!_RSV_WR_10_HIGH) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index>10) {
            CGFloat x =[self calculateWRLowOrHigh:YES WithIndex:index TypeNum:10];
            
            _RSV_WR_10_HIGH =@(x);
            
        }else
        {
            _RSV_WR_10_HIGH =@(0);
            
        }
        
    }
    return _RSV_WR_10_HIGH;
}
- (NSNumber *)RSV_WR_6_HIGH
{
    if (!_RSV_WR_6_HIGH) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index>6) {
            CGFloat x =[self calculateWRLowOrHigh:YES WithIndex:index TypeNum:6];
            
            _RSV_WR_6_HIGH =@(x);
            
        }else
        {
            _RSV_WR_6_HIGH =@(0);
            
        }
        
        
    }
    return _RSV_WR_6_HIGH;
}
- (NSNumber *)KDJ_K
{
    if (!_KDJ_K) {
        _KDJ_K = @((self.RSV_9.floatValue + 2 * (self.PreviousKlineModel.KDJ_K ? self.PreviousKlineModel.KDJ_K.floatValue : 50) )/3);
    }
    return _KDJ_K;
}

- (NSNumber *)KDJ_D
{
    if(!_KDJ_D) {
        _KDJ_D = @((self.KDJ_K.floatValue + 2 * (self.PreviousKlineModel.KDJ_D ? self.PreviousKlineModel.KDJ_D.floatValue : 50))/3);
    }
    return _KDJ_D;
}
- (NSNumber *)KDJ_J
{
    if(!_KDJ_J) {
        _KDJ_J = @(3*self.KDJ_K.floatValue - 2*self.KDJ_D.floatValue);
    }
    return _KDJ_J;
}
#pragma MARK-RSI
- (NSNumber *)RSI_6
{
    /**
     （一）将14天上升的数目相加，除以14,上例中总共上升16元除以14得1.143（精确到小数点后三位)；
     （二）将14天下跌的数目相加，除以14,上例中总共下跌23元除以14得1.643（精确到小数点后三位）；
     （三）求出相对强度RS,即RS=1.143/1.643=0.696（精确到小数点后三位）；
     （四）1+RS=1+0.696=1.696；
     RS/(1+RS)=0.696/(1+0.696)=0.41038
     （五）RSI=100*0.41028=41.038.
     结果14天的强弱指标RS1为41.038。
     */
    if (!_RSI_6) {
        CGFloat RS;
        if (_RSV_RSI6_DownSum.floatValue != 0) {
             RS = _RSV_RSI6_UpSum.floatValue/_RSV_RSI6_DownSum.floatValue;
             // RS =[self notRounding:_RSV_RSI6_UpSum.floatValue afterPoint:3].floatValue/([self notRounding:_RSV_RSI6_DownSum.floatValue afterPoint:3].floatValue);
        }else
        {
            RS =0;
        }
       NSString *startNum =[self notRounding:RS/(1+RS) afterPoint:5];
        _RSI_6 =@(startNum.floatValue*100);
        

    }
    return _RSI_6;
}
#pragma mark-四舍五入
-(NSString*)notRounding:(float)price afterPoint:(NSInteger)position
{
    NSDecimalNumberHandler* roundingHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber* returnNumber;
    
    NSDecimalNumber* ouncesDecimal = [[NSDecimalNumber alloc]initWithFloat:price];
    
    returnNumber = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingHandler];
    
    return [NSString stringWithFormat:@"%@",returnNumber];
}
- (NSNumber *)RSI_12
{
    if(!_RSI_12) {
        CGFloat RS;
        if (_RSV_RSI12_DownSum.floatValue != 0) {
            RS = _RSV_RSI12_UpSum.floatValue/_RSV_RSI12_DownSum.floatValue;
            
            //  RS =[self notRounding:_RSV_RSI12_UpSum.floatValue afterPoint:3].floatValue/([self notRounding:_RSV_RSI12_DownSum.floatValue afterPoint:3].floatValue);
        }else
        {
            RS =0;
        }
        NSString *startNum =[self notRounding:RS/(1+RS) afterPoint:5];
        _RSI_12 =@(startNum.floatValue*100);
       
    }
    return _RSI_12;
}
- (NSNumber *)RSI_24
{
    if(!_RSI_24) {
        CGFloat RS;
        if (_RSV_RSI24_DownSum.floatValue != 0) {
            RS = _RSV_RSI24_UpSum.floatValue/_RSV_RSI24_DownSum.floatValue;
            
            
        }else
        {
            RS =0;
        }
        
        NSString *startNum =[self notRounding:RS/(1+RS) afterPoint:5];
        _RSI_24 =@(startNum.floatValue*100);
    }
    return _RSI_24;
}
#pragma MARK-WR
- (NSNumber *)WR_10
{
    if (!_WR_10) {
        //100 * [ HIGH(N)-C ] / [ HIGH(N)-LOW(N) ]
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        CGFloat currentClose =self.ParentGroupModel.models[index].Close.floatValue;
        CGFloat WR;
        if (_RSV_WR_10_HIGH.floatValue != _RSV_WR_10_LOW.floatValue) {
            WR =(_RSV_WR_10_HIGH.floatValue-currentClose)/(_RSV_WR_10_HIGH.floatValue-_RSV_WR_10_LOW.floatValue);
            if (WR>1) {
                WR =1;
            }
        }else
        {
            WR =0;
        }
        NSString *startNum =[self notRounding:WR afterPoint:5];
        _WR_10 =@(startNum.floatValue*100);
        
    }
    return _WR_10;
}

- (NSNumber *)WR_6
{
    if(!_WR_6) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        CGFloat currentClose =self.ParentGroupModel.models[index].Close.floatValue;
        CGFloat WR;
        if (_RSV_WR_6_HIGH.floatValue != _RSV_WR_6_LOW.floatValue) {
            WR =(_RSV_WR_6_HIGH.floatValue-currentClose)/(_RSV_WR_6_HIGH.floatValue-_RSV_WR_6_LOW.floatValue);
            if (WR>1) {
                WR =1;
            }
        }else
        {
            WR =0;
        }
        NSString *startNum =[self notRounding:WR afterPoint:5];
        _WR_6 =@(startNum.floatValue*100);
    }
    return _WR_6;
}


- (NSNumber *)MA7
{
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_MA7) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 6) {
                if (index > 6) {
                    _MA7 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 7].SumOfLastClose.floatValue) / 7);
                } else {
                    _MA7 = @(self.SumOfLastClose.floatValue / 7);
                }
            }
        }
    } else {
        return self.EMA7;
    }
    return _MA7;
}

- (NSNumber *)Volume_MA7
{
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_Volume_MA7) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 6) {
                if (index > 6) {
                    _Volume_MA7 = @((self.SumOfLastVolume.floatValue - self.ParentGroupModel.models[index - 7].SumOfLastVolume.floatValue) / 7);
                } else {
                    _Volume_MA7 = @(self.SumOfLastVolume.floatValue / 7);
                }
            }
        }
    } else {
        return self.Volume_EMA7;
    }
    return _Volume_MA7;
}
- (NSNumber *)Volume_EMA7
{
    if(!_Volume_EMA7) {
        _Volume_EMA7 = @((self.Volume + 3 * self.PreviousKlineModel.Volume_EMA7.floatValue)/4);
    }
    return _Volume_EMA7;
}
//// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
- (NSNumber *)EMA7
{
    if(!_EMA7) {
        _EMA7 = @((self.Close.floatValue + 3 * self.PreviousKlineModel.EMA7.floatValue)/4);
    }
    return _EMA7;
}

- (NSNumber *)EMA30
{
    if(!_EMA30) {
        _EMA30 = @((2 * self.Close.floatValue + 29 * self.PreviousKlineModel.EMA30.floatValue)/31);
    }
    return _EMA30;
}

- (NSNumber *)EMA12
{
    if(!_EMA12) {
        _EMA12 = @((2 * self.Close.floatValue + 11 * self.PreviousKlineModel.EMA12.floatValue)/13);
    }
    return _EMA12;
}

- (NSNumber *)EMA26
{
    if (!_EMA26) {
        _EMA26 = @((2 * self.Close.floatValue + 25 * self.PreviousKlineModel.EMA26.floatValue)/27);
    }
    return _EMA26;
}

- (NSNumber *)MA30
{
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_MA30) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 29) {
                if (index > 29) {
                    _MA30 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 30].SumOfLastClose.floatValue) / 30);
                } else {
                    _MA30 = @(self.SumOfLastClose.floatValue / 30);
                }
            }
        }
    } else {
        return self.EMA30;
    }
    return _MA30;
}

- (NSNumber *)Volume_MA30
{
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_Volume_MA30) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 29) {
                if (index > 29) {
                    _Volume_MA30 = @((self.SumOfLastVolume.floatValue - self.ParentGroupModel.models[index - 30].SumOfLastVolume.floatValue) / 30);
                } else {
                    _Volume_MA30 = @(self.SumOfLastVolume.floatValue / 30);
                }
            }
        }
    } else {
        return self.Volume_EMA30;
    }
    return _Volume_MA30;
}

- (NSNumber *)Volume_EMA30
{
    if(!_Volume_EMA30) {
        _Volume_EMA30 = @((2 * self.Volume + 29 * self.PreviousKlineModel.Volume_EMA30.floatValue)/31);
    }
    return _Volume_EMA30;
}
- (NSNumber *)MA12
{
    if (!_MA12) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 11) {
            if (index > 11) {
                _MA12 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 12].SumOfLastClose.floatValue) / 12);
            } else {
                _MA12 = @(self.SumOfLastClose.floatValue / 12);
            }
        }
    }
    return _MA12;
}

- (NSNumber *)MA26
{
    if (!_MA26) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 25) {
            if (index > 25) {
                _MA26 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 26].SumOfLastClose.floatValue) / 26);
            } else {
                _MA26 = @(self.SumOfLastClose.floatValue / 26);
            }
        }
    }
    return _MA26;
}

- (NSNumber *)SumOfLastClose
{
    if(!_SumOfLastClose) {
        _SumOfLastClose = @(self.PreviousKlineModel.SumOfLastClose.floatValue + self.Close.floatValue);
    }
    return _SumOfLastClose;
}

- (NSNumber *)SumOfLastVolume
{
    if(!_SumOfLastVolume) {
        _SumOfLastVolume = @(self.PreviousKlineModel.SumOfLastVolume.floatValue + self.Volume);
    }
    return _SumOfLastVolume;
}

- (NSNumber *)NineClocksMinPrice
{
    if (!_NineClocksMinPrice) {
//        if([self.ParentGroupModel.models indexOfObject:self] >= 8)
//        {
            [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedDescending];
//        } else {
//            _NineClocksMinPrice = @0;
//        }
    }
    return _NineClocksMinPrice;
}

- (NSNumber *)NineClocksMaxPrice {
    if (!_NineClocksMaxPrice) {
        if([self.ParentGroupModel.models indexOfObject:self] >= 8)
        {
            [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedAscending];
        } else {
            _NineClocksMaxPrice = @0;
        }
    }
    return _NineClocksMaxPrice;
}
- (NSMutableArray *)RSI_6_Array {
    if (!_RSI_6_Array) {
        _RSI_6_Array =[NSMutableArray array];
        if([self.ParentGroupModel.models indexOfObject:self] >= 6)
        {
           // [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedAscending];
        } else {
            
        }
    }
    return _RSI_6_Array;
}

////DIF=EMA（12）-EMA（26）         DIF的值即为红绿柱；
//
////今日的DEA值=前一日DEA*8/10+今日DIF*2/10.

- (NSNumber *)DIF
{
    if(!_DIF) {
        _DIF = @(self.EMA12.floatValue - self.EMA26.floatValue);
    }
    return _DIF;
}

//已验证
-(NSNumber *)DEA
{
    if(!_DEA) {
        _DEA = @(self.PreviousKlineModel.DEA.floatValue * 0.8 + 0.2*self.DIF.floatValue);
    }
    return _DEA;
}

//已验证
- (NSNumber *)MACD
{
    if(!_MACD) {
        _MACD = @(2*(self.DIF.floatValue - self.DEA.floatValue));
    }
    return _MACD;
}

#pragma mark BOLL线

- (NSNumber *)MA20{
    
    if (!_MA20) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 19) {
            if (index > 19) {
                _MA20 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 20].SumOfLastClose.floatValue) / 20);
            } else {
                _MA20 = @(self.SumOfLastClose.floatValue / 20);
            }
        }
    }
    return _MA20;
    
}

- (NSNumber *)BOLL_MB {
    
    if(!_BOLL_MB) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 19) {
            
            if (index > 19) {
                _BOLL_MB = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 19].SumOfLastClose.floatValue) / 19);
                
            } else {
                
                _BOLL_MB = @(self.SumOfLastClose.floatValue / index);
                
            }
        }
        
        // NSLog(@"lazyMB:\n _BOLL_MB: %@", _BOLL_MB);
        
    }
    
    return _BOLL_MB;
}

- (NSNumber *)BOLL_MD {
    
    if (!_BOLL_MD) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        
        if (index >= 20) {
            
            _BOLL_MD = @(sqrt((self.PreviousKlineModel.BOLL_SUBMD_SUM.floatValue - self.ParentGroupModel.models[index - 20].BOLL_SUBMD_SUM.floatValue)/ 20));
            
        }
        
    }
    
    // NSLog(@"lazy:\n_BOLL_MD:%@ -- BOLL_SUBMD:%@",_BOLL_MD,_BOLL_SUBMD);
    
    return _BOLL_MD;
}

- (NSNumber *)BOLL_UP {
    if (!_BOLL_UP) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 20) {
            _BOLL_UP = @(self.BOLL_MB.floatValue + 2 * self.BOLL_MD.floatValue);
        }
    }
    
    // NSLog(@"lazy:\n_BOLL_UP:%@ -- BOLL_MD:%@",_BOLL_UP,_BOLL_MD);
    
    return _BOLL_UP;
}

- (NSNumber *)BOLL_DN {
    if (!_BOLL_DN) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 20) {
            _BOLL_DN = @(self.BOLL_MB.floatValue - 2 * self.BOLL_MD.floatValue);
        }
    }
    
    // NSLog(@"lazy:\n_BOLL_DN:%@ -- BOLL_MD:%@",_BOLL_DN,_BOLL_MD);
    
    return _BOLL_DN;
}

- (NSNumber *)BOLL_SUBMD_SUM {
    
    if (!_BOLL_SUBMD_SUM) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 20) {
            
            _BOLL_SUBMD_SUM = @(self.PreviousKlineModel.BOLL_SUBMD_SUM.floatValue + self.BOLL_SUBMD.floatValue);
            
        }
    }
    
    // NSLog(@"lazy:\n_BOLL_SUBMD_SUM:%@ -- BOLL_SUBMD:%@",_BOLL_SUBMD_SUM,_BOLL_SUBMD);
    
    return _BOLL_SUBMD_SUM;
}

- (NSNumber *)BOLL_SUBMD{
    
    if (!_BOLL_SUBMD) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        
        if (index >= 20) {
            
            _BOLL_SUBMD = @((self.Close.floatValue - self.MA20.floatValue) * ( self.Close.floatValue - self.MA20.floatValue));
                        
        }
    }
    
    // NSLog(@"lazy_BOLL_SUBMD: \n MA20: %@ \n Close: %@ \n subNum: %f", _MA20, _Close, self.Close.floatValue - self.MA20.floatValue);
    
    return _BOLL_SUBMD;
}



- (Y_KLineModel *)PreviousKlineModel
{
    if (!_PreviousKlineModel) {
        _PreviousKlineModel = [Y_KLineModel new];
        _PreviousKlineModel.DIF = @(0);
        _PreviousKlineModel.DEA = @(0);
        _PreviousKlineModel.MACD = @(0);
        _PreviousKlineModel.MA7 = @(0);
        _PreviousKlineModel.MA12 = @(0);
        _PreviousKlineModel.MA26 = @(0);
        _PreviousKlineModel.MA30 = @(0);
        _PreviousKlineModel.EMA7 = @(0);
        _PreviousKlineModel.EMA12 = @(0);
        _PreviousKlineModel.EMA26 = @(0);
        _PreviousKlineModel.EMA30 = @(0);
        _PreviousKlineModel.Volume_MA7 = @(0);
        _PreviousKlineModel.Volume_MA30 = @(0);
        _PreviousKlineModel.Volume_EMA7 = @(0);
        _PreviousKlineModel.Volume_EMA30 = @(0);
        _PreviousKlineModel.SumOfLastClose = @(0);
        _PreviousKlineModel.SumOfLastVolume = @(0);
        _PreviousKlineModel.KDJ_K = @(50);
        _PreviousKlineModel.KDJ_D = @(50);
        _PreviousKlineModel.RSI_6 = @(0);
        _PreviousKlineModel.RSI_12 = @(0);
        _PreviousKlineModel.WR_10 = @(0);
        _PreviousKlineModel.WR_6 = @(0);

        _PreviousKlineModel.MA20 = @(0);
        _PreviousKlineModel.BOLL_MD = @(0);
        _PreviousKlineModel.BOLL_MB = @(0);
        _PreviousKlineModel.BOLL_DN = @(0);
        _PreviousKlineModel.BOLL_UP = @(0);
        _PreviousKlineModel.BOLL_SUBMD_SUM = @(0);
        _PreviousKlineModel.BOLL_SUBMD = @(0);
        
    }
    return _PreviousKlineModel;
}
- (Y_KLineGroupModel *)ParentGroupModel
{
    if(!_ParentGroupModel) {
        _ParentGroupModel = [Y_KLineGroupModel new];
    }
    return _ParentGroupModel;
}
//对Model数组进行排序，初始化每个Model的最新9Clock的最低价和最高价
- (void)rangeLastNinePriceByArray:(NSArray<Y_KLineModel *> *)models condition:(NSComparisonResult)cond
{
    switch (cond) {
            //最高价
        case NSOrderedAscending:
        {
//            第一个循环结束后，ClockFirstValue为最小值
            for (NSInteger j = 7; j >= 1; j--)
            {
                NSNumber *emMaxValue = @0;
                
                NSInteger em = j;
                
                while ( em >= 0 )
                {
                    if([emMaxValue compare:models[em].High] == cond)
                    {
                        emMaxValue = models[em].High;
                    }
                    em--;
                }
               // NSLog(@"%f",emMaxValue.floatValue);
                models[j].NineClocksMaxPrice = emMaxValue;
            }
            //第一个循环结束后，ClockFirstValue为最小值
            for (NSInteger i = 0, j = 8; j < models.count; i++,j++)
            {
                NSNumber *emMaxValue = @0;
                
                NSInteger em = j;
                
                while ( em >= i )
                {
                    if([emMaxValue compare:models[em].High] == cond)
                    {
                        emMaxValue = models[em].High;
                    }
                    em--;
                }
               // NSLog(@"%f",emMaxValue.floatValue);

                models[j].NineClocksMaxPrice = emMaxValue;
            }
        }
            break;
        case NSOrderedDescending:
        {
            //第一个循环结束后，ClockFirstValue为最小值
            //DebugLog(@"SSSSSSSSSS=%d",models.count);
            //SSSSSSSSS=337
            for (NSInteger j = 7; j >= 1; j--)
            {
                NSNumber *emMinValue = @(10000000000);
                
                NSInteger em = j;
                
                while ( em >= 0 )
                {
                    if([emMinValue compare:models[em].Low] == cond)
                    {
                        emMinValue = models[em].Low;
                    }
                    em--;
                }
                models[j].NineClocksMinPrice = emMinValue;
            }
            
            for (NSInteger i = 0, j = 8; j < models.count; i++,j++)
            {
                NSNumber *emMinValue = @(10000000000);
                
                NSInteger em = j;
                
                while ( em >= i )
                {
                    if([emMinValue compare:models[em].Low] == cond)
                    {
                        emMinValue = models[em].Low;
                    }
                    em--;
                }
                models[j].NineClocksMinPrice = emMinValue;
            }
        }
            break;
        default:
            break;
    }
}

- (void) initWithArray:(NSArray *)arr;
{
    NSAssert(arr.count == 6, @"数组长度不足");

    if (self)
    {
        _Date = arr[0];
        _Open = @([arr[1] floatValue]);
        _High = @([arr[2] floatValue]);
        _Low = @([arr[3] floatValue]);  
        _Close = @([arr[4] floatValue]);

        _Volume = [arr[5] floatValue];
        self.SumOfLastClose = @(_Close.floatValue + self.PreviousKlineModel.SumOfLastClose.floatValue);
        self.SumOfLastVolume = @(_Volume + self.PreviousKlineModel.SumOfLastVolume.floatValue);
//        NSLog(@"%@======%@======%@------%@",_Close,self.MA7,self.MA30,_SumOfLastClose);
 
    }
}

- (void) initWithDict:(NSDictionary *)dict
{
    
    if (self)
    {
        _Date = dict[@"id"];
        _Open = @([dict[@"open"] floatValue]);
        _High = @([dict[@"high"] floatValue]);
        _Low = @([dict[@"low"] floatValue]);
        _Close = @([dict[@"close"] floatValue]);
        _Volume = [dict[@"vol"] floatValue];
        self.SumOfLastClose = @(_Close.floatValue + self.PreviousKlineModel.SumOfLastClose.floatValue);
        self.SumOfLastVolume = @(_Volume + self.PreviousKlineModel.SumOfLastVolume.floatValue);
        //        NSLog(@"%@======%@======%@------%@",_Close,self.MA7,self.MA30,_SumOfLastClose);
        
    }
}

- (void)initFirstModel
{
//    _SumOfLastClose = _Close;
//    _SumOfLastVolume = @(_Volume);
    _KDJ_K = @(55.27);
    _KDJ_D = @(55.27);
    _KDJ_J = @(55.27);
    
    _RSI_6 = @(0);
    _RSI_12 = @(0);
    _RSI_24 = @(0);
    _WR_10 = @(0);
    _WR_6 = @(0);
    
//    _MA7 = _Close;
//    _MA12 = _Close;
//    _MA26 = _Close;
//    _MA30 = _Close;
    _EMA7 = _Close;
    _EMA12 = _Close;
    _EMA26 = _Close;
    _EMA30 = _Close;
    _NineClocksMinPrice = _Low;
    _NineClocksMaxPrice = _High;
    [self DIF];
    [self DEA];
    [self MACD];
    [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedAscending];
    [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedDescending];
    [self RSV_9];
    [self RSV_RSI6_UpSum];
    [self RSV_RSI6_DownSum];
    [self RSV_RSI12_UpSum];
    [self RSV_RSI12_DownSum];
    [self RSV_RSI24_UpSum];
    [self RSV_RSI24_DownSum];
    [self RSV_WR_10_LOW];
    [self RSV_WR_10_HIGH];
    [self RSV_WR_6_LOW];
    [self RSV_WR_6_HIGH];
    [self KDJ_K];
    [self KDJ_D];
    [self KDJ_J];
    
    [self RSI_6];
    [self RSI_12];
    [self RSI_24];
    [self WR_10];
    [self WR_6];
   
    
    [self MA20];
    [self BOLL_MD];
    [self BOLL_MB];
    [self BOLL_UP];
    [self BOLL_DN];
    [self BOLL_SUBMD];
    [self BOLL_SUBMD_SUM];
    
}

- (void)initData {
    [self MA7];
    [self MA12];
    [self MA26];
    [self MA30];
    [self EMA7];
    [self EMA12];
    [self EMA26];
    [self EMA30];
    
    [self DIF];
    [self DEA];
    [self MACD];
    [self NineClocksMaxPrice];
    [self NineClocksMinPrice];
    [self RSV_9];
    [self RSV_RSI6_DownSum];
    [self RSV_RSI6_UpSum];
    [self RSV_RSI12_DownSum];
    [self RSV_RSI12_UpSum];
    [self RSV_RSI24_DownSum];
    [self RSV_RSI24_UpSum];
    [self RSV_WR_10_LOW];
    [self RSV_WR_10_HIGH];
    [self RSV_WR_6_LOW];
    [self RSV_WR_6_HIGH];
    [self KDJ_K];
    [self KDJ_D];
    [self KDJ_J];
    
    [self RSI_6];
    [self RSI_12];
    [self RSI_24];
    
    [self WR_10];
    [self WR_6];
    
    
    
    [self MA20];
    [self BOLL_MD];
    [self BOLL_MB];
    [self BOLL_UP];
    [self BOLL_DN];
    [self BOLL_SUBMD];
    [self BOLL_SUBMD_SUM];

}
@end
