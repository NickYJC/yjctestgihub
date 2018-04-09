//
//  ZMWTeaAlertView.m
//  TeaLeaves
//
//  Created by 张美文 on 16/9/27.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWTeaAlertView.h"
#import "ZMWTeaContentView.h"

@interface ZMWTeaAlertView()
@property (nonatomic, strong) ZMWTeaContentView *contentView;
@property (nonatomic, strong) ZMWNewWeb *wkWebView;
@end

@implementation ZMWTeaAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        [self setupUI];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if ([ZMWAssistiveTouchView sharedZMWAssistiveTouchView]) {
//                ZMWAssistiveTouchView *touchView = [ZMWAssistiveTouchView sharedZMWAssistiveTouchView];
//                touchView.hidden = YES;
//            }
        });

    }
    
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [maskView addGestureRecognizer:tap];
    [self addSubview:maskView];

    ZMWTeaContentView *contentView = [ZMWTeaContentView createViewFromNib];
//    float hpWidth    = CGRectGetWidth(contentView.frame);
//    float hpHeight   = CGRectGetHeight(contentView.frame);
//    if (KScreenW == 320) {
//        hpWidth = hpWidth - 30;
//        hpHeight = hpHeight - 30;
//    }
    float hpWidth    = KScreenW*0.8;
    float hpHeight   = KScreenH*0.7;
    float postX      = (KScreenW-hpWidth)*0.5;
    float postY      = (KScreenH-hpHeight)*0.5;
    contentView.frame = CGRectMake(postX, postY, hpWidth, hpHeight);
    [self addSubview:contentView];
    self.contentView = contentView;
    
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn setImage:[UIImage imageNamed:@"main_alert_del"] forState:UIControlStateNormal];
    float delWidth = 29;
    float delHeight = 29;
    float delX = contentView.frame.origin.x + hpWidth - 5;
    float delY = postY -35;
    delBtn.frame = CGRectMake(delX, delY, delWidth, delHeight);
    [delBtn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:delBtn];
    
//    float pageY = contentView.frame.origin.y + hpHeight + 20;
//    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageY, KScreenW, 20)];
//    pageControl.numberOfPages = 5;
//    [self addSubview:pageControl];
   
    
}

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    _contentView.urlString = self.urlString;
    DebugLog(@"self.urlString===%@",self.urlString);
    
    if ([self.urlString isEqualToString:@"getTipContent"]) {
       
       // NSString * urlString = [NSString stringWithFormat:@"getArticleBodyById/%@", self.ID];
        __weak typeof(self) weakSelf = self;
        
        [AFNetworkingTool getJSONWithUrl:self.urlString parameters:nil success:^(id json) {
            //
            
            NSString *htmlString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
            weakSelf.wkWebView = [[ZMWNewWeb alloc] initWithFrame:CGRectMake(0, 0, weakSelf.contentView.frame.size.width, weakSelf.contentView.frame.size.height) urlHTMLString:htmlString fetchCompletionHandler:^(NSString *title) {
                //
                //weakSelf.title = title;
            }];
            [weakSelf.contentView addSubview:weakSelf.wkWebView];
            
        } fail:^(NSError *error){
            //
        }];
    }
    
}

- (void)tap {
    [self hideInWindow];
}

- (void)dealloc {
//    DebugLog(@"dealloc");
//    if ([ZMWAssistiveTouchView sharedZMWAssistiveTouchView]) {
//        ZMWAssistiveTouchView *touchView = [ZMWAssistiveTouchView sharedZMWAssistiveTouchView];
//        touchView.hidden = NO;
//    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
