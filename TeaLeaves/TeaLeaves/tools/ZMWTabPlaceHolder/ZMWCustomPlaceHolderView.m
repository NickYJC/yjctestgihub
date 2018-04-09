//
//  ZMWCustomPlaceHolderView.m
//  TeaLeaves
//
//  Created by 张美文 on 2016/10/13.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWCustomPlaceHolderView.h"

@interface ZMWCustomPlaceHolderView()
@property (nonatomic, copy) ZMWCustomPlaceHolderBlock hodlerBlock;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UIView *customShareView;
@property (nonatomic, assign) ZMWCustomPlaceHodlerType type;


@end

@implementation ZMWCustomPlaceHolderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame showType:(ZMWCustomPlaceHodlerType)type fetchCompletionHandler:(ZMWCustomPlaceHolderBlock)block {
    if (self = [super initWithFrame:frame]) {
        //
        self.hodlerBlock = block;
        self.type = type;
        [self setupUI:type];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.type == kZMWCustomPlaceHodlerTypeButton) {
        self.customView.frame = CGRectMake(0, (self.bounds.size.height-249)/2, self.bounds.size.width, 249);
    }else {
        self.customShareView.frame = CGRectMake(0, (self.bounds.size.height-249)/2, self.bounds.size.width, 249);
    }
    
}

- (void)setupUI:(ZMWCustomPlaceHodlerType)type {
    if (type == kZMWCustomPlaceHodlerTypeButton) {
        [self addSubview:self.customView];
    }else {
        [self addSubview:self.customShareView];
    }
}

- (UIView *)customShareView {
    if (_customShareView == nil) {
        _customShareView = [[UIView alloc] init];
        
        UIImageView *noDataImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW/2-44, 0, 88, 88)];
        noDataImageView.image = [UIImage imageNamed:@"tuijian1"];
        [_customShareView addSubview:noDataImageView];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW/2-50, 113, 100, 21)];
        lable.text = @"还未推荐";
        lable.textColor = [UIColor colorWithHexString:@"848689"];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:17];
        [_customShareView addSubview:lable];
        
        UILabel *lableNotice = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW/2-80, 144, 160, 21)];
        lableNotice.text = @"去抽奖中心看看吧";
        lableNotice.textColor = [UIColor colorWithHexString:@"C8C8C8"];
        lableNotice.textAlignment = NSTextAlignmentCenter;
        lableNotice.font = [UIFont systemFontOfSize:14];
        [_customShareView addSubview:lableNotice];
        
        UIButton *seeBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenW/2-64, 214, 127,35)];
        [seeBtn setTitle:@"去看看" forState:(UIControlStateNormal)];
        seeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [seeBtn setTitleColor:[UIColor colorWithHexString:@"686868"] forState:(UIControlStateNormal)];
        seeBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tuijian2"]];
        [seeBtn addTarget:self action:@selector(seeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_customShareView addSubview:seeBtn];
    }
    
    return _customShareView;
}

- (UIView *)customView {
    if (_customView == nil) {
        _customView = [[UIView alloc] init];
        UIImageView *noDataImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW/2-44, 0, 88, 88)];
        noDataImageView.image = [UIImage imageNamed:@"shengou5"];
        [_customView addSubview:noDataImageView];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW/2-50, 113, 100, 21)];
        lable.text = @"没有申购劵";
        lable.textColor = [UIColor colorWithHexString:@"848689"];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:17];
        [_customView addSubview:lable];
        
        UILabel *lableNotice = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW/2-80, 144, 160, 21)];
        lableNotice.text = @"去抽奖中心看看吧";
        lableNotice.textColor = [UIColor colorWithHexString:@"C8C8C8"];
        lableNotice.textAlignment = NSTextAlignmentCenter;
        lableNotice.font = [UIFont systemFontOfSize:14];
        [_customView addSubview:lableNotice];
        
        UIButton *seeBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenW/2-64, 214, 127,35)];
        [seeBtn setTitle:@"去看看" forState:(UIControlStateNormal)];
        seeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [seeBtn setTitleColor:[UIColor colorWithHexString:@"686868"] forState:(UIControlStateNormal)];
        seeBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tuijian2"]];
        [seeBtn addTarget:self action:@selector(seeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_customView addSubview:seeBtn];


    }
    
    return _customView;
}

- (void)seeBtnClick {
    if (self.hodlerBlock) {
        self.hodlerBlock();
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
