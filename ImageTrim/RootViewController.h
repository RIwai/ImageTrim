//
//  RootViewController.h
//  ImageTrim
//
//  Created by RIwai on 2014/02/06.
//  Copyright (c) 2014年 iwai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageTrimViewController.h"

@interface RootViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, ImageTrimViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UISlider *slider;
@property (nonatomic, weak) IBOutlet UILabel *ratioLable;

@property (nonatomic, strong) UIImagePickerController *picker;

- (IBAction)tapImageSelectButton:(id)sender;
- (IBAction)changeSliderValue:(id)sender;

@end
