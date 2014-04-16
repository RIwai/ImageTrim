//
//  ImageTrimViewController.m
//  ImageTrim
//
//  Created by RIwai on 2014/02/06.
//  Copyright (c) 2014年 iwai. All rights reserved.
//

#import "ImageTrimViewController.h"
#import "UIImage+Resize.h"
#import "UIImage+ViewToImage.h"

@interface ImageTrimViewController ()

@end

@implementation ImageTrimViewController

#pragma mark - Set Image

- (void)setupImage:(UIImage *)image withAspectHeightRatio:(CGFloat)ratio {
    // Init Value
    self.scrollView.minimumZoomScale = 0.5f;
    self.scrollView.maximumZoomScale = self.maximumScaleFactor = 8.0f;
    self.scrollView.zoomScale = 1.0f;

    // Set image
    self.image = image;

    // Revise ratio value
    if (ratio > 1.0f) {
        ratio = 1.0f;
    } else if (ratio <= 0.0f)   {
        ratio = 0.1f;
    }
    self.aspectHeightRatio = ratio;

    // Set trim mask view
    self.trimSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width * self.aspectHeightRatio);
    CGPoint scrollViewCenter = self.scrollView.center;
    CGRect topCoverViewRect = self.topCoverView.frame;
    CGRect bottomCoverViewRect = self.bottomCoverView.frame;
    topCoverViewRect.size.height = scrollViewCenter.y - (self.trimSize.height / 2.0f);
    self.topCoverView.frame = topCoverViewRect;
    bottomCoverViewRect.origin.y = topCoverViewRect.origin.x + topCoverViewRect.size.height + self.trimSize.height;
    bottomCoverViewRect.size.height = [UIScreen mainScreen].bounds.size.height - bottomCoverViewRect.origin.y;
    self.bottomCoverView.frame = bottomCoverViewRect;

    // Configure imageView
    self.trimOrigin = CGPointMake((self.scrollView.bounds.size.width - self.trimSize.width) / 2.0,
                                  (self.scrollView.bounds.size.height - self.trimSize.height) / 2.0);

    CGSize size = [self.imageView sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return;
    }
    self.imageView.frame = CGRectMake(self.trimOrigin.x,
                                      self.trimOrigin.y,
                                      size.width,
                                      size.height);

    // Configure scrollView
    self.aspectFillFactor = (CGFloat)MAX(self.trimSize.width / size.width, self.trimSize.height / size.height);
    self.scrollView.minimumZoomScale = self.aspectFillFactor;
    self.scrollView.maximumZoomScale = self.aspectFillFactor * self.maximumScaleFactor;
    self.scrollView.zoomScale = self.aspectFillFactor;

    [self scrollViewDidZoom:self.scrollView];

    // Center the scrollView
    [self.scrollView scrollRectToVisible:
     CGRectMake((self.scrollView.contentSize.width - self.scrollView.bounds.size.width) / 2.0,
                (self.scrollView.contentSize.height - self.scrollView.bounds.size.height) / 2.0,
                self.scrollView.bounds.size.width,
                self.scrollView.bounds.size.height)
                                animated:NO];
}

#pragma mark - image setter

- (void)setImage:(UIImage *)image {
    _image = image;

    self.imageView.image = image;
}

#pragma mark - rect getter

- (CGRect)currentTrimRect {
    // UI trim area
    CGRect trimRect = [self.imageView convertRect:CGRectMake(self.trimOrigin.x + self.scrollView.frame.origin.x,
                                                             self.trimOrigin.y + self.scrollView.frame.origin.y,
                                                             self.trimSize.width,
                                                             self.trimSize.height) fromView:self.view];

    // The image trim area
    CGFloat factor = self.image.size.width / self.imageView.bounds.size.width;
    trimRect = CGRectMake(trimRect.origin.x * factor,
                          trimRect.origin.y * factor,
                          trimRect.size.width * factor,
                          trimRect.size.height * factor);

    return trimRect;
}

#pragma mark - Action Method

- (IBAction)tapSelectButton:(id)sender {
    UIImage *image = self.imageView.image;
    CGRect trimRect = self.currentTrimRect;

    UIImage *trimedImage = [UIImage trimImage:image rect:trimRect];

    if ([self.delegate respondsToSelector:@selector(imageTrimViewControllerDidSelect:withImage:)]) {
        [self.delegate imageTrimViewControllerDidSelect:self withImage:trimedImage];
    }
}

- (IBAction)tapCancelButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(imageTrimViewControllerDidCancel:)]) {
        [self.delegate imageTrimViewControllerDidCancel:self];
    }
}

#pragma mark - UIScrollView Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // Adjust scrollView contentSize
    self.scrollView.contentSize = CGSizeMake(self.imageView.frame.size.width + (2.0 * self.trimOrigin.x),
                                             self.imageView.frame.size.height + (2.0 * self.trimOrigin.y));
}

@end
