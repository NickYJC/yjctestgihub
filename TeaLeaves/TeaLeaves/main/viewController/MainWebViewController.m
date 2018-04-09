//
//  MainWebViewController.m
//  TeaLeaves
//
//  Created by 张美文 on 15/12/11.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "MainWebViewController.h"

@interface MainWebViewController ()<WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) ZMWNewWeb *wkWebView;

@end

@implementation MainWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    if (self.type == 1000) {
        [self requestHTMLCode];
    }else {
        _wkWebView = [[ZMWNewWeb alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-64) urlString:[NSString stringWithFormat:@"http://%@", self.webURL] fetchCompletionHandler:^(NSString *title) {
            weakSelf.title = title;
        }];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        [self.view addSubview:_wkWebView];

    }
    


}

- (void)requestHTMLCode {
//    __weak typeof(ZMWNewWeb *) weakWkWebView = _wkWebView;
    UserObject *myObj = [LoginMessage getInfoMessageValue];
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    [parms setValue:myObj.userNo forKey:@"userId"];
    [parms setValue:@1 forKey:@"pageNo"];
    [parms setValue:@10 forKey:@"pageRows"];

    [AFNetworkingTool postJSONWithUrl:@"getTopupRecord" parameters:parms success:^(id responseObject) {
        //
         NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
         _wkWebView = [[ZMWNewWeb alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) urlHTMLString:response fetchCompletionHandler:^(NSString *title) {
             self.title = title;
         }];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        [self.view addSubview:_wkWebView];
    } fail:^(NSError *error) {
        //
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.tabBarController.tabBar.hidden = NO;
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
