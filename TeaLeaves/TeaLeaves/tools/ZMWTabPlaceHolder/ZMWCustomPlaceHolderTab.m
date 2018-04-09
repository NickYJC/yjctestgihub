//
//  ZMWCustomPlaceHolderTab.m
//  TeaLeaves
//
//  Created by 张美文 on 2016/10/13.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWCustomPlaceHolderTab.h"
#import "ZMWCustomPlaceHolderView.h"
#import "ZMWPlaceHolderImgView.h"

@interface ZMWCustomPlaceHolderTab()<ZMWTabPlaceHolderDelegate>

@end

@implementation ZMWCustomPlaceHolderTab

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        //
        self.type = kZMWCustomPlaceHodlerTypeImage;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //
        self.type = kZMWCustomPlaceHodlerTypeImage;
    }
    
    return self;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = [imageName copy];
    
}

- (void)setType:(ZMWCustomPlaceHodlerType)type {
    _type = type;
}


#pragma mark - ZMWTabPlaceHolder delegate
- (UIView *)makePlaceHolderView {
    ZMWWeakSelf(self)
    if (self.type == kZMWCustomPlaceHodlerTypeImage) {

        __block ZMWPlaceHolderImgView *holderImgView = [[ZMWPlaceHolderImgView alloc] initWithFrame:CGRectZero placeHodlerImageName:@"nodata"];
        if (self.imageName) {
            holderImgView.imageName = self.imageName;
        }

        return holderImgView;
        
    }else {
        
        __block ZMWCustomPlaceHolderView *holderView = [[ZMWCustomPlaceHolderView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) showType:self.type fetchCompletionHandler:^{
            //
            if (weakself.holderBlock) {
                weakself.holderBlock();
            }
        }];
        
        return holderView;
    }
    


}

- (BOOL)enableScrollWhenPlaceHolderViewShowing {
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
