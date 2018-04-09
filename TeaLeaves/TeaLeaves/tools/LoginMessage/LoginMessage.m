//
//  LoginMessage.m
//  Logistics
//
//  Created by 张美文 on 15/9/6.
//  Copyright (c) 2015年 walter. All rights reserved.

//

/*
 Package Summary:
 
 1 package(s) were not uploaded because they had problems:
	/var/folders/s8/553mtgwn56z27ggf8d2l7ddw0000gn/T/3E356167-7414-47EB-ABFD-18B4E1C467FF/1034712692.itmsp - Error Messages:
 The session's status is FAILED and the error description is 'Client unable to connect to server (check UDP port and firewall) (15)'
 An error occurred while uploading the package to Apple's remote server.
 An exception has occurred: The transport has been detected as having stalled and has been aborted.  Please try again.
 ERROR ITMS-90535: "Unexpected CFBundleExecutable Key. The bundle at 'Payload/WifeHelpUsers.app/TencentOpenApi_IOS_Bundle.bundle' does not contain a bundle executable. If this bundle intentionally does not contain an executable, consider removing the CFBundleExecutable key from its Info.plist and using a CFBundlePackageType of BNDL. If this bundle is part of a third-party framework, consider contacting the developer of the framework for an update to address this issue."
    zhuzi0311@163.com
    5979694
 */

#import "LoginMessage.h"
#import "ZMWSocket.h"

@implementation LoginMessage

+ (void)saveMessageValueByDictionary:(NSDictionary *)dic{
    NSUserDefaults *userDefalult = [NSUserDefaults standardUserDefaults];
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:dic];
    [userDefalult setObject:userData forKey:USER_INFO];
    [userDefalult synchronize];
}

+ (UserObject *)getInfoMessageValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *userData = [defaults objectForKey:USER_INFO];
    NSDictionary *loginDic = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    UserObject *model = [UserObject mj_objectWithKeyValues:loginDic];
    return model;
}

+ (NSDictionary *)changUserInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *userData = [defaults objectForKey:USER_INFO];
    return [NSKeyedUnarchiver unarchiveObjectWithData:userData];
}

+ (BOOL)checkLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults objectForKey:USER_INFO];
    
    if (dic == nil) {
        return NO;
    }
    else
        return  YES;
}

+(void)deleteUserDefaultMessage
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_INFO];
    [userDefaults synchronize];
    
    int recordTime = [[NSDate date] timeIntervalSince1970];
    NSNumber *timeNumber = [NSNumber numberWithInt:(recordTime-1000)];
    [[NSUserDefaults standardUserDefaults] setObject:timeNumber forKey:TRADEPASSWORDINTERVALNOTICE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    ZMWSocket *socket = [ZMWSocket sharedZMWSocket];
//    [socket disconnect];
    
   
}
@end
