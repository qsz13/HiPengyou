//
//  HPProfileSettingViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 4/5/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPProfileSettingViewController.h"
#import "HPAPIURL.h"
#import "UIView+Resize.h"

@interface HPProfileSettingViewController ()

@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UILabel *settingTitleLabel;
@property (strong, nonatomic) UIImageView *faceUploadImageView;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) UIButton *uploadButton;
@property (strong, nonatomic) NSString *sid;
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
    [self initUploadButton];
}

#pragma mark - Data Init
- (void)initData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sid = [userDefaults objectForKey:@"sid"];

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
    [self.faceUploadImageView resetCenter:CGPointMake([self.view getWidth]/2, [self.view getHeight]/4)];
    [self.faceUploadImageView setBackgroundColor:[UIColor colorWithRed:48.0f / 255.0f
                                                                 green:188.0f / 255.0f
                                                                  blue:235.0f / 255.0f
                                                                 alpha:1]];

    UIButton *maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [maskButton setFrame:CGRectMake(0, 0, [self.faceUploadImageView getWidth], [self.faceUploadImageView getHeight])];
    [maskButton addTarget:self action:@selector(didClickSelectImage) forControlEvents:UIControlEventTouchUpInside];
    
    [maskButton setFrame:self.faceUploadImageView.frame];
    [self.view addSubview:self.faceUploadImageView];
    [self.view addSubview:maskButton];

    
}

- (void)initUploadButton
{
    self.uploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.uploadButton setTitle:@"upload" forState:UIControlStateNormal];
    [self.uploadButton sizeToFit];
    [self.uploadButton setCenter:CGPointMake([self.view getWidth]/2, [self.view getHeight]/2)];
    [self.uploadButton setBackgroundColor:[UIColor colorWithRed:48.0f / 255.0f
                                                                 green:188.0f / 255.0f
                                                                  blue:235.0f / 255.0f
                                                                 alpha:1]];

    [self.uploadButton addTarget:self action:@selector(didClickUploadButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.uploadButton];
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

-(void)imagePickerController:
(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.faceUploadImageView.image = chosenImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:
(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - NSData
- (void)uploadImageRequest
{
    UIImage *image= self.faceUploadImageView.image;
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *postLength = [NSString stringWithFormat:@"%d", [imageData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@sid=%@",UPLOAD_FACE_URL,self.sid]];
    [request setURL:url];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:imageData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //connection successed
        if([data length] > 0 && connectionError == nil)
        {
            NSError *e = nil;
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            
            NSLog(@"%@",dataDict);
            //register successed
            if([[dataDict objectForKey:@"code"] isEqualToString:@"10000"])
            {
                self.postSuccessAlertView = [[UIAlertView alloc]  initWithTitle:@"success" message:@"upload Image ok" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [self.postSuccessAlertView show];
            }
            
            //reigister failed
            else if([[dataDict objectForKey:@"code"] isEqualToString:@"14009"])
            {
                self.postFailedAlertView = [[UIAlertView alloc]  initWithTitle:@"failed" message:@"upload failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [self.postFailedAlertView show];
            }
        }
        //connection failed
        else if (connectionError != nil)
        {
            self.postFailedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"connection error." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.postFailedAlertView show];
            
        }
        //unknow error
        else
        {
            NSLog(@"%@",data);
            self.postFailedAlertView = [[UIAlertView alloc]  initWithTitle:@"Oops.." message:@"something wrong..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.postFailedAlertView show];
        }
        
        
    }];

    
}

@end
