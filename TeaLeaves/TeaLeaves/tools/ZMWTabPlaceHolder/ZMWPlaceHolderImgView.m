//
//  ZMWPlaceHolderImgView.m
//  TeaLeaves
//
//  Created by 张美文 on 2016/10/13.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWPlaceHolderImgView.h"

@interface ZMWPlaceHolderImgView()
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZMWPlaceHolderImgView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame placeHodlerImageName:(NSString *)name {
    if (self = [super initWithFrame:frame]) {
        //
        [self setupUI:name];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rectWifi = self.imageView.frame ;
    CGSize imgSize = self.imageView.size;
    rectWifi.origin.x = (self.frame.size.width - imgSize.width) / 2.0 ;
    rectWifi.origin.y = (self.frame.size.height - imgSize.height) / 2.0 ;
    
    self.imageView.frame = rectWifi ;
    
}

- (void)setImageName:(NSString *)imageName {
    _imageName = [imageName copy];
    self.imageView.image = [UIImage imageNamed:imageName];
    [self setNeedsLayout];
}

- (void)setupUI:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    CGSize size = image.size;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    imageView.image = image;
    [self addSubview:imageView];
    self.imageView = imageView;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
