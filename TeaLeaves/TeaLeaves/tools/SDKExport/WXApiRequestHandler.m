//
//  WXApiRequestHandler.m
//  TeaLeaves
//
//  Created by 张美文 on 16/3/9.
//  Copyright © 2015年 walter. All rights reserved.
//
#import "WXApi.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import <CommonCrypto/CommonDigest.h>

@implementation WXApiRequestHandler

#pragma mark - Public Methods

+ (NSString *)jumpToBizPay:(NSDictionary *)parm{
    
    if (![WXApi isWXAppInstalled]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"未安装微信" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alertView show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        });
        return nil;
    }
    
    DebugLog(@"createWxOrder>>parm:%@", parm);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showMessage:@"" toView:window];

    [AFNetworkingTool postJSONWithUrl:@"createWxOrder" parameters:parm success:^(id responseObject) {
        //
        NSDictionary *resulteDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        DebugLog(@"createWxOrder>>resulteDic:%@", resulteDic);
        NSDictionary *tmpDic = [resulteDic objectForKey:@"data"];

        if ([[resulteDic objectForKey:@"status"] intValue] == 200) {
            NSMutableString *retcode = [resulteDic objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                UInt32 timeStamp =[[tmpDic objectForKey:@"timeStamp"] intValue];
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [tmpDic objectForKey:@"partnerid"];
                req.prepayId            = [tmpDic objectForKey:@"prepayid"];
                req.nonceStr            = [tmpDic objectForKey:@"nonceStr"];
                req.timeStamp           = timeStamp;
                req.package             = [tmpDic objectForKey:@"package"];
                req.sign                = [tmpDic objectForKey:@"paySign"];
                
                [WXApi sendReq:req];
                
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[tmpDic objectForKey:@"appId"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            }
            
        }
        
        [MBProgressHUD hideHUDForView:window];
        
    } fail:^(NSError *error) {
        //
        [MBProgressHUD hideHUDForView:window];

    }];
    

    
    return nil;
}


- (NSString *)text{
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        DebugLog(@"weixinPay:%@", dict);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                return @"";
            }else{
                return [dict objectForKey:@"retmsg"];
            }
        }else{
            return @"服务器返回错误，未获取到json对象";
        }
    }else{
        return @"服务器返回错误";
    }
}

@end
