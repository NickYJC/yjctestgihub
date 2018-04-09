//
//  UIImage+walter.h
//  Patica
//
//  Created by 张美文 on 16/7/15.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (walter)

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

- (UIImage *)watermarkImage:(NSString *)text;

@end
