//
//  HPProfileSettingViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 4/5/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPProfileSettingViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "HPAPIURL.h"
#import "UIView+Resize.h"

@interface HPProfileSettingViewController ()

@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UILabel *settingTitleLabel;
@property (strong, nonatomic) UIImageView *faceUploadImageView;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) UIButton *uploadButton;
@property (strong, nonatomic) UIButton *logoutButton;
@property (strong, nonatomic) NSString *sid;
@property  NSInteger userID;
@property (strong, nonatomic) UIAlertView *postSuccessAlertView;
@property (strong, nonatomic) UIAlertView *postFailedAlertView;

@end

@implementation HPProfileSettingViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self initNaviBar];
    [self initImagePicker];
    [self initFaceUploadImageView];
    [self initButton];
}

#pragma mark - Data Init
- (void)initData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sid = [userDefaults objectForKey:@"sid"];
    self.userID = [userDefaults integerForKey:@"id"];

}

#pragma mark - UI init
- (void)initView
{
    [self.view setBackgroundColor:[UIColor colorWithRed:230.0f / 255.0f
                                                  green:230.0f / 255.0f
                                                   blue:230.0f / 255.0f
                                                  alpha:1]];
}

- (void)initNaviBar
{
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"HPBackButton"] forState:UIControlStateNormal];
    [self.backButton resetSize:CGSizeMake(20, 20)];
    [self.backButton setCenter:CGPointMake(19/2+10, 43)];
    [self.backButton addTarget:self action:@selector(didClickBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    self.settingTitleLabel = [[UILabel alloc]init];
    [self.settingTitleLabel resetSize:CGSizeMake(500, 30)];
    [self.settingTitleLabel setText:@"Settings"];
    self.settingTitleLabel.numberOfLines = 1;
    [self.settingTitleLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                     green:188.0f / 255.0f
                                                      blue:235.0f / 255.0f
                                                     alpha:1]];
    [self.settingTitleLabel setBackgroundColor:[UIColor clearColor]];
    [self.settingTitleLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [self.settingTitleLabel sizeToFit];
    [self.settingTitleLabel setCenter:CGPointMake([self.view getWidth]/2, 87.5/2)];
    [self.view addSubview:self.settingTitleLabel];

    
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

- (void)initFaceUploadImageView
{
    self.faceUploadImageView = [[UIImageView alloc]init];
    [self.faceUploadImageView resetSize:CGSizeMake(150, 150)];
    [self.faceUploadImageView resetCenter:CGPointMake([self.view getWidth]/2, [self.view getHeight]/3)];
    [self.faceUploadImageView setBackgroundColor:[UIColor colorWithRed:48.0f / 255.0f
                                                                 green:188.0f / 255.0f
                                                                  blue:235.0f / 255.0f
                                                                 alpha:1]];

    NSURL *faceImageURL = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%d.png",FACE_IMAGE_URL,self.userID]];
    [self.faceUploadImageView setImageWithURL:faceImageURL];
    if(self.faceUploadImageView.image == nil)
    {
        [self.faceUploadImageView setImage:[UIImage imageNamed:@"HPDefaultFaceImage"]];
    }

    
    
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

- (void)initButton
{
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
    
    
    
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [self.logoutButton sizeToFit];
    [self.logoutButton resetSize:CGSizeMake(self.faceUploadImageView.frame.size.width+50, self.uploadButton.frame.size.height)];
    [self.logoutButton setCenter:CGPointMake([self.view getWidth]/2, [self.uploadButton getOriginY]+[self.uploadButton getHeight]+30)];
    [self.logoutButton setBackgroundColor:[UIColor redColor]];
    [self.logoutButton addTarget:self action:@selector(didClickLogout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logoutButton];
    
    
    
}



#pragma mark - button event


- (void)didClickBackButton
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didClickUploadButton
{
    NSLog(@"upload");
    [self uploadImageRequest];
}

- (void)didClickSelectImage
{

    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)didClickLogout
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)imagePickerController:
(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.faceUploadImageView.image = chosenImage;
    NSLog(@"%@",info);
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:
(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Image upload

-(void)uploadImageRequest
{
    UIImage *oldImage = self.faceUploadImageView.image;
    CGSize newSize = CGSizeMake(80, 80);
    UIGraphicsBeginImageContext(newSize);
    [oldImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"%@",[NSString stringWithFormat:@"%@sid=%@",UPLOAD_FACE_URL,self.sid]);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:[NSString stringWithFormat:@"%@sid=%@",UPLOAD_FACE_URL,self.sid] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"file" fileName:[NSString stringWithFormat:@"%d.png",self.userID] mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        NSLog(@"%@",operation.responseString);
    }];


}



@end
