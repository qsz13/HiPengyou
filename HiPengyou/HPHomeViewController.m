//
//  HPHomeViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/30/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPHomeViewController.h"
#import "HPMessageViewController.h"
#import "HPProfileViewController.h"
#import "HPSeekoutCardViewController.h"
#import "UIView+Resize.h"
@interface HPHomeViewController ()

@property (strong, atomic) UILabel *greetingLabel;
@property (strong, atomic) NSString *username;
@property (strong, atomic) UIButton *messageButton;
@property (strong, atomic) UIButton *profileButton;
@property (strong, atomic) HPMessageViewController *messageViewController;
@property (strong, atomic) HPProfileViewController *profileViewController;
@property (strong, atomic) HPSeekoutCardViewController *seekoutCardViewController;
@property (strong, atomic) UIButton *addSeekoutButon;
@property (strong, atomic) UIPageViewController *pageViewController;

@end


@implementation HPHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self initNaviBar];
    [self initLabel];
    [self initButton];
    
    
}

- (void)initData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.username = [userDefaults objectForKey:@"username"];
    
}

- (void)initView
{
    [self.view setBackgroundColor:[UIColor colorWithRed:240.0f / 255.0f
                                                  green:240.0f / 255.0f
                                                   blue:235.0f / 255.0f
                                                  alpha:1]];
    [self initSeekoutPageViewController];
    [self initSeekoutCardViewController];
}

- (void)initSeekoutPageViewController
{
    self.pageViewController = [[UIPageViewController alloc] init];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
}
- (void)initSeekoutCardViewController
{
    
}

- (void)initNaviBar
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)initLabel
{
    self.greetingLabel = [[UILabel alloc] init];
    
    // Autoresize
    [self.greetingLabel resetSize:CGSizeMake(200, 30)];
    self.greetingLabel.numberOfLines = 1;
    [self.greetingLabel setText: [NSString stringWithFormat:@"Hi,%@", self.username]];
    [self.greetingLabel sizeToFit];
    
    // Set style
    [self.greetingLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
    [self.greetingLabel setTextColor:[UIColor colorWithRed:148.0f / 255.0f
                                                     green:148.0f / 255.0f
                                                      blue:148.0f / 255.0f
                                                     alpha:1]];
    [self.greetingLabel setTextAlignment:NSTextAlignmentCenter];
    [self.greetingLabel setBackgroundColor:[UIColor clearColor]];
    
    //set position
    [self.greetingLabel resetOrigin:CGPointMake(10, 34)];
    
    //add subview
    [self.view addSubview:self.greetingLabel];
   
    
}

- (void)initButton
{
    self.messageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.messageButton setTitle:@"message" forState:UIControlStateNormal];
    [self.messageButton setFrame: CGRectMake([self.view getWidth]-140, 34, 70, 30)];
    [self.messageButton addTarget:self action:@selector(didClickMessageButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.messageButton];

    
    self.profileButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.profileButton setTitle:@"profile" forState:UIControlStateNormal];
    [self.profileButton setFrame: CGRectMake([self.view getWidth]-70, 34, 70, 30)];
    [self.profileButton addTarget:self action:@selector(didClickProfileButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.profileButton];
    
    self.addSeekoutButon = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.addSeekoutButon setTitle:@"add" forState:UIControlStateNormal];
    [self.addSeekoutButon setFrame: CGRectMake(160, 400, 30, 30)];
    [self.view addSubview:self.addSeekoutButon];
    
    [self.view addSubview: self.addSeekoutButon];
}

- (void)didClickMessageButton
{
    self.messageViewController = [[HPMessageViewController alloc] init];

    [self.navigationController pushViewController:self.messageViewController animated:YES];
}

- (void)didClickProfileButton
{
    self.profileViewController = [[HPProfileViewController alloc] init];

    [self.navigationController pushViewController:self.profileViewController animated:YES];
}


//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
//{
//    
//}
//
//
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
//{
//    
//}

@end