//
//  ZMWNetworkAPIClient.m
//  TeaLeaves
//
//  Created by 张美文 on 2017/2/28.
//  Copyright © 2017年 walter. All rights reserved.
//

#import "ZMWNetworkAPIClient.h"
#import<CoreTelephony/CTTelephonyNetworkInfo.h>
#import<CoreTelephony/CTCarrier.h>

//static NSString * const ZMWReleaseBaseURLString = @"http://chartf.org.cn/tea_interface/app/";


@implementation ZMWNetworkAPIClient

+ (instancetype)sharedClient {
    static ZMWNetworkAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[ZMWNetworkAPIClient alloc] initWithBaseURL:[NSURL URLWithString:HOSTURL]];
//        _sharedClient.securityPolicy = [self policy];
        // 设置请求格式
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        // 设置返回格式
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"GET", @"HEAD"]];

//        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

+ (AFSecurityPolicy *)policy {
    NSString *certFilePath = [[NSBundle mainBundle]
                              pathForResource:@"release" ofType:@"cer"];
    DebugLog(@"path: %@", certFilePath);
    NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
    NSSet *certSet = [NSSet setWithObject:certData];
    //pinnedCertificates,校验服务器返回证书的证书,AF自动寻找
    AFSecurityPolicy *policy = [AFSecurityPolicy walter_customPolicyWithPinnedCertificates:certSet];

//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey withPinnedCertificates:certSet];
    //因为使用自建证书，所以要开启允许非法证书
    policy.allowInvalidCertificates = YES;
    //检验证书omain字段和服务器的是否匹配
    policy.validatesDomainName = YES;
    
    return policy;
}

+ (AFSecurityPolicy *)customSecurityPolicy
{
    
    
    //先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"release" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy walter_defaultPolicy];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}

+ (NSString*)checkCarrier
{
    NSString *ret = [[NSString alloc] init];
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    DebugLog(@"CTRadioAccessTechnologyCDMA1x: %@", [carrier carrierName]);
    
    if ( carrier == nil )
    {
        return(ZMWChinaOther);
    }
    
    NSString *code = [carrier mobileNetworkCode];
    
    if ( [code isEqual: @""] )
    {
        
        return(ZMWChinaOther);
    }
    
    if ( [code isEqualToString:@"00"] || [code isEqualToString:@"02"] || [code isEqualToString:@"07"] )
    {
        ret = ZMWChinaMobile;
    }
    
    if ( [code isEqualToString:@"01"] || [code isEqualToString:@"06"] )
    {
        ret = ZMWChinaUnicom;
    }
    
    if ( [code isEqualToString:@"03"] || [code isEqualToString:@"05"] )
    {
        ret = ZMWChinaTelecom;
    }
    
    return(ret);
}

@end
