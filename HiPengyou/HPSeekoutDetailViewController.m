//
//  HPSeekoutDetailViewController.m
//  HiPengyou
//
//  Created by Tom Hu on 4/6/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPSeekoutDetailViewController.h"
#import "UIView+Resize.h"

@interface HPSeekoutDetailViewController ()

@property (strong, atomic) HPSeekout *seekoutData;
@property (strong, atomic) UIView *customNavBarView;
@property (strong, atomic) UIView *seekoutDetailView;

@end

@implementation HPSeekoutDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithSeekoutData:(HPSeekout *)seekoutData
{
    self = [super init];
    if (self) {
        self.seekoutData = seekoutData;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // UI Mehtods
    [self initView];
    [self initCustomNavBar];
    [self initSeekoutDetailView];
    [self initSeekoutReplyTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI init
- (void)initView
{
    [self.view setBackgroundColor:[UIColor colorWithRed:230.0f / 255.0f
                                                  green:230.0f / 255.0f
                                                   blue:230.0f / 255.0f
                                                  alpha:1]];
}

- (void)initCustomNavBar
{
    self.customNavBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 40)];
    [self.customNavBarView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"HPBackButton"] forState:UIControlStateNormal];
    [backButton resetSize:CGSizeMake(20, 20)];
    [backButton setCenter:CGPointMake(19 / 2 + 10, 20)];
    [backButton addTarget:self action:@selector(didClickBackButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.customNavBarView addSubview:backButton];
    
    [self.view addSubview:self.customNavBarView];
}

- (void)initSeekoutDetailView
{
    self.seekoutDetailView = [[UIView alloc] init];
    [self.seekoutDetailView resetSize:CGSizeMake(307, 203 / 2)];
    [self.seekoutDetailView setCenter:CGPointMake(320 / 2, 36 + [self.customNavBarView getCenterY] + [self.seekoutDetailView getHeight])];
    [self.seekoutDetailView setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar"]];
    [avatarImageView resetSize:CGSizeMake(134 / 2, 134 / 2)];
    [avatarImageView resetOrigin:CGPointMake(0, 0)];
    [self.seekoutDetailView addSubview:avatarImageView];
    
    UIView *seekoutDetailContentBox = [[UIView alloc] initWithFrame:CGRectMake(0, 45 / 2, 307, 79)];
    [seekoutDetailContentBox setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"HPSeekoutDetailContentBoxBgImage"]]];
    [self.seekoutDetailView addSubview:seekoutDetailContentBox];
}

- (void)initSeekoutReplyTableView
{
    
}

#pragma mark - Button Event
- (void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
