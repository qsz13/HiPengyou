//
//  HPRegisterViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 4/5/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPRegisterViewController.h"
#import "HPFaceUploadViewController.h"
#import "UIView+Resize.h"
#import "NSString+Contains.h"

@interface HPRegisterViewController ()

@property (strong, nonatomic) UITextField *eee;

@end

@implementation HPRegisterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initTextField];
    [self initButton];

}

- (void)initView
{
    
    [self.view setBackgroundColor:[UIColor colorWithRed:49.0f / 255.0f
                                                  green:188.0f / 255.0f
                                                   blue:234.0f / 255.0f
                                                  alpha:1]];
}

- (void)initTextField
{
    self.usernameTextField = [[UITextField alloc]init];
    [self.usernameTextField setDelegate:self];
    [self.usernameTextField resetSize:CGSizeMake(240, 30)];
    [self.usernameTextField setCenter:CGPointMake([self.view getWidth]/2, 100)];
    [self.usernameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.usernameTextField setClearsOnBeginEditing:YES];
    [self.usernameTextField setReturnKeyType:UIReturnKeyNext];
    [self.usernameTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.usernameTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    self.usernameTextField.tag = 1;
    [self.usernameTextField setBackgroundColor:[UIColor whiteColor]];
    [self.usernameTextField setPlaceholder:@"My username"];
    [self.usernameTextField setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [self.view addSubview: self.usernameTextField];
    
    self.passwordTextField = [[UITextField alloc]init];
    [self.passwordTextField setDelegate:self];
    [self.passwordTextField resetSize:CGSizeMake(240, 30)];
    [self.passwordTextField setCenter:CGPointMake([self.view getWidth]/2, [self.usernameTextField getCenterY]+40)];
    [self.passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.passwordTextField setClearsOnBeginEditing:YES];
    [self.passwordTextField setReturnKeyType:UIReturnKeyNext];
    [self.passwordTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.passwordTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.passwordTextField setSecureTextEntry:YES];
    self.passwordTextField.tag = 1;
    [self.passwordTextField setBackgroundColor:[UIColor whiteColor]];
    [self.passwordTextField setPlaceholder:@"password"];
    [self.passwordTextField setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [self.view addSubview: self.passwordTextField];
    
    self.emailTextField = [[UITextField alloc]init];
    [self.emailTextField setDelegate:self];
    [self.emailTextField resetSize:CGSizeMake(240, 30)];
    [self.emailTextField setCenter:CGPointMake([self.view getWidth]/2, [self.passwordTextField getCenterY]+40)];
    [self.emailTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.emailTextField setClearsOnBeginEditing:YES];
    [self.emailTextField setReturnKeyType:UIReturnKeyNext];
    [self.emailTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.emailTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    self.emailTextField.tag = 1;
    [self.emailTextField setBackgroundColor:[UIColor whiteColor]];
    [self.emailTextField setPlaceholder:@"email (optional)"];
    [self.emailTextField setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [self.view addSubview: self.emailTextField];
}


- (void)initButton
{
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // Init register button
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerButton setTitle:@"register" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"HPLoginButton"] forState:(UIControlStateNormal)];
    
    [self.registerButton resetSize:CGSizeMake(211, 38)];
    [self.registerButton setCenter:CGPointMake([self.view getWidth]/2, [self.emailTextField getCenterY]+60)];
    [self.registerButton addTarget:self
                            action:@selector(didClickRegisterButton)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerButton];

    
    
    
    
}


#pragma mark - button event
- (void)didClickRegisterButton
{
    NSString *usernameText = self.usernameTextField.text;
    NSString *passwordText = self.passwordTextField.text;
    NSString *emailText = self.emailTextField.text;
    //
    if([usernameText length] < 4)
    {
        self.registerAlertView = [[UIAlertView alloc]initWithTitle:@"Sorry.." message:@"username should be no less than 4 characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.registerAlertView show];
    }
    else if([passwordText length ] < 6)
    {
        self.registerAlertView = [[UIAlertView alloc]initWithTitle:@"Sorry.." message:@"password should be no less than 6 characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.registerAlertView show];
    }
    else if([emailText length] > 0 && ((![emailText containsString:@"@"]) || (![emailText containsString:@"."])))
    {
        self.registerAlertView = [[UIAlertView alloc]initWithTitle:@"Sorry.." message:@"your email address seems to be invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.registerAlertView show];
    }
    else
    {
        [self registerRequest];
    }
    
}


- (void)registerRequest
{
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://timadidas.vicp.cc:15730/index/register"];
    
    NSString *usernameText = self.usernameTextField.text;
    NSString *passwordText = self.passwordTextField.text;
    NSString *emailText = self.emailTextField.text;
    
    NSData *postData = [[NSString stringWithFormat:@"name=%@&pass=%@&firstlanguage=%@&email=%@&",usernameText,passwordText,@"english",emailText] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
        
        
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //connection successed
        if([data length] > 0 && connectionError == nil)
        {
            NSError *e = nil;
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            
            
            //register successed
            if([[dataDict objectForKey:@"code"] isEqualToString:@"10000"])
            {
                NSDictionary *userDict = [[dataDict objectForKey:@"result"] objectForKey:@"user"];
                NSDictionary *registerData = @{
                                                         @"id":[userDict objectForKey:@"id"],
                                                         @"username":[userDict objectForKey:@"name"],
                                                         @"sid":[userDict objectForKey:@"sid"],
                                                         @"email":[userDict objectForKey:@"email"],
                                                         
                                                         };
                [self registerInfo:registerData];

                
                HPFaceUploadViewController *faceUploadViewController = [[HPFaceUploadViewController alloc] init];
                [self.navigationController pushViewController:faceUploadViewController animated:YES];
            }
            
            //reigister failed
            else if([[dataDict objectForKey:@"code"] isEqualToString:@"10029"])
            {
                NSLog(@"10029");
                self.registerAlertView = [[UIAlertView alloc]initWithTitle:@"Username already exists." message:@"you can try another name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [self.registerAlertView show];
            }
            else if([[dataDict objectForKey:@"code"] isEqualToString:@"10030"])
            {
                NSLog(@"10030");
                self.registerAlertView = [[UIAlertView alloc]initWithTitle:@"Email already exists." message:@"you can try another email." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [self.registerAlertView show];
            }
            
        }
            //connection failed
        else if (connectionError != nil)
        {
            self.registerAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"connection error." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.registerAlertView show];
            
        }
        //unknow error
        else
        {
            NSLog(@"%@",data);
            self.registerAlertView = [[UIAlertView alloc]  initWithTitle:@"Oops.." message:@"something wrong..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.registerAlertView show];
        }
            
            
    }];
    
    
}
    

    
    




- (void)registerInfo:(NSDictionary *)registerData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"isLoggedIn"];
    [userDefaults setObject:registerData[@"id"] forKey:@"id"];
    [userDefaults setObject:registerData[@"username"] forKey:@"username"];
    [userDefaults setObject:registerData[@"sid"] forKey:@"sid"];
    [userDefaults setObject:registerData[@"email"] forKey:@"email"];
}



@end
