//
//  ZMWSocket.m
//  TeaLeaves
//
//  Created by 张美文 on 15/12/23.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "ZMWSocket.h"
#import <SocketRocket/SRWebSocket.h>

@interface ZMWSocket()<SRWebSocketDelegate>
{
    SRWebSocket *_webSocket;
}

@end

@implementation ZMWSocket

singleton_implementation(ZMWSocket)

- (void)connect:(NSString *)urlString{
    _webSocket.delegate = nil;
    [_webSocket close];
    self.opened = NO;
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    _webSocket.delegate = self;
    DebugLog(@"Socket Open Connection...");
    [_webSocket open];
}

- (void)sendMessage:(NSDictionary *)messageDic{
    [_webSocket send:[self dictionaryToJson:messageDic]];
    DebugLog(@"Socket Send Message");
}

- (NSString *)dictionaryToJson:(NSDictionary *)dic{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (void)disconnect{
    _webSocket.delegate = nil;
    [_webSocket close];
    _webSocket = nil;
}

#pragma - SocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    DebugLog(@"Socket Connected");
    self.opened = YES;
    if (self.connectedBlock) {
        self.connectedBlock();
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    DebugLog(@"Socket Failed With Error:%@", error);
    if (self.failedBlock) {
        self.failedBlock();
    }
    self.opened = NO;
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    
//    DebugLog(@"webSocketMessage: %@", message);
    
    NSData *resData = [[NSData alloc] initWithData:[message dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSDictionary *resultTmpDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
//    DebugLog(@"Socket ReceiveMessage:%@", message);
//    DebugLog(@"Socket resultTmpDic:%@", resultTmpDic);
    
    if (self.receiveBlock) {
        self.receiveBlock(resultTmpDic);
    }

}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    DebugLog(@"Socket Closed");
    if (self.closedBlock) {
        self.closedBlock();
    }
    self.opened = NO;
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    DebugLog(@"Socket received pong");
}



@end
