//
//  ZMWTeaCollectionViewCell.m
//  TeaLeaves
//
//  Created by 张美文 on 16/9/28.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWTeaCollectionViewCell.h"

@interface ZMWTeaCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ZMWTeaCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    /*
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.scrollEnabled = NO;
    [_webView sizeToFit];
     */

}

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    
    NSString *string = [NSString stringWithFormat:@"%@%@", HOSTURL, self.urlString];
    NSURL *url = [NSURL URLWithString:string];
    DebugLog(@"dslkfjwekljfl: %@", string);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

/*
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize contentSize = webView.scrollView.contentSize;
    CGSize viewSize = self.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    webView.scrollView.minimumZoomScale = rw;
    webView.scrollView.maximumZoomScale = rw;
    webView.scrollView.zoomScale = rw;
}
 */


@end
