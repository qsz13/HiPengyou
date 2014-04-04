//
//  HPSeekoutCreationViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/30/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPSeekoutCreationViewController.h"

@interface HPSeekoutCreationViewController ()

@property (strong, atomic) UIButton *backButton;

@end

@implementation HPSeekoutCreationViewController



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
    
    
    
}


@end
