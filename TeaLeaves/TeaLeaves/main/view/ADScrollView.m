//
//  ADScrollView.m
//  TeaLeaves
//
//  Created by 张美文 on 15/11/18.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "ADScrollView.h"
#import "GetBannerModel.h"

@interface ADScrollView()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView * cycleScrollView;
@property (nonatomic, retain) UIImageView *backgroundImg;

@end

@implementation ADScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundImg.image = [UIImage imageNamed:@"1.jpg"];
    }
    
    return self;
}


- (void)awakeFromNib{
    [super awakeFromNib];

    self.backgroundImg.image = [UIImage imageNamed:@"2.jpg"];
}

- (NSMutableArray *)bannerListURL{
    if (_bannerListURL == nil) {
        _bannerListURL = [NSMutableArray array];
    }
    
    return _bannerListURL;
}

- (SDCycleScrollView *)cycleScrollView{
    if (_cycleScrollView == nil) {
        //        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) imagesGroup:nil];
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) delegate:self placeholderImage:[UIImage imageNamed:@"1.jpg"]];
        _cycleScrollView.infiniteLoop = YES;
        _cycleScrollView.autoScrollTimeInterval = 5.0;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.delegate = self;
        //        _cycleScrollView.placeholderImage = [UIImage imageNamed:@"qrcode"];
        _cycleScrollView.backgroundColor = [UIColor backgroundColor];
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        [self addSubview:_cycleScrollView];
        
        [self.backgroundImg removeFromSuperview];
        
    }
    
    return _cycleScrollView;
}

- (UIImageView *)backgroundImg{
    if (_backgroundImg == nil) {
        _backgroundImg = [[UIImageView alloc] initWithFrame:self.frame];
        [self addSubview:_backgroundImg];
    }
    
    return _backgroundImg;
}

- (void)layoutSubviews{
    
    NSMutableArray *tmpArray = [NSMutableArray array];

    if (self.bannerListURL.count) {
        for (GetBannerModel *model in self.bannerListURL) {
            [tmpArray addObject:model.bannerPicture];
        }
        self.cycleScrollView.imageURLStringsGroup = tmpArray;

    }
    
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    GetBannerModel *model = self.bannerListURL[index];
    if ([[AppDefault APPDefaultWith:model.skip] isEqualToString:@"01"]) {
        if (self.block) {
            self.block(model.bannerUrl);
        }
    }    

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
