//
//  HPFaceUploadViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 4/6/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPFaceUploadViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "HPHomeViewController.h"
#import "HPAPIURL.h"
#import "UIView+Resize.h"

@interface HPFaceUploadViewController ()


@property (strong, nonatomic) UIImageView *faceUploadImageView;
@property (strong, nonatomic) UIButton *skipButton;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) UIButton *uploadButton;
@property (strong, nonatomic) NSString *sid;
@property NSInteger userID;


@end

@implementation HPFaceUploadViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self initImagePicker];
    [self initFaceUploadImageView];
    [self initButton];
}


- (void)initView
{
    [self.view setBackgroundColor:[UIColor colorWithRed:49.0f / 255.0f
                                                  green:188.0f / 255.0f
                                                   blue:234.0f / 255.0f
                                                  alpha:1]];
}

- (void)initData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.sid = [userDefaults objectForKey:@"sid"];
    self.userID = [userDefaults integerForKey:@"id"];


}

- (void)initButton
{
    self.skipButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.skipButton setTitle:@"skip...TO BE DONE" forState:UIControlStateNormal];
    [self.skipButton setFrame:CGRectMake([self.view getWidth]/2, [self.view getHeight]/2, 300, 50)];
    [self.skipButton addTarget:self action:@selector(didClickSkipButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.skipButton];
    
    self.uploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.uploadButton setTitle:@"Upload" forState:UIControlStateNormal];
    [self.uploadButton sizeToFit];
    [self.uploadButton resetSize:CGSizeMake(self.faceUploadImageView.frame.size.width+50, self.uploadButton.frame.size.height)];
    [self.uploadButton setCenter:CGPointMake([self.view getWidth]/2, [self.faceUploadImageView getOriginY]+[self.faceUploadImageView getHeight]+40)];
    
    [self.uploadButton setBackgroundColor:[UIColor colorWithRed:48.0f / 255.0f
                                                          green:188.0f / 255.0f
                                                           blue:235.0f / 255.0f
                                                          alpha:1]];
    
    [self.uploadButton addTarget:self action:@selector(didClickUploadButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.uploadButton];

}

- (void)initFaceUploadImageView
{
    self.faceUploadImageView = [[UIImageView alloc]init];
    [self.faceUploadImageView resetSize:CGSizeMake(150, 150)];
    [self.faceUploadImageView resetCenter:CGPointMake([self.view getWidth]/2, [self.view getHeight]/3)];
    [self.faceUploadImageView setBackgroundColor:[UIColor colorWithRed:48.0f / 255.0f
                                                                 green:188.0f / 255.0f
                                                                  blue:235.0f / 255.0f
                                                                 alpha:1]];
    

    [self.faceUploadImageView setImage:[UIImage imageNamed:@"HPDefaultFaceImage"]];

    
    
    
    UIButton *maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [maskButton setFrame:CGRectMake(0, 0, [self.faceUploadImageView getWidth], [self.faceUploadImageView getHeight])];
    [maskButton setBackgroundColor:[UIColor colorWithRed:255.0f / 255.0f
                                                   green:255.0f / 255.0f
                                                    blue:255.0f / 255.0f
                                                   alpha:0.7]];
    [maskButton addTarget:self action:@selector(didClickSelectImage) forControlEvents:UIControlEventTouchUpInside];
    [maskButton setTitle:@"Select Image" forState:UIControlStateNormal];
    [maskButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [maskButton setFrame:self.faceUploadImageView.frame];
    [self.view addSubview:self.faceUploadImageView];
    [self.view addSubview:maskButton];
    
    
}

- (void)initImagePicker
{
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //    self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    //    self.imagePickerController.cameraDevice= UIImagePickerControllerCameraDeviceRear;
    //    self.imagePickerController.showsCameraControls = YES;
    self.imagePickerController.navigationBarHidden = NO;
    
    
}


#pragma mark - button event
- (void)didClickSkipButton
{
    [self.navigationController pushViewController:[[HPHomeViewController alloc]init] animated:YES];
}

- (void)didClickSelectImage
{
    
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)didClickUploadButton
{
    NSLog(@"upload");
    [self uploadImageRequest];
}

-(void)uploadImageRequest
{
    UIImage *oldImage = self.faceUploadImageView.image;
    CGSize newSize = CGSizeMake(80, 80);
    UIGraphicsBeginImageContext(newSize);
    [oldImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    [manager POST:[NSString stringWithFormat:@"%@sid=%@",UPLOAD_FACE_URL,self.sid] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"file" fileName:[NSString stringWithFormat:@"%d.png",self.userID] mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}


@end
