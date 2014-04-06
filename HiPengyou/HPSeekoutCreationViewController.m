//
//  HPSeekoutCreationViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/30/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPSeekoutCreationViewController.h"
#import "HPAPIURL.h"
#import "UIView+Resize.h"

@interface HPSeekoutCreationViewController ()

@property (strong, atomic) UIButton *backButton;
@property (strong, atomic) UILabel *titleButton;
@property (strong, atomic) UITextView *seekoutContentTextView;
@property (strong, atomic) UIButton *seekoutTypeButton;
@property (strong, atomic) UIButton *seekoutLanguageButton;
@property (strong, atomic) UIButton *seekoutLocationButton;
@property (strong, atomic) UIImageView *seekoutTypeIcon;
@property (strong, atomic) UIImageView *seekoutLanguageIcon;
@property (strong, atomic) UIImageView *seekoutLocationIcon;
@property (strong, atomic) UIButton *seekoutPostButton;
@property (strong, atomic) UITableView *seekoutTypeTable;
@property (strong, atomic) UIAlertView *postAlertView;
@property (strong, atomic) NSString *sid;

@end

@implementation HPSeekoutCreationViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self initNaviBar];
    [self initTextView];
    [self initButton];
}

- (void)initData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sid = [userDefaults objectForKey:@"sid"];
    //    NSLog(@"%@", self.sid);
    
}


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

    
    
    self.titleButton = [[UILabel alloc]init];
    [self.titleButton resetSize:CGSizeMake(500, 30)];
    [self.titleButton setText:@"Create My Seekout"];
    self.titleButton.numberOfLines = 1;
    [self.titleButton setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                   green:188.0f / 255.0f
                                                    blue:235.0f / 255.0f
                                                   alpha:1]];
    [self.titleButton setBackgroundColor:[UIColor clearColor]];
    [self.titleButton setFont:[UIFont fontWithName:@"Helvetica-light" size:20]];
    [self.titleButton sizeToFit];
    [self.titleButton setCenter:CGPointMake([self.view getWidth]/2, 87.5/2)];
    [self.view addSubview:self.titleButton];
}

- (void)initTextView
{
    self.seekoutContentTextView = [[UITextView alloc]init];

    [self.seekoutContentTextView resetSize:CGSizeMake(300, [self.view getHeight]*0.3)];
    [self.seekoutContentTextView setCenter:CGPointMake([self.view getWidth]/2, 150/2+[self.seekoutContentTextView getHeight]/2)];
    
    [self.view addSubview:self.seekoutContentTextView];
    
    
}

