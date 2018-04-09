//
//  ZMWNetworkAPIClient.h
//  TeaLeaves
//
//  Created by 张美文 on 2017/2/28.
//  Copyright © 2017年 walter. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ZMWNetworkAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
