//
//  HPLoginViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/26/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPLoginViewController.h"
#import "UIView+Resize.h"
#import "HPLoginType.h"
#import "HPAppDelegate.h"


@interface HPLoginViewController ()

@property (strong, atomic) UIImageView *logo;
@property (strong, atomic) UIView *loginFrame;
@property (strong, atomic) UITextField *usernameTextField;
@property (strong, atomic) UITextField *passwordTextField;
@property (strong, atomic) UIButton *loginButton;
@property (strong, atomic) UIButton *registerButton;
@property (strong, atomic) UIButton *qqLoginButton;
@property (strong, atomic) UIButton *fbLoginButton;
@property (strong, atomic) UILabel *socialAccountLabel;
@property (strong, atomic) UIAlertView *loginFailedAlertView;
@property (strong, atomic) UIView *socialLoginButtonView;
@property (strong, atomic) TencentOAuth *tencentOAuth;
@property (strong, atomic) NSArray *qqPermission;
@property BOOL keyboardOnScreen;

@end

@implementation HPLoginViewController

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initLogo];
    [self initLabel];
    [self initSocialLoginButton];
    [self initButton];
    [self initLoginFrame];
    [self initTencent];
}



#pragma mark - UI Method
-(void)initView
{
    [self.view setBackgroundColor:[UIColor colorWithRed:49.0f / 255.0f
                                                  green:188.0f / 255.0f
                                                   blue:234.0f / 255.0f
                                                  alpha:1]];
}

-(void)initLogo
{
    self.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [self.logo setFrame:CGRectMake(self.view.frame.size.width * 0.45 / 2,
                                   self.view.frame.size.height * 0.15,
                                   self.view.frame.size.width * 0.55,
                                   self.view.frame.size.height * 0.05)];
    [self.view addSubview: self.logo];
}

- (void)initLabel
{
    self.socialAccountLabel = [[UILabel alloc] init];
    
    // Autoresize
    [self.socialAccountLabel resetSize:CGSizeMake(200, 30)];
    self.socialAccountLabel.numberOfLines = 1;
    [self.socialAccountLabel setText:@"Login with social account"];
    [self.socialAccountLabel sizeToFit];
    
    // Set style
    [self.socialAccountLabel setFont:[UIFont systemFontOfSize:13]];
    [self.socialAccountLabel setTextColor:[UIColor whiteColor]];
    [self.socialAccountLabel setTextAlignment:NSTextAlignmentCenter];
    [self.socialAccountLabel setBackgroundColor:[UIColor clearColor]];
    
    // Reset origin
    if(([self.view getHeight] / [self.view getWidth]) < 1.6f)
    {
        [self.socialAccountLabel resetOrigin:CGPointMake(([self.view getWidth] - [self.socialAccountLabel getWidth]) / 2, [self.view getHeight] * 0.3-20)];
    }
    else
    {
        [self.socialAccountLabel resetOrigin:CGPointMake(([self.view getWidth] - [self.socialAccountLabel getWidth]) / 2, [self.view getHeight] * 0.3)];
    }

    
    // Add to subview
    [self.view addSubview: self.socialAccountLabel];
    
}

