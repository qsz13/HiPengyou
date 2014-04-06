//
//  HPSeekoutCreationViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/30/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPSeekoutCreationViewController.h"
#import "UIView+Resize.h"

@interface HPSeekoutCreationViewController ()

@property (strong, atomic) UIButton *backButton;
@property (strong, atomic) UILabel *titleButton;
@property (strong, atomic) UITextView *seekoutDetailTextView;
@property (strong, atomic) UIButton *seekoutTypeButton;
@property (strong, atomic) UIButton *seekoutLanguageButton;
@property (strong, atomic) UIButton *seekoutLocationButton;
@property (strong, atomic) UIImageView *seekoutTypeIcon;
@property (strong, atomic) UIImageView *seekoutLanguageIcon;
@property (strong, atomic) UIImageView *seekoutLocationIcon;
@property (strong, atomic) UIButton *seekoutPostButton;

@end

@implementation HPSeekoutCreationViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initNaviBar];
    [self initTextView];
    [self initButton];
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
    
    self.seekoutPostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.seekoutPostButton setBackgroundImage:[UIImage imageNamed:@"HPSeekoutPostButton"] forState:UIControlStateNormal];
    [self.seekoutPostButton resetSize:CGSizeMake(53, 23)];
    [self.seekoutPostButton setCenter:CGPointMake(514/2+[self.seekoutPostButton getWidth]/2, 87.5/2)];
    [self.view addSubview:self.seekoutPostButton];
    
}

- (void)initTextView
{
    self.seekoutDetailTextView = [[UITextView alloc]init];

    [self.seekoutDetailTextView resetSize:CGSizeMake(300, [self.view getHeight]*0.3)];
    [self.seekoutDetailTextView setCenter:CGPointMake([self.view getWidth]/2, 150/2+[self.seekoutDetailTextView getHeight]/2)];
    
    [self.view addSubview:self.seekoutDetailTextView];
    
    
}

- (void)initButton
{
    
    self.seekoutTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.seekoutTypeButton setBackgroundImage:[UIImage imageNamed:@"HPSeekoutInfoButtonBgImage"] forState:UIControlStateNormal];
    [self.seekoutTypeButton resetSize:CGSizeMake(300, 42)];
    [self.seekoutTypeButton setCenter:CGPointMake([self.view getWidth]/2, [self.seekoutDetailTextView getOriginY] + [self.seekoutDetailTextView getHeight] + 13/2 + [self.seekoutTypeButton getHeight]/2)];
    
    self.seekoutTypeIcon = [[UIImageView alloc]init];
    [self.seekoutTypeIcon setImage:[UIImage imageNamed:@"HPSeekoutInfoCategoriesButtonIcon"]];
    [self.seekoutTypeIcon resetSize:CGSizeMake(24, 24)];
    [self.seekoutTypeIcon setCenter:CGPointMake([self.seekoutTypeButton getHeight]/2, [self.seekoutTypeButton getHeight]/2)];
    
    [self.seekoutTypeButton addSubview:self.seekoutTypeIcon];
    [self.view addSubview:self.seekoutTypeButton];
    
    
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
   
    [self.seekoutDetailTextView resignFirstResponder];

}

#pragma mark - button event
- (void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
