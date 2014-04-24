//
//  HPSeekoutDetailViewController.m
//  HiPengyou
//
//  Created by Tom Hu on 4/6/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPSeekoutDetailViewController.h"
#import "UIView+Resize.h"
#import "HPSeekoutReplyTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface HPSeekoutDetailViewController ()

// Data
@property (strong, atomic) HPSeekout *seekoutData;

// UI
@property (strong, atomic) UIView *customNavBarView;

@property (strong, atomic) UIView *seekoutDetailView;
@property (strong, atomic) UIImageView *avatarImageView;
@property (strong, atomic) UILabel *seekoutAuthorNameLabel;

@property (strong, atomic) UITableView *seekoutReplyTableView;

@property (strong, atomic) UIView *seekoutReplyView;
@property (strong, atomic) UITextField *seekoutReplyTextField;

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
    [self initSeekoutReplyView];
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
    // init Seekout Detail View
    self.seekoutDetailView = [[UIView alloc] init];
    [self.seekoutDetailView resetSize:CGSizeMake(307, 203 / 2)];
    [self.seekoutDetailView setCenter:CGPointMake(320 / 2, 18 + [self.customNavBarView getCenterY] + ([self.customNavBarView getHeight] + [self.seekoutDetailView getHeight]) / 2)];
    [self.seekoutDetailView setBackgroundColor:[UIColor clearColor]];
    
    // Seekout Detail Content View
    UIView *seekoutDetailContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 45 / 2, 307, 79)];
    [seekoutDetailContentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"HPSeekoutDetailContentBoxBgImage"]]];
    
    // Seekout Detail Content Text
    
    
    // Author Avatar
//    self.avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar"]];
    self.avatarImageView = [[UIImageView alloc] init];
    [self.avatarImageView setImageWithURL:self.seekoutData.faceImageURL];
    [self.avatarImageView resetSize:CGSizeMake(134 / 2, 134 / 2)];
    [self.avatarImageView resetOrigin:CGPointMake(0, 0)];
    [self.avatarImageView.layer setCornerRadius:self.avatarImageView.frame.size.width / 2];
    
    // Author Name
    self.seekoutAuthorNameLabel = [[UILabel alloc] init];
    
    
    // Add to Seekout Detail View
    [self.seekoutDetailView addSubview:seekoutDetailContentView];
    [self.seekoutDetailView addSubview:self.avatarImageView];
    [self.seekoutDetailView addSubview:self.seekoutAuthorNameLabel];
    
    // Add to View
    [self.view addSubview:self.seekoutDetailView];
}

- (void)initSeekoutReplyTableView
{
    // init Seekout Reply Table View
    self.seekoutReplyTableView = [[UITableView alloc] initWithFrame:CGRectMake([self.seekoutDetailView getOriginX],
                                                                               [self.seekoutDetailView getOriginY] + [self.seekoutDetailView getHeight] + 35 / 2,
                                                                               [self.seekoutDetailView getWidth],
                                                                               [UIScreen mainScreen].bounds.size.height - 40 - [self.seekoutDetailView getOriginY] - [self.seekoutDetailView getHeight] - 35 / 2 - 8)
                                                              style:UITableViewStylePlain];
    
    // Set Delegate
    self.seekoutReplyTableView.delegate = self;
    self.seekoutReplyTableView.dataSource = self;
    
    // Add to View
    [self.view addSubview:self.seekoutReplyTableView];
}

- (void)initSeekoutReplyView
{
    // init Seekout Reply View
    self.seekoutReplyView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, [UIScreen mainScreen].bounds.size.width, 40)];
    self.seekoutDetailView.backgroundColor = [UIColor clearColor];
    
    // Seekout Reply View Bg Image View
    UIImageView *seekoutReplyBgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HPSeekoutReplyBgImage"]];
    [seekoutReplyBgImageView setFrame:self.seekoutReplyView.bounds];
    
    // Seekout Reply Text Field
    self.seekoutReplyTextField = [[UITextField alloc] initWithFrame:self.seekoutReplyView.bounds];
    
    
    // Add to Seekout Reply View
    [self.seekoutReplyView addSubview:seekoutReplyBgImageView];
    [self.seekoutReplyView addSubview:self.seekoutReplyTextField];
    
    // Add to View
    [self.view addSubview:self.seekoutReplyView];
}

#pragma mark - Button Event
- (void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Keyboard Dismiss
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.seekoutReplyTextField resignFirstResponder];
}

#pragma mark - UITableViewDelegate


// TODO - Add Data Source
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HPSeekoutReplyTableViewCell *cell = [[HPSeekoutReplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SeekoutReply"];
    
    
    return cell;
}

@end
