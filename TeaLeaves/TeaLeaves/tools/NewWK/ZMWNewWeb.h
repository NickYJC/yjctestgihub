//
//  ZMWNewWeb.h
//  TeaLeaves
//
//  Created by 张美文 on 16/6/28.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <WebKit/WebKit.h>

typedef void(^ZMWNewWebBlock)(NSString *title);

@interface ZMWNewWeb : WKWebView
@property (nonatomic, copy) ZMWNewWebBlock block;

- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString fetchCompletionHandler:(ZMWNewWebBlock)block;

- (instancetype)initWithFrame:(CGRect)frame urlHTMLString:(NSString *)urlHTMLString fetchCompletionHandler:(ZMWNewWebBlock)block;

@end
