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
        
        // UI Mehtods
        [self initCustomNavBar];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI init
- (void)initCustomNavBar
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"HPBackButton"] forState:UIControlStateNormal];
    [backButton resetSize:CGSizeMake(20, 20)];
    [backButton setCenter:CGPointMake(19/2+10, 43)];
    [backButton addTarget:self action:@selector(didClickBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

#pragma mark - Button Event
- (void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