- (void)initSocialLoginButton
{
    self.socialLoginButtonView = [[UIView alloc] init];
    [self.socialLoginButtonView resetSize:CGSizeMake(65 * 2 + 25, 66)];
    [self.socialLoginButtonView resetCenter:CGPointMake([self.socialAccountLabel getCenterX], [self.socialAccountLabel getCenterY] + 66 / 2 + 15)];
    
    // Set button type
    self.qqLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fbLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Set social button background
    [self.qqLoginButton setBackgroundImage:[UIImage imageNamed:@"HPLoginQQButton"] forState:UIControlStateNormal];
    [self.fbLoginButton setBackgroundImage:[UIImage imageNamed:@"HPLoginFacebookButton"] forState:UIControlStateNormal];
    
    // Set social button frame
    [self.qqLoginButton setFrame:CGRectMake(0, 0, 65, 66)];
    [self.fbLoginButton setFrame:CGRectMake([self.qqLoginButton getOriginX] + [self.qqLoginButton getWidth] + 25, 0, 65, 66)];
    
    // Add target to button
    [self.qqLoginButton addTarget:self action:@selector(didClickQQLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.fbLoginButton addTarget:self action:@selector(didClickFBLoginButton) forControlEvents:UIControlEventTouchUpInside];
    
    // Add to social login button view
    [self.socialLoginButtonView addSubview:self.qqLoginButton];
    [self.socialLoginButtonView addSubview:self.fbLoginButton];
    
    // Add to subview
    [self.view addSubview:self.socialLoginButtonView];
}

- (void)initLoginFrame
{
    self.loginFrame = [[UIView alloc] init];
    
    // Get view that contains login button and register button
    UIView *buttonView = self.loginButton.superview;
    [self.loginFrame setFrame:CGRectMake([buttonView getCenterX] - 211 / 2, [buttonView getOriginY] - 110, 211, 110)];
    
    // Login frame background
    [self.loginFrame setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"HPLoginFrame"]]];
    
    // Username text field
    self.usernameTextField = [[UITextField alloc] init];
    [self.usernameTextField setDelegate:self];
    [self.usernameTextField setFrame:CGRectMake(self.loginFrame.frame.size.width * 0.05,
                                                self.loginFrame.frame.size.height * 0.11,
                                                self.loginFrame.frame.size.width * 0.9,
                                                self.loginFrame.frame.size.height * 0.26)];
    [self.usernameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.usernameTextField setClearsOnBeginEditing:YES];
    [self.usernameTextField setReturnKeyType:UIReturnKeyNext];
    [self.usernameTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.usernameTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    self.usernameTextField.tag = 1;
    
    // Username text field left margin
    UIView *leftPaddingUsername = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.usernameTextField.frame.size.width * 0.15, self.usernameTextField.frame.size.height)];
    self.usernameTextField.leftView = leftPaddingUsername;
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.usernameTextField setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"HPLoginUsernameTextField"]]];
    [self.usernameTextField setPlaceholder:@"My username"];
    [self.usernameTextField setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [self.loginFrame addSubview: self.usernameTextField];
    
    // Password text field
    self.passwordTextField = [[UITextField alloc] init];
    [self.passwordTextField setDelegate:self];
    [self.passwordTextField setFrame:CGRectMake(self.loginFrame.frame.size.width * 0.05,
                                                self.usernameTextField.frame.size.height + self.loginFrame.frame.size.height * 0.11 * 2,
                                                self.loginFrame.frame.size.width * 0.9,
                                                self.loginFrame.frame.size.height * 0.26)];
    [self.passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.passwordTextField setClearsOnBeginEditing:YES];
    [self.passwordTextField setReturnKeyType:UIReturnKeyGo];
    self.passwordTextField.tag = self.usernameTextField.tag + 1;

    // Password text field left margin
    UIView *leftPaddingPassword = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.usernameTextField.frame.size.width * 0.15, self.usernameTextField.frame.size.height)];
    self.passwordTextField.leftView = leftPaddingPassword;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.passwordTextField setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"HPLoginPasswordTextField"]]];
    [self.passwordTextField setSecureTextEntry:YES];
    [self.passwordTextField setPlaceholder:@"Password"];
    [self.passwordTextField setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [self.loginFrame addSubview: self.passwordTextField];
    
    // Add observer for keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)initButton
{
    // Init login button
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setTitle:@"Login with HiAccount" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"HPLoginButton"] forState:UIControlStateNormal];
    [self.loginButton setFrame:(CGRectMake(0, 0, 212, 38))];
    [self.loginButton addTarget:self
                         action:@selector(didClickLoginButton)
               forControlEvents:UIControlEventTouchUpInside];
    
    // Init register button
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerButton setTitle:@"I am new here" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"HPLoginButton"] forState:(UIControlStateNormal)];
    [self.registerButton setFrame:CGRectMake(self.loginButton.frame.origin.x, self.loginButton.frame.origin.y + self.loginButton.frame.size.height + 10, 212, 38)];
    [self.registerButton addTarget:self
                            action:@selector(didClickRegisterButton)
                  forControlEvents:UIControlEventTouchUpInside];
    
    // Add to button view
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 212) / 2, self.view.frame.size.height * 0.7, 212, 38 * 2 + 10)];
    [buttonView addSubview:self.loginButton];
    [buttonView addSubview:self.registerButton];
    
    // Add to view
    [self.view addSubview:buttonView];
}

