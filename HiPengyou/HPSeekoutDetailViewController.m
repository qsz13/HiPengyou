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
@property (strong, atomic) UILabel *seekoutContentLabel;
@property (strong, atomic) UIImageView *faceImageView;
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
    self.customNavBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 60)];
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

    [self.seekoutDetailView setFrame:CGRectMake(0, [self.customNavBarView getHeight], [self.view getWidth], [self.view getHeight]*2/5)];
    [self.seekoutDetailView setBackgroundColor:[UIColor whiteColor]];
    


    
    
    // Author face
    self.faceImageView = [[UIImageView alloc] init];
    [self.faceImageView setImageWithURL:self.seekoutData.faceImageURL];
    [self.faceImageView resetSize:CGSizeMake(100 / 2, 100 / 2)];
    [self.faceImageView resetOrigin:CGPointMake(10, [self.seekoutDetailView getHeight] - [self.faceImageView getHeight] - 10)];
    
    //make the face image to be circle
    [self.faceImageView.layer setMasksToBounds:YES];
    [self.faceImageView.layer setCornerRadius:self.faceImageView.frame.size.width / 2];
    
    
    // Author Name
    self.seekoutAuthorNameLabel = [[UILabel alloc] init];
    [self.seekoutAuthorNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.seekoutAuthorNameLabel setTextColor:[UIColor
                                               colorWithRed:171.0f/255.0f
                                               green:104.0f/255.0f
                                               blue:102.0f/255.0f
                                               alpha:1]];
    
    

    [self.seekoutAuthorNameLabel resetSize:CGSizeMake(500, 30)];
    [self.seekoutAuthorNameLabel setText:self.seekoutData.author];
    self.seekoutAuthorNameLabel.numberOfLines = 0;

    [self.seekoutAuthorNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    [self.seekoutAuthorNameLabel sizeToFit];
    [self.seekoutAuthorNameLabel resetOrigin:CGPointMake([self.faceImageView getOriginX]+[self.faceImageView getWidth]+5,[self.faceImageView getOriginY]+10)];
    [self.seekoutDetailView addSubview:self.seekoutAuthorNameLabel];

    
    // Seekout Detail Content Label
    
    self.seekoutContentLabel = [[UILabel alloc] init];
    [self.seekoutContentLabel setBackgroundColor:[UIColor clearColor]];
    [self.seekoutContentLabel resetSize:CGSizeMake([self.seekoutDetailView getWidth]-2*10, [self.seekoutDetailView getHeight])];
    self.seekoutContentLabel.numberOfLines = 4;
    [self.seekoutContentLabel setText:self.seekoutData.content];
    
    [self.seekoutContentLabel setTextColor:[UIColor colorWithRed:144.0f/255.0f green:150.0f/255.0f blue:157.0f/255.0f alpha:1]];
    [self.seekoutContentLabel setFont:[UIFont systemFontOfSize:18]];
    [self.seekoutContentLabel sizeToFit];
    [self.seekoutContentLabel setCenter:CGPointMake([self.seekoutDetailView getWidth]/2, [self.faceImageView getOriginY]/2)];
    [self.seekoutDetailView addSubview:self.seekoutContentLabel];
    
    
    
    // Add to Seekout Detail View
    [self.seekoutDetailView addSubview:self.faceImageView];
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
    
    [self.seekoutReplyTableView setSeparatorInset:UIEdgeInsetsZero];

    
    // Add to View
    [self.view addSubview:self.seekoutReplyTableView];
}

- (void)initSeekoutReplyView
{
    // init Seekout Reply View
    self.seekoutReplyView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, [UIScreen mainScreen].bounds.size.width, 40)];
    
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
