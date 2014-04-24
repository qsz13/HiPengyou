//
//  HPProfileViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/26/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPProfileViewController.h"
#import "HPProfileSettingViewController.h"
#import "UIView+Resize.h"

@interface HPProfileViewController ()
@property (strong, atomic) UIButton *backButton;
@property (strong, atomic) UIButton *settingButton;
@property (strong, atomic) UILabel *usernameLabel;
@property (strong, atomic) NSString *username;
@property (strong, atomic) UIImageView *faceImageView;
@property (strong, atomic) UIImageView *faceBackgroundImageView;
@end

@implementation HPProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self initNaviBar];
    [self initFace];

}
- (void)initData
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.username = [userDefaults objectForKey:@"username"];

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
    
    self.usernameLabel = [[UILabel alloc]init];
    [self.usernameLabel resetSize:CGSizeMake(500, 30)];
    [self.usernameLabel setText:self.username];
    self.usernameLabel.numberOfLines = 1;
    [self.usernameLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                     green:188.0f / 255.0f
                                                      blue:235.0f / 255.0f
                                                     alpha:1]];
    [self.usernameLabel setBackgroundColor:[UIColor clearColor]];
    [self.usernameLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [self.usernameLabel sizeToFit];
    [self.usernameLabel setCenter:CGPointMake([self.view getWidth]/2, 87.5/2)];
    [self.view addSubview:self.usernameLabel];
    
    self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.settingButton setImage:[UIImage imageNamed:@"HPProfileSettingButton"] forState:UIControlStateNormal];
    [self.settingButton resetSize:CGSizeMake(31, 31)];
    [self.settingButton setCenter:CGPointMake(584/2+[self.settingButton getWidth]/2, 87.5/2)];
    [self.settingButton addTarget:self action:@selector(didClickSettingButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.settingButton];
    
}

- (void)initFace
{
    self.faceImageView = [[UIImageView alloc]init];
    [self.faceImageView setImage:[UIImage imageNamed:@"HPProfilePageTestAvatar"]];
    [self.faceImageView resetSize:CGSizeMake(98, 99)];
    [self.faceImageView setCenter:CGPointMake([self.view getWidth]/2, 157/2+[self.faceImageView getHeight]/2)];
    [self.view addSubview:self.faceImageView];
    

}




#pragma mark - button event

- (void)didClickBackButton
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didClickSettingButton
{
    HPProfileSettingViewController *settingViewController = [[HPProfileSettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:YES];
    
    
}


@end
