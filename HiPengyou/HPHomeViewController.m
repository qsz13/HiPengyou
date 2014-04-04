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
#import "HPSeekoutCreationViewController.h"
#import "HPSeekoutCardView.h"
#import "UIView+Resize.h"
@interface HPHomeViewController ()


@property (strong, atomic) NSString *sid;
@property (strong, atomic) UIButton *categoryButton;
@property (strong, atomic) UIButton *messageButton;
@property (strong, atomic) UIButton *profileButton;
@property (strong, atomic) UIButton *addSeekoutButton;
@property (strong, atomic) HPMessageViewController *messageViewController;
@property (strong, atomic) HPProfileViewController *profileViewController;
@property (strong, atomic) HPSeekoutCreationViewController *seekoutCreationViewController;
@property (strong, atomic) UIScrollView *seekoutScrollView;
@property (strong, atomic) NSMutableArray *seekoutCardsArray;
@property (strong, atomic) UIAlertView *connectionFaiedAlertView;

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
    self.sid = [userDefaults objectForKey:@"sid"];
    NSLog(@"%@", self.sid);
    
}


#pragma mark - UI init
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
    [self.addSeekoutButton addTarget:self action:@selector(didClickAddSeekoutButton) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.addSeekoutButton];
}


- (void)initSeekoutScrollView
{

    [self.seekoutScrollView setBounces:NO];
    self.seekoutScrollView = [[UIScrollView alloc] init];

    [self.seekoutScrollView setFrame:CGRectMake(0,168/2, [self.view getWidth],[self.view getHeight]-168)];

    

    
    [self.seekoutScrollView setContentSize:CGSizeMake([self.seekoutScrollView getWidth], [self.seekoutScrollView getHeight])];
    [self.seekoutScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.seekoutScrollView];
    
}

- (void)initSeekoutCards
{
    self.seekoutCardsArray = [[NSMutableArray alloc]init];
    for(int i = 0 ; i < 3; i++)
    {
        [self addSeekoutCard];
    }
}

#pragma mark - button event

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

- (void)didClickAddSeekoutButton
{
    self.seekoutCreationViewController = [[HPSeekoutCreationViewController alloc] init];
    [self.navigationController pushViewController:self.seekoutCreationViewController animated:YES];
}


#pragma mark - request
- (void)requestForNewSeekout
{
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://timadidas.vicp.cc:15730/seekout/seekoutList?sid=%@", self.sid]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    


    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //connection successed
        if([data length] > 0 && connectionError == nil)
        {
            NSError *e = nil;
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            NSDictionary *userDict = [[dataDict objectForKey:@"result"] objectForKey:@"user"];
            //login successed
            if([[dataDict objectForKey:@"code"] isEqualToString:@"10000"])
            {
                
            }
            //login failed
            else if([[dataDict objectForKey:@"code"] isEqualToString:@"14011"])
            {
                //no more new seekout
            }
        }
        //connection failed
        else if (connectionError != nil)
        {
            self.connectionFaiedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"connection error." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.connectionFaiedAlertView show];
            
        }
        //unknow error
        else
        {
            self.connectionFaiedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"something wrong..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.connectionFaiedAlertView show];
        }
        
        
    }];
    
    //callback
}


#pragma mark - add card
- (void)addSeekoutCard
{
    if([self.seekoutCardsArray count])
    {
        HPSeekoutCardView *lastSeekoutCardView = [self.seekoutCardsArray lastObject];
        HPSeekoutCardView *newSeekoutCardView = [[HPSeekoutCardView alloc] initWithFrame:CGRectMake([lastSeekoutCardView getOriginX] + [lastSeekoutCardView getWidth] + 10, 0, 512/2, [self.seekoutScrollView getHeight])];
        
        [self.seekoutCardsArray addObject:newSeekoutCardView];
        [self.seekoutScrollView setContentSize:CGSizeMake(self.seekoutScrollView.contentSize.width + [newSeekoutCardView getWidth] + 10, [self.seekoutScrollView getHeight])];
        NSLog(@"%f",[self.seekoutScrollView getWidth]);
        [self.seekoutScrollView addSubview:newSeekoutCardView];
    }
    else
    {
        HPSeekoutCardView *seekoutCardView = [[HPSeekoutCardView alloc] initWithFrame:CGRectMake(48/2+16/2, 0, 512/2, [self.seekoutScrollView getHeight])];
        [self.seekoutCardsArray addObject:seekoutCardView];
        [self.seekoutScrollView setContentSize:CGSizeMake([seekoutCardView getWidth]+48+16, [self.seekoutScrollView getWidth])];

        [self.seekoutScrollView addSubview:seekoutCardView];
    }
    
    
}





@end