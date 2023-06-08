//
//  ConvertGradientImage.m
//  GradientLabelDemo
//
//  Created by 逸风 on 2022/1/1.
//
//https://stackoverflow.com/questions/59946577/how-give-gradient-on-text-in-textview-ios

#import <UIKit/UIKit.h>
#import "ConvertGradientImage.h"
#import "GradientLabel-Swift.h"

@implementation ConvertGradientImage

+ (UIImage *_Nullable)gradientImageWithConfig:(NSObject *_Nonnull)config size:(CGSize)size {
    GradientPatternLabelConfig *patternConfig = (GradientPatternLabelConfig *)config;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //绘制渐变层
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef,
                                                           (__bridge CFArrayRef)@[(id)patternConfig.startColor.CGColor,(id)patternConfig.endColor.CGColor],
                                                           NULL);
    /*
     gradientLayer.startPoint = CGPoint(x: 0, y: 0)
     gradientLayer.endPoint = CGPoint(x: 1, y: 1)
     */
    CGPoint startPoint = CGPointZero;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint,  kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    //取到渐变图片
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    //释放资源
    CGColorSpaceRelease(colorSpaceRef);
    CGGradientRelease(gradientRef);
    UIGraphicsEndImageContext();
    return gradientImage;
}

@end