#pragma mark - Button Action
- (void)didClickLoginButton
{
    if(![self.view.subviews containsObject:self.loginFrame])
    {
        // Get view that contains login button and register button
        UIView *buttonView = self.loginButton.superview;
        [self.loginFrame setFrame:CGRectMake([buttonView getCenterX] - 211 / 2, [buttonView getOriginY] - 110, 211, 110)];
        self.loginFrame.alpha = 0;
        
        [self.view addSubview: self.loginFrame];
        
        // Animation
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"LoginFrameFadeIn" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.loginFrame.alpha = 1;
        [UIView commitAnimations];
    }
    else
    {
        [self loginRequest];
    }
}

- (void)didClickRegisterButton
{
    
}

- (void)didClickQQLoginButton
{
    self.qqPermission = @[kOPEN_PERMISSION_GET_SIMPLE_USER_INFO];
    [self.tencentOAuth authorize:self.qqPermission inSafari:NO];
}

- (void)didClickFBLoginButton
{
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for basic_info permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             HPAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
         }];
    }

}


#pragma mark - Login

// init Tencent OAuth
- (void)initTencent
{
    NSString *appid = @"100529471";
    self.tencentOAuth = [[TencentOAuth alloc]initWithAppId:appid andDelegate:self];
}

//save login infomation to user default
- (void)saveLoginState:(LoginType)loginType userData:(id)userData OAuth:(id)OAuth
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"isLoggedIn"];
    NSString *username;
    if(loginType == hiAccount)
    {
        NSDictionary *hiAccountUserData = (NSDictionary *)userData;
        [userDefaults setObject:hiAccountUserData[@"id"] forKey:@"id"];
        [userDefaults setObject:hiAccountUserData[@"sid"] forKey:@"sid"];
        username = hiAccountUserData[@"username"];
    }
    else if(loginType == qq)
    {
        TencentOAuth *qqOAuth = (TencentOAuth*)OAuth;

        [userDefaults setObject:[qqOAuth accessToken] forKey:@"qqAccessToken"];
        [userDefaults setObject:[qqOAuth openId] forKey:@"qqOpenId"];
        [userDefaults setObject:[qqOAuth expirationDate] forKey:@"qqExpirationDate"];
        
        NSError *e = nil;
        NSData *qqUserData = [(NSString*)userData dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:qqUserData options:NSJSONReadingMutableContainers error:&e];
        username = [dataDict objectForKey:@"nickname"];

    }
    else if(loginType == facebook)
    {
        
    }
    
    [userDefaults setObject:username forKey:@"username"];
    
    [userDefaults synchronize];
    
}

