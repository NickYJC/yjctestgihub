//
//  ServiceTabSectionView.h
//  TeaLeaves
//
//  Created by 张美文 on 15/11/9.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ServiceTabSectionViewBlock)();

@interface ServiceTabSectionView : UIView
@property (nonatomic, copy)ServiceTabSectionViewBlock block;

- (instancetype)initWithFrame:(CGRect)frame clickButtonComplete:(ServiceTabSectionViewBlock)block;

-(void)updateSectionView:(NSArray *)titleArray WithStatus:(BOOL)status;

@end
