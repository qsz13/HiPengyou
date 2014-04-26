//
//  HPProfileSettingViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 4/5/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPProfileSettingViewController.h"
#import "UIView+Resize.h"

@interface HPProfileSettingViewController ()

@property (strong, atomic) UIButton *backButton;
@property (strong, atomic) UILabel *settingTitleLabel;


@end

@implementation HPProfileSettingViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initNaviBar];
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
//
//    self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.settingButton setImage:[UIImage imageNamed:@"HPProfileSettingButton"] forState:UIControlStateNormal];
//    [self.settingButton resetSize:CGSizeMake(31, 31)];
//    [self.settingButton setCenter:CGPointMake(584/2+[self.settingButton getWidth]/2, 87.5/2)];
//    [self.settingButton addTarget:self action:@selector(didClickSettingButton) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.settingButton];
    
}


#pragma mark - button event


- (void)didClickBackButton
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
