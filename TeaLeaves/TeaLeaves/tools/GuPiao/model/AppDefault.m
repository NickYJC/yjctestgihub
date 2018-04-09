//
//  AppDefault.m
//  TeaLeaves
//
//  Created by YangJingcai on 15/11/21.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "AppDefault.h"

@implementation AppDefault
+(AppDefault*)shareDefault
{
    static AppDefault *app;
    if (!app) {
        app = [[AppDefault alloc]init];
       
        
    }
    return app;
}
+ (void)createThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent toPath:(NSString *)thumbPath{
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat scaleFactor = 0.0;
    CGPoint thumbPoint = CGPointMake(0.0,0.0);
    CGFloat widthFactor = thumbSize.width / width;
    CGFloat heightFactor = thumbSize.height / height;
    if (widthFactor > heightFactor)  {
        scaleFactor = widthFactor;
    }
    else {
        scaleFactor = heightFactor;
    }
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    if (widthFactor > heightFactor)
    {
        thumbPoint.y = (thumbSize.height - scaledHeight) * 0.5;
    }
    else if (widthFactor < heightFactor)
    {
        thumbPoint.x = (thumbSize.width - scaledWidth) * 0.5;
    }
    UIGraphicsBeginImageContext(thumbSize);
    CGRect thumbRect = CGRectZero;
    thumbRect.origin = thumbPoint;
    thumbRect.size.width  = scaledWidth;
    thumbRect.size.height = scaledHeight;
    [image drawInRect:thumbRect];
    
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *thumbImageData = UIImageJPEGRepresentation(thumbImage, percent);
    [thumbImageData writeToFile:thumbPath atomically:NO];
}
+(NSString*)APPDefaultWith:(id)ower
{
    NSString *str=[NSString stringWithFormat:@"%@aaa",ower];
    
    
    //(null)
    if ([str isEqualToString:@"(null)aaa"]) {
        return @" ";
    }
    else if ([str isEqualToString:@"<null>aaa"]) {
        return @" ";
    }
    else
    {
        return [NSString stringWithFormat:@"%@",ower];
    }
}
+(NSString*)APPDefaultWithBackAccoss:(id)ower;
{
    NSString *str=[NSString stringWithFormat:@"%@aaa",ower];
    
    
    //(null)
    if ([str isEqualToString:@"(null)aaa"]) {
        return @"--";
    }
    else if ([str isEqualToString:@"<null>aaa"]) {
        return @"--";
    }
    else
    {
        return [NSString stringWithFormat:@"%@",ower];
    }

}
@end

