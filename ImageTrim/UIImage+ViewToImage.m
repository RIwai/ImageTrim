//
//  UIImage+ViewToImage.m
//  ImageTrim
//
//  Created by Ryota Iwai on 2014/02/13.
//  Copyright (c) 2014年 iwai. All rights reserved.
//

#import "UIImage+ViewToImage.h"

@implementation UIImage (ViewToImage)

+ (UIImage *)imageWithUIview:(UIView *)view {
    UIImage *screenImage = nil;

    CGSize viewSize = view.frame.size;

    UIGraphicsBeginImageContextWithOptions(viewSize, NO, 0.0f);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    NSData *pngData = UIImagePNGRepresentation(UIGraphicsGetImageFromCurrentImageContext());
    screenImage = [UIImage imageWithData:pngData];
    UIGraphicsEndImageContext();

    return screenImage;
}

@end
