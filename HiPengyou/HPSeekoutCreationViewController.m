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
@property (strong, atomic) UITextView *seekoutDetailTextView;
@property (strong, atomic) UIButton *seekoutTypeButton;
@property (strong, atomic) UIButton *seekoutLanguageButton;
@property (strong, atomic) UIButton *seekoutLocationButton;
@property (strong, atomic) UIImageView *seekoutTypeIcon;
@property (strong, atomic) UIImageView *seekoutLanguageIcon;
@property (strong, atomic) UIImageView *seekoutLocationIcon;

@end

@implementation HPSeekoutCreationViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initNaviBar];
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
    
    
    
}

- (void)initButton
{
    
    self.seekoutTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.seekoutTypeButton setBackgroundImage:[UIImage imageNamed:@"HPSeekoutInfoButtonBgImage"] forState:UIControlStateNormal];
    [self.seekoutTypeButton resetSize:CGSizeMake(300, 42)];
    [self.seekoutTypeIcon setCenter:CGPointMake(CGFloat x, <#CGFloat y#>)];
    
    self.seekoutTypeIcon = [[UIImageView alloc]init];
    [self.seekoutTypeIcon setImage:[UIImage imageNamed:@"HPSeekoutInfoCategoriesButtonIcon"]];
    [self.seekoutTypeIcon resetSize:CGSizeMake(24, 24)];
    [self.seekoutTypeIcon setCenter:CGPointMake(<#CGFloat x#>, <#CGFloat y#>)];
    
    
    
}


@end
