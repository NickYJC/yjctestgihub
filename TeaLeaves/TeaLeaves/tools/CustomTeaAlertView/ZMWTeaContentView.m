//
//  ZMWTeaContentView.m
//  TeaLeaves
//
//  Created by 张美文 on 16/9/27.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWTeaContentView.h"
#import "ZMWTeaCollectionView.h"

@interface ZMWTeaContentView()
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet ZMWTeaCollectionView *collectionView;

@end

@implementation ZMWTeaContentView

- (void)awakeFromNib{
    [super awakeFromNib];

    __weak typeof(self) weakSelf = self;
    self.collectionView.block = ^(int number, ZMWPreSellCardType type){
        if (type == kZMWPreSellCardTypeNum) {
            weakSelf.pageControl.numberOfPages = number;
            if (number < 2) {
                weakSelf.pageControl.hidden = YES;
            }else {
                weakSelf.pageControl.hidden = NO;
            }

        }else {
            weakSelf.pageControl.currentPage = number;

        }
    };
}

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    _collectionView.urlString = self.urlString;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
