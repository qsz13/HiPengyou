//
//  HPLoginViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/26/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPLoginViewController.h"
#import "UIView+Resize.h"

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
}

#pragma mark - UI Method
-(void)initView
{
//    [self.view setBackgroundColor:[UIColor colorWithRed:49.0f / 225.0f
//                                                  green:188.0f / 255.0f
//                                                   blue:234.0f / 255.0f
//                                                  alpha:1]];
    [self.view setBackgroundColor:[UIColor clearColor]];
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
    // CGSize size = CGSizeMake(200, 50);
    self.socialAccountLabel = [[UILabel alloc] init];
    [self.socialAccountLabel setFrame:CGRectMake(0, self.view.frame.size.height * 0.3, 200, 30)];
    [self.socialAccountLabel setFont:[UIFont systemFontOfSize:13]];
    [self.socialAccountLabel setText:@"Login with social account"];
    
    self.socialAccountLabel.numberOfLines = 0;
    [self.socialAccountLabel sizeToFit];
    [self.socialAccountLabel setFrame:CGRectMake((self.view.frame.size.width - self.socialAccountLabel.frame.size.width) / 2, self.view.frame.size.height * 0.3, 200, 30)];
    [self.socialAccountLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview: self.socialAccountLabel];
    
}

- (void)initSocialLoginButton
{
    self.qqLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fbLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Set social button background
    [self.qqLoginButton setBackgroundImage:[UIImage imageNamed:@"HPLoginQQButton"] forState:UIControlStateNormal];
    [self.fbLoginButton setBackgroundImage:[UIImage imageNamed:@"HPLoginFacebookButton"] forState:UIControlStateNormal];
    
    // Set social button frame
    [self.qqLoginButton setFrame:CGRectMake(self.socialAccountLabel.frame.origin.x - 40, self.socialAccountLabel.frame.origin.y + 50, 65, 66)];
    [self.fbLoginButton setFrame:CGRectMake(self.socialAccountLabel.frame.origin.x + 40, self.socialAccountLabel.frame.origin.y + 50, 65, 66)];
    
    // Add to subviews
    [self.view addSubview:self.qqLoginButton];
    [self.view addSubview:self.fbLoginButton];
}

- (void)initLoginFrame
{
    self.loginFrame = [[UIView alloc] init];
//    [self.loginFrame setFrame:CGRectMake(self.view.frame.size.width * 0.35 / 2, self.view.frame.size.height * 0.5, 211, 110)];
    
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
    [self.usernameTextField setClearButtonMode:UITextFieldViewModeAlways];
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
    [self.passwordTextField setClearButtonMode:UITextFieldViewModeAlways];
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
    
    // add observer for keyboard
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
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"HPRegisterButton"] forState:(UIControlStateNormal)];
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
        
        [self.view addSubview: self.loginFrame];
    }
    else
    {
        [self loginRequest];
    }
}

- (void)didClickRegisterButton
{
    
}

#pragma mark - Login
- (void)loginRequest
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://quickycard.com:8001/index/login"];
    
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    NSData *postData = [[NSString stringWithFormat:@"name=%@&pass=%@",username,password] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError *e = nil;
    
    NSDictionary *d =  [NSJSONSerialization JSONObjectWithData: received options: NSJSONReadingMutableContainers error: &e];
    
    NSLog(@"%@",d);
    
    if ([[d objectForKey:@"code"] isEqualToString:@"10000"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Keyboard Dismiss
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.keyboardOnScreen)
    {
        [self.passwordTextField resignFirstResponder];
        [self.usernameTextField resignFirstResponder];
    }
    else
    {
        if ([self.view.subviews containsObject:self.loginFrame])
        {
            [self.loginFrame removeFromSuperview];
            
        }
    }
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



//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    float height = 216.0;
//    CGRect frame = self.view.frame;
//    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
//    [UIView beginAnimations:@"Curl"context:nil];//动画开始
//    [UIView setAnimationDuration:0.30];
//    [UIView setAnimationDelegate:self];
//    [self.view setFrame:frame];
//    [UIView commitAnimations];
//    return YES;
//}









//
//-(void)selector:(id)sender
//{
//    [[[UIApplication sharedApplication] delegate].window.rootViewController dismissViewControllerAnimated:YES completion:nil];
//}
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
