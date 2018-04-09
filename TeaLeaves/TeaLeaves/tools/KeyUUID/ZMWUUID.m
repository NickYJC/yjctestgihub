//
//  ZMWUUID.m
//  TeaLeaves
//
//  Created by 张美文 on 2017/1/18.
//  Copyright © 2017年 walter. All rights reserved.
//

#import "ZMWUUID.h"
#import "ZMWKeyChainStore.h"

@implementation ZMWUUID

+(NSString *)walter_getUUID
{
    NSString * strUUID = (NSString *)[ZMWKeyChainStore load:@"com.company.app.usernamepassword"];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [ZMWKeyChainStore save:KEY_USERNAME_PASSWORD data:strUUID];
        
    }
    return strUUID;
}

@end
