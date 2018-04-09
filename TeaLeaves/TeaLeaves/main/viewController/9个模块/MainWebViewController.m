//
//  MainWebViewController.m
//  TeaLeaves
//
//  Created by 张美文 on 15/12/11.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "MainWebViewController.h"

@interface MainWebViewController ()<UIWebViewDelegate>
@property (nonatomic, retain) UIWebView *webView;

@end

@implementation MainWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"茶叶介绍";
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    _webView.delegate = self;
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.szpztea.com"]];
    __weak typeof(self) weakSelf = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", weakSelf.webURL]]];
    [_webView loadRequest:request];//@"http://www.szpztea.com"
    [self.view addSubview:_webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
