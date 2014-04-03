//
//  HPProfileViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/26/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPProfileViewController.h"

@interface HPProfileViewController ()
@property (strong, atomic) UIButton *backButton;
@end

@implementation HPProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initButton];
    

}

- (void)initView
{
    [self.view setBackgroundColor:[UIColor colorWithRed:240.0f / 255.0f
                                                  green:240.0f / 255.0f
                                                   blue:235.0f / 255.0f
                                                  alpha:1]];

}

- (void)initButton
{
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.backButton setFrame:CGRectMake( 20, 34 , 50, 30)];
    [self.backButton setTitle:@"back" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(didClickBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
}

- (void)didClickBackButton
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
