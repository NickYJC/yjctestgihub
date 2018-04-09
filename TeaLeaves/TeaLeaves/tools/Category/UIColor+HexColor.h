//
//  UIColor+HexColor.h
//  TeaLeaves
//
//  Created by 张美文 on 15/11/30.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
