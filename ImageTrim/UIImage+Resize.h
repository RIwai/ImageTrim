//
//  UIImage+Resize.h
//  ImageTrim
//
//  Created by RIwai on 2014/01/23.
//  Copyright (c) 2014年 CyberAgent, Inc. All rights reserved.
//

@interface UIImage (Resize)

/**
 *  Resize Uimage
 *
 *  @param sourceImage
 *  @param width
 *  @param height
 *
 *  @return Resized UIImage Object
 */
+ (UIImage *)resizeImage:(UIImage *)sourceImage maxWidth:(CGFloat)width maxHeight:(CGFloat)height;

/**
 *  Resize Square Image
 *
 *  @param sourceImage
 *  @param length
 *
 *  @return Resized UIImage Object
 */
+ (UIImage *)resizeSquareImage:(UIImage *)sourceImage length:(CGFloat)length;

/**
 *  Image to square
 */
+ (UIImage *)imageToSquare:(UIImage *)sourceImage;

/**
 *  Trimming Image
 *
 *  @param sourceImage
 *  @param trimRect
 *
 *  @return trimed image
 */
+ (UIImage *)trimImage:(UIImage *)sourceImage rect:(CGRect)trimRect;

@end