- (void)initButton
{
    
    self.seekoutTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.seekoutTypeButton setBackgroundImage:[UIImage imageNamed:@"HPSeekoutInfoButtonBgImage"] forState:UIControlStateNormal];
    [self.seekoutTypeButton resetSize:CGSizeMake(300, 42)];
    [self.seekoutTypeButton setCenter:CGPointMake([self.view getWidth]/2, [self.seekoutContentTextView getOriginY] + [self.seekoutContentTextView getHeight] + 13/2 + [self.seekoutTypeButton getHeight]/2)];
    
    self.seekoutTypeIcon = [[UIImageView alloc]init];
    [self.seekoutTypeIcon setImage:[UIImage imageNamed:@"HPSeekoutInfoCategoriesButtonIcon"]];
    [self.seekoutTypeIcon resetSize:CGSizeMake(24, 24)];
    [self.seekoutTypeIcon setCenter:CGPointMake([self.seekoutTypeButton getHeight]/2, [self.seekoutTypeButton getHeight]/2)];
    
    [self.seekoutTypeButton addSubview:self.seekoutTypeIcon];
    [self.view addSubview:self.seekoutTypeButton];
    
    self.seekoutPostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.seekoutPostButton setTitle:@"Post" forState:UIControlStateNormal];
    [self.seekoutPostButton setBackgroundImage:[UIImage imageNamed:@"HPSeekoutPostButton"] forState:UIControlStateNormal];
    [self.seekoutPostButton resetSize:CGSizeMake(300, 42)];
    [self.seekoutPostButton setCenter:CGPointMake([self.view getWidth]/2, [self.seekoutTypeButton getCenterY] + [self.seekoutTypeButton getHeight] + 13/2)];
    [self.seekoutPostButton addTarget:self action:@selector(didClickPostButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.seekoutPostButton];

    
    
//    self.seekoutLanguageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.seekoutLanguageButton setBackgroundImage:[UIImage imageNamed:@"HPSeekoutInfoButtonBgImage"] forState:UIControlStateNormal];
//    [self.seekoutLanguageButton resetSize:CGSizeMake(300, 42)];
//    [self.seekoutLanguageButton setCenter:CGPointMake([self.view getWidth]/2, [self.seekoutTypeButton getOriginY] + [self.seekoutTypeButton getHeight] + 13/2 + [self.seekoutLanguageButton getHeight]/2)];
//    
//    
//    self.seekoutLanguageIcon = [[UIImageView alloc]init];
//    [self.seekoutLanguageIcon setImage:[UIImage imageNamed:@"HPSeekoutInfoLanguageButtonIcon"]];
//    [self.seekoutLanguageIcon resetSize:CGSizeMake(24, 24)];
//    [self.seekoutLanguageIcon setCenter:CGPointMake([self.seekoutTypeButton getHeight]/2, [self.seekoutTypeButton getHeight]/2)];
//
//    [self.seekoutLanguageButton addSubview:self.seekoutLanguageIcon];
//    [self.view addSubview:self.seekoutLanguageButton];
//    
//    
//    self.seekoutLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.seekoutLocationButton setBackgroundImage:[UIImage imageNamed:@"HPSeekoutInfoButtonBgImage"] forState:UIControlStateNormal];
//    [self.seekoutLocationButton resetSize:CGSizeMake(300, 42)];
//    [self.seekoutLocationButton setCenter:CGPointMake([self.view getWidth]/2, [self.seekoutLanguageButton getOriginY] + [self.seekoutLanguageButton getHeight] + 13/2 + [self.seekoutLocationButton getHeight]/2)];
//    
//    
//    self.seekoutLocationIcon = [[UIImageView alloc]init];
//    [self.seekoutLocationIcon setImage:[UIImage imageNamed:@"HPSeekoutInfoLocationButtonIcon"]];
//    [self.seekoutLocationIcon resetSize:CGSizeMake(24, 24)];
//    [self.seekoutLocationIcon setCenter:CGPointMake([self.seekoutTypeButton getHeight]/2, [self.seekoutTypeButton getHeight]/2)];
//    
//    [self.seekoutLocationButton addSubview:self.seekoutLocationIcon];
//    [self.view addSubview:self.seekoutLocationButton];

    
    
    
}

#pragma mark - Keyboard Dismiss
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    [self.seekoutContentTextView resignFirstResponder];

}

#pragma mark - button event
- (void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickPostButton
{
    NSString *seekoutContentText = self.seekoutContentTextView.text;
    if([seekoutContentText length] <= 0)
    {
        self.postAlertView = [[UIAlertView alloc]  initWithTitle:@"Oops.." message:@"pleas say somthing before you say somethig" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.postAlertView show];
    }

    [self postRequest];
    
}

#pragma mark - http request
-(void)postRequest
{
    
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",SEEKOUT_CREATE_URL, self.sid] ];
    NSString *seekoutContentText = self.seekoutContentTextView.text;
    
    
    
    //content=test%20test%20test&towhom=All&towhere=All%20cities&country=China&city=Shanghai&type=0&hasmedia=0&
//    NSDictionary *postDictionary = @{
//                                     @"content":seekoutContentText,
//                                     @"towhom":@"All",
//                                     @"towhere":@"Allcities",
//                                     @"country":@"China",
//                                     @"city":@"Shanghai",
//                                     @"type":@0,
//                                     @"hasmedia":@0
//                                     };
    
//    NSData *postData = [NSKeyedArchiver ar:postDictionary];
//    NSString *strData = [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
//    NSLog(@"!!!%@",strData);
    NSData *postData = [[NSString stringWithFormat:@"content=%@&towhom=%@&towhere=%@&country=%@&city=%@&type=%@&hasmedia=%@&",seekoutContentText,@"All",@"All cities",@"China",@"Shanghai",@0,@0] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
        NSLog(@"%@",request);

    
    
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
                self.postAlertView = [[UIAlertView alloc]  initWithTitle:@"success" message:@"Create seekout ok" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [self.postAlertView show];
            }
            
            //reigister failed
            else if([[dataDict objectForKey:@"code"] isEqualToString:@"14009"])
            {
                self.postAlertView = [[UIAlertView alloc]  initWithTitle:@"failed" message:@"Create seekout failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [self.postAlertView show];
            }
        }
        //connection failed
        else if (connectionError != nil)
        {
            self.postAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"connection error." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.postAlertView show];
            
        }
        //unknow error
        else
        {
            NSLog(@"%@",data);
            self.postAlertView = [[UIAlertView alloc]  initWithTitle:@"Oops.." message:@"something wrong..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.postAlertView show];
        }
        
        
    }];

    
    
    
    
    
}


@end
