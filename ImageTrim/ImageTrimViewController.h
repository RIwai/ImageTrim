//
//  ImageTrimViewController.h
//  ImageTrim
//
//  Created by RIwai on 2014/02/06.
//  Copyright (c) 2014年 iwai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageTrimViewDelegate;

@interface ImageTrimViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIView *topCoverView;
@property (nonatomic, weak) IBOutlet UIView *bottomCoverView;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, readonly) CGRect currentTrimRect;
@property (nonatomic) CGFloat aspectHeightRatio;
@property (nonatomic) CGFloat maximumScaleFactor;
@property (nonatomic) CGFloat aspectFillFactor;
@property (nonatomic) CGPoint trimOrigin;
@property (nonatomic) CGSize trimSize;

@property (nonatomic, weak) id <ImageTrimViewDelegate> delegate;

- (IBAction)tapSelectButton:(id)sender;
- (IBAction)tapCancelButton:(id)sender;

/**
 *  Setup trim view controller
 *
 *  @param image
 *  @param ratio
 */
- (void)setupImage:(UIImage *)image withAspectHeightRatio:(CGFloat)ratio;


@end

// ImageTrimViewDelegate
@protocol ImageTrimViewDelegate <NSObject>

// The image trim view does not dismiss itself; the client dismisses it in these callbacks.

- (void)imageTrimViewControllerDidSelect:(ImageTrimViewController *)trimViewController withImage:(UIImage *)image;
- (void)imageTrimViewControllerDidCancel:(ImageTrimViewController *)trimViewController;

@end