//hi account login request
- (void)loginRequest
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://timadidas.vicp.cc:15730/index/login"];
    
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if([username isEqualToString:@""])
    {
        self.loginFailedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"please fill in you username." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.loginFailedAlertView show];
    }
    else if([password isEqualToString:@""])
    {
        self.loginFailedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"please fill in you password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.loginFailedAlertView show];

    }
    else if([password isEqualToString:@""] && [password isEqualToString:@""])
    {
        self.loginFailedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"please fill in you username and password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.loginFailedAlertView show];

    }
    else
    {
        NSData *postData = [[NSString stringWithFormat:@"name=%@&pass=%@",username,password] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
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
                NSDictionary *userDict = [[dataDict objectForKey:@"result"] objectForKey:@"user"];
                //login successed
                if([[dataDict objectForKey:@"code"] isEqualToString:@"10000"])
                {
                    NSDictionary *hiAccountLoginData = @{
                                                         @"id":[userDict objectForKey:@"id"],
                                                         @"sid":[userDict objectForKey:@"sid"],
                                                         @"username":[userDict objectForKey:@"name"],
                                                         };
                    [self saveLoginState:hiAccount userData:hiAccountLoginData OAuth:nil];
                    //dismiss login view
                    [[[UIApplication sharedApplication] delegate].window.rootViewController dismissViewControllerAnimated:YES completion:nil];
                }
                //login failed
                else if([[dataDict objectForKey:@"code"] isEqualToString:@"14011"])
                {
                    self.loginFailedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"seems like your username/password is incorrect." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [self.loginFailedAlertView show];
                }
            }
            //connection failed
            else if (connectionError != nil)
            {
                self.loginFailedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"connection error." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [self.loginFailedAlertView show];
                
            }
            //unknow error
            else
            {
                self.loginFailedAlertView = [[UIAlertView alloc]  initWithTitle:@"Oops.." message:@"something wrong..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [self.loginFailedAlertView show];
            }
            

        }];


    }
    
}


//qq did login
- (void)tencentDidLogin
{
    BOOL isOAuthOK = [self.tencentOAuth getUserInfo];
    if(isOAuthOK)
    {
        //waiting view
    }
    else
    {
        self.loginFailedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"authorization expired." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.loginFailedAlertView show];
    }

}

- (void) getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"%@",response.message);
    NSString *userData = response.message;
    if(response.retCode == 0)
    {
        [self saveLoginState:qq userData:userData OAuth:nil];
        [[[UIApplication sharedApplication] delegate].window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        self.loginFailedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"authorization failed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.loginFailedAlertView show];
    }
}

//qq did not login
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if(cancelled == YES)
    {
        self.loginFailedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"login failed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.loginFailedAlertView show];
    }
    else
    {
        self.loginFailedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"login cancelled." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.loginFailedAlertView show];
    }
    
}

//qq network error
- (void)tencentDidNotNetWork
{
    self.loginFailedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"connection error." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [self.loginFailedAlertView show];
}

#pragma mark - Keyboard Dismiss
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.keyboardOnScreen)
    {
        // Keyboard is on screen, will dismiss keyboard
        [self.passwordTextField resignFirstResponder];
        [self.usernameTextField resignFirstResponder];
    }
    else
    {
        if ([self.view.subviews containsObject:self.loginFrame])
        {
            // Login frame on screen, will dismiss login frame
            // Animation
            NSTimeInterval animationDuration = 0.30f;
            [UIView beginAnimations:@"LoginFrameFadeOut" context:nil];
            [UIView setAnimationDuration:animationDuration];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(removeLoginFrameFromSuperview)];
            self.loginFrame.alpha = 0;
            [UIView commitAnimations];
            
            // Clean text field
            [self.usernameTextField setText:@""];
            [self.passwordTextField setText:@""];
            
        }
    }
}

- (void)removeLoginFrameFromSuperview
{
    [self.loginFrame removeFromSuperview];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    self.keyboardOnScreen = YES;
    
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat targetY = [self.view getHeight] - keyboardFrame.size.height - [self.registerButton getOriginY];
    
    UIView *buttonView = self.loginButton.superview;
    
    // Animation
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [buttonView resetOriginY:targetY];
    [self.loginFrame resetOriginY:targetY - [self.loginFrame getHeight]];
    self.socialAccountLabel.alpha = 0;
    self.socialLoginButtonView.alpha = 0;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.keyboardOnScreen = NO;
    
    UIView *buttonView = self.loginButton.superview;
    
    // Animation
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [buttonView resetOriginY:[self.view getHeight] * 0.7];
    [self.loginFrame resetOriginY:[buttonView getOriginY] - [self.loginFrame getHeight]];
    self.socialAccountLabel.alpha = 1;
    self.socialLoginButtonView.alpha = 1;
    [UIView commitAnimations];
}

#pragma mark - UITextField Delegate
 - (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [self loginRequest];
    }
    [textField resignFirstResponder];
    return NO;
}









//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
