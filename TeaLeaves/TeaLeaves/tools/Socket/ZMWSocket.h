//
//  ZMWSocket.h
//  TeaLeaves
//
//  Created by 张美文 on 15/12/23.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ZMWSocketReceiveBlock)(id);
typedef void (^ZMWSocketConnectedBlock)();
typedef void (^ZMWSocketClosedBlock)();
typedef void (^ZMWSocketFailedBlock)();

@interface ZMWSocket : NSObject
@property (nonatomic, assign, getter=isOpened) BOOL opened;
@property (nonatomic, copy) ZMWSocketReceiveBlock receiveBlock;
@property (nonatomic, copy) ZMWSocketConnectedBlock connectedBlock;
@property (nonatomic, copy) ZMWSocketClosedBlock closedBlock;
@property (nonatomic, copy) ZMWSocketFailedBlock failedBlock;


singleton_interface(ZMWSocket)
- (void)connect:(NSString *)urlString;
- (void)sendMessage:(NSDictionary *)messageDic;
- (void)disconnect;

@end
