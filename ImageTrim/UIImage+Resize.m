//
//  UIImage+Resize.m
//  ImageTrim
//
//  Created by RIwai on 2014/01/23.
//  Copyright (c) 2014年 CyberAgent, Inc. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

+ (UIImage *)resizeImage:(UIImage *)sourceImage maxWidth:(CGFloat)width maxHeight:(CGFloat)height {
    if (sourceImage == nil) {
        return nil;
    }
    UIImage *retImage = nil;

    size_t w = sourceImage.size.width;
    size_t h = sourceImage.size.height;
    CGFloat targetWidth = 0.0f;
    CGFloat targetWidth2 = 0.0f;
    CGFloat targetHeight = 0.0f;
    CGFloat targetHeight2 = 0.0f;

    if (w > width) {
        targetWidth = width;
        targetHeight = h * targetWidth / w;
    } else {
        targetWidth = w;
        targetHeight = h;
    }

    if (targetHeight > height) {
        targetHeight2 = height;
        targetWidth2 = targetWidth * targetHeight2 / targetHeight;
    } else {
        targetHeight2 = targetHeight;
        targetWidth2 = targetWidth;
    }

    CGSize resizeSize = CGSizeMake(targetWidth2, targetHeight2);

    if (CGSizeEqualToSize(resizeSize, sourceImage.size) == YES) {
        // Not need resize
        return [[UIImage alloc] initWithCGImage:sourceImage.CGImage];
    }

    // Resize
    UIGraphicsBeginImageContext(resizeSize);
    CGRect rect;
    rect.origin = CGPointZero;
    rect.size = resizeSize;
    [sourceImage drawInRect:rect];
    retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return retImage;
}

+ (UIImage *)resizeSquareImage:(UIImage *)sourceImage length:(CGFloat)length {
    UIImage *retImage = nil;

    if (sourceImage == nil || length < 1.0f) {
        return nil;
    }

    CGSize originalSize = sourceImage.size;
    CGSize resizeSize = CGSizeZero;
    CGFloat resizeScale = 0.0f;

    if (originalSize.height > originalSize.width) {
        if (originalSize.height > length) {
            resizeScale = length / originalSize.height;
            resizeSize = CGSizeMake(originalSize.width * resizeScale, length);
        }
    } else {
        if (originalSize.width > length) {
            resizeScale = length / originalSize.width;
            resizeSize = CGSizeMake(length, originalSize.height * resizeScale);
        }
    }

    if (CGSizeEqualToSize(resizeSize, CGSizeZero)) {
        // Not need resize
        return [[UIImage alloc] initWithCGImage:sourceImage.CGImage];
    }

    // Resize
    UIGraphicsBeginImageContext(resizeSize);
    CGRect rect;
    rect.origin = CGPointZero;
    rect.size = resizeSize;
    [sourceImage drawInRect:rect];
    retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return retImage;
}

+ (UIImage *)imageToSquare:(UIImage *)sourceImage {
    UIImage *retImage = nil;
    int imageX = 0;
    int imageY = 0;

    if (sourceImage == nil) {
        return nil;
    }
    int imageW = sourceImage.size.width;
    int imageH = sourceImage.size.height;
    int imageSize = imageW;
    if (imageSize < imageH) {
        imageSize = imageH;
        imageX = (imageH - imageW) / 2;
    } else {
        imageY = (imageW - imageH) / 2;
    }
    unsigned char *bitmap = malloc(imageSize * imageSize * sizeof(unsigned char) * 4);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(bitmap,
                                                       imageSize,
                                                       imageSize,
                                                       8,
                                                       imageSize * 4,
                                                       colorSpace,
                                                       (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    // 塗りつぶす
    CGContextSetRGBFillColor(bitmapContext, 1.0, 1.0, 1.0, 0.0);
    CGRect r1 = CGRectMake(0.0, 0.0, imageSize, imageSize);
    CGContextFillRect(bitmapContext, r1);

    // UIImageを合成する
    CGContextDrawImage(bitmapContext, CGRectMake(imageX, imageY, imageW, imageH), sourceImage.CGImage);

    //CGContextからCGImageを作成
    CGImageRef imgRef = CGBitmapContextCreateImage(bitmapContext);

    //CGImageからUIImageを作成
    retImage = [UIImage imageWithCGImage:imgRef];

    //解放
    free(bitmap);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imgRef);
    CGContextRelease(bitmapContext);

    return retImage;
}

+ (UIImage *)trimImage:(UIImage *)sourceImage rect:(CGRect)trimRect {
    trimRect = CGRectMake(nearbyintf(trimRect.origin.x),
                          nearbyintf(trimRect.origin.y),
                          nearbyintf(trimRect.size.width),
                          nearbyintf(trimRect.size.height));

    UIGraphicsBeginImageContextWithOptions(trimRect.size,
                                           YES, // Opaque
                                           sourceImage.scale); // Use image scale

    [sourceImage drawInRect:CGRectMake(-trimRect.origin.x,
                                       -trimRect.origin.y,
                                       sourceImage.size.width,
                                       sourceImage.size.height)];
    UIImage *trimedImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return trimedImage;
}

@end
