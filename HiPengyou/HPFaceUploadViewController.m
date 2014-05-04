//
//  HPFaceUploadViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 4/6/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPFaceUploadViewController.h"
#import "HPHomeViewController.h"
#import "UIView+Resize.h"

@interface HPFaceUploadViewController ()

@property (strong, nonatomic) UIButton *skipButton;

@end

@implementation HPFaceUploadViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initButton];
}


- (void)initView
{
    [self.view setBackgroundColor:[UIColor colorWithRed:49.0f / 255.0f
                                                  green:188.0f / 255.0f
                                                   blue:234.0f / 255.0f
                                                  alpha:1]];
}

- (void)initButton
{
    self.skipButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.skipButton setTitle:@"skip...TO BE DONE" forState:UIControlStateNormal];
    [self.skipButton setFrame:CGRectMake([self.view getWidth]/2, [self.view getHeight]/2, 300, 50)];
    [self.skipButton addTarget:self action:@selector(didClickSkipButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.skipButton];
}




#pragma mark - button event
- (void)didClickSkipButton
{
    //NOT GOOD TO BE DONE
    [self.navigationController pushViewController:[[HPHomeViewController alloc]init] animated:YES];
}


@end
