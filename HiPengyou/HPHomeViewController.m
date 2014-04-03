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
#import "HPSeekoutCardView.h"
#import "UIView+Resize.h"
@interface HPHomeViewController ()


@property (strong, atomic) NSString *username;
@property (strong, atomic) UIButton *categoryButton;
@property (strong, atomic) UIButton *messageButton;
@property (strong, atomic) UIButton *profileButton;
@property (strong, atomic) UIButton *addSeekoutButton;
@property (strong, atomic) HPMessageViewController *messageViewController;
@property (strong, atomic) HPProfileViewController *profileViewController;
@property (strong, atomic) UIScrollView *seekoutScrollView;
@property (strong, atomic) NSMutableArray *seekoutCardsArray;
@property (strong, atomic) UIImageView *test;
@property (strong, atomic) UIImageView *test2;

@end


@implementation HPHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self initNaviBar];
    [self initSeekoutScrollView];
    [self initSeekoutCards];
    [self initButton];
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

    if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self initSeekoutCardViewController];
    
    
}


- (void)initSeekoutCardViewController
{
    
}

- (void)initNaviBar
{
    self.navigationController.navigationBarHidden = YES;
}



- (void)initButton
{
    self.categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.categoryButton setImage:[UIImage imageNamed:@"HPCategoriesButton"] forState:UIControlStateNormal];
    [self.categoryButton setFrame:CGRectMake(7, 28, 31, 31)];
    [self.view addSubview:self.categoryButton];
    
    self.messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.messageButton setImage:[UIImage imageNamed:@"HPMessageButton"] forState:UIControlStateNormal];
    [self.messageButton setFrame: CGRectMake(470/2, 28, 31, 31)];
    [self.messageButton addTarget:self action:@selector(didClickMessageButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.messageButton];
    
    self.profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.profileButton setImage:[UIImage imageNamed:@"HPProfileButton"] forState:UIControlStateNormal];
    [self.profileButton setFrame: CGRectMake(553/2, 28, 32, 32)];
    [self.profileButton addTarget:self action:@selector(didClickProfileButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.profileButton];
    
    self.addSeekoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addSeekoutButton setImage:[UIImage imageNamed:@"HPAddSeekoutButton"] forState:UIControlStateNormal];

    [self.addSeekoutButton setFrame: CGRectMake(([self.view getWidth]-43)/2, [self.seekoutScrollView getOriginY]+[self.seekoutScrollView getHeight]+25, 43, 43)];
    NSLog(@"%f",[self.seekoutScrollView getOriginY]+[self.seekoutScrollView getHeight]);
    [self.view addSubview:self.addSeekoutButton];
}


- (void)initSeekoutScrollView
{

    [self.seekoutScrollView setBounces:NO];
    self.seekoutScrollView = [[UIScrollView alloc] init];

    [self.seekoutScrollView setFrame:CGRectMake(0,168/2, [self.view getWidth],[self.view getHeight]-168)];

    

    
    [self.seekoutScrollView setContentSize:CGSizeMake(600, [self.seekoutScrollView getHeight])];
    [self.seekoutScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.seekoutScrollView];

}

- (void)initSeekoutCards
{
    self.seekoutCardsArray = [[NSMutableArray alloc]init];
    HPSeekoutCardView *seekoutCardView = [[HPSeekoutCardView alloc] initWithFrame:CGRectMake(48/2+16/2, 0, 512/2, [self.seekoutScrollView getHeight])];
    [self.seekoutScrollView addSubview:seekoutCardView];
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


@end