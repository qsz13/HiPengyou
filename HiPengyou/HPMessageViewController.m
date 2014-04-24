//
//  HPMessageViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/26/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPMessageViewController.h"
#import "UIView+Resize.h"

@interface HPMessageViewController ()

@property (strong, atomic) UIButton *backButton;

@end

@implementation HPMessageViewController



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
    
}



- (void)didClickBackButton
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
