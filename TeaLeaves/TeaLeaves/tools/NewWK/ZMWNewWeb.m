//
//  ZMWNewWeb.m
//  TeaLeaves
//
//  Created by 张美文 on 16/6/28.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWNewWeb.h"

@interface ZMWNewWeb()
@property (nonatomic, strong) UIProgressView *wkProgressView;
@property (nonatomic, strong) NSString *urlString;

@end

@implementation ZMWNewWeb

- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString fetchCompletionHandler:(ZMWNewWebBlock)block{
    if (self = [super initWithFrame:frame]) {
        [self addObserver:self forKeyPath:@"estimatedProgress" options:(NSKeyValueObservingOptionNew) context:nil];
        self.urlString = urlString;
        [self addObserver:self forKeyPath:@"title" options:(NSKeyValueObservingOptionNew) context:nil];
        [self loadSubViews];
        [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        self.block = block;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame urlHTMLString:(NSString *)urlHTMLString fetchCompletionHandler:(ZMWNewWebBlock)block{
    if (self = [super initWithFrame:frame]) {
        //
        [self addObserver:self forKeyPath:@"estimatedProgress" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"title" options:(NSKeyValueObservingOptionNew) context:nil];
        [self loadSubViews];
        [self loadHTMLString:urlHTMLString baseURL:nil];
        self.block = block;
    }
    
    return self;
}

- (void)loadSubViews{
    _wkProgressView = [[UIProgressView alloc] initWithProgressViewStyle:(UIProgressViewStyleDefault)];
    _wkProgressView.frame = CGRectMake(0, 0, self.bounds.size.width, 2.f);
    _wkProgressView.transform = CGAffineTransformMakeScale(1.0, 3.0);
    [self addSubview:_wkProgressView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
//        DebugLog(@"estimatedProgress: %f", self.estimatedProgress);
        
        if ([self.urlString rangeOfString:@"productsIntroduction"].location != NSNotFound) {
            if (self.estimatedProgress > 0.5) {
                _wkProgressView.hidden = YES;
            }else{
                [_wkProgressView setProgress:self.estimatedProgress*2];
                if (self.estimatedProgress == 0.5) {
                    _wkProgressView.hidden = YES;
                }
            }

        }else {
            _wkProgressView.hidden = self.estimatedProgress == 1;
            [_wkProgressView setProgress:self.estimatedProgress];
        }
    
    }else if ([keyPath isEqualToString:@"title"]){
        if (self.block) {
            self.block(self.title);
        }
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
    [self removeObserver:self forKeyPath:@"title"];
}

@end
