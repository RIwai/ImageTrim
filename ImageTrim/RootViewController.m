//
//  RootViewController.m
//  ImageTrim
//
//  Created by RIwai on 2014/02/06.
//  Copyright (c) 2014年 iwai. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapImageSelectButton:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;

    self.picker = imagePicker;
    
    [self presentViewController:imagePicker animated:YES completion:^{}];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];

    ImageTrimViewController *imageTrimViewController = [[ImageTrimViewController alloc] initWithNibName:@"ImageTrimViewController" bundle:nil];

    imageTrimViewController.delegate = self;

    [picker presentViewController:imageTrimViewController animated:YES completion:^{
        [imageTrimViewController setupImage:selectedImage withAspectHeightRatio:self.slider.value];
    }];
//    [self dismissViewControllerAnimated:NO completion:^{
//        [self presentViewController:imageTrimViewController animated:YES completion:^{}];
//        [imageTrimViewController setupImage:selectedImage withAspectHeightRatio:self.slider.value];
//    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - ImageTrimViewDelegate

- (void)imageTrimViewControllerDidSelect:(ImageTrimViewController *)trimViewController withImage:(UIImage *)image {
    self.imageView.image = image;

    [self dismissViewControllerAnimated:NO completion:^{
        self.picker = nil;
    }];
//    [self.picker dismissViewControllerAnimated:YES completion:^{
//    }];
}

- (void)imageTrimViewControllerDidCancel:(ImageTrimViewController *)trimViewController {
    [self.picker dismissViewControllerAnimated:YES completion:^{}];
//    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
