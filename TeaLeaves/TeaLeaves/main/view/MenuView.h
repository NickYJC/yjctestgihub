//
//  MenuView.h
//  textAFNetworking
//
//  Created by 张美文 on 15/11/6.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MemuBtnOnClick) (NSInteger index);

@interface MenuView : UIView

@property (nonatomic, copy) MemuBtnOnClick block;
@property (nonatomic, retain) NSString *backgroudImg;
@property (nonatomic,assign) BOOL isFullScreen;

- (id)initWithFrame:(CGRect)frame buttonTitleArr:(NSArray *)buttonArr completeBlock:(MemuBtnOnClick)block;

- (void)selectedIndexButtonWithTag: (NSInteger)tag;

- (void)selectedIndexButtonWithTag: (NSInteger)tag titleWithNumber:(NSString *)number;
- (void)selectedFullScreenIndexButtonWithTag:(NSInteger)tag title:(NSString *)title;
@end
