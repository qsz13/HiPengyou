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
#import "HPSeekoutType.h"
#import "HPSeekout.h"
#import "HPAPIURL.h"
#import "UIView+Resize.h"
#import "UIView+Animation.h"
#import "HPSeekoutTableViewCell.h"
#import "HPSeekoutTableView.h"

@interface HPHomeViewController ()

@property (strong, atomic) NSString *sid;
@property (strong, atomic) UIButton *categoryButton;
@property (strong, atomic) UIButton *messageButton;
@property (strong, atomic) UIButton *profileButton;
@property (strong, atomic) UIButton *addSeekoutButton;
@property (strong, atomic) HPMessageViewController *messageViewController;
@property (strong, atomic) HPProfileViewController *profileViewController;
@property (strong, atomic) HPSeekoutCreationViewController *seekoutCreationViewController;
@property (strong, atomic) HPSeekoutTableView *seekoutTableView;
//@property (strong, atomic) UIScrollView *seekoutScrollView;
@property (strong, atomic) NSMutableArray *seekoutCardsArray;
@property (strong, atomic) UIAlertView *connectionFaiedAlertView;
@property (strong, atomic) NSMutableArray *seekoutArray;
@property HPSeekoutType seekoutType;
@property NSInteger pageID;

// TODO
@property (strong, atomic) UIView *CategoriesView;

@end


@implementation HPHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self initCustomNavBar];
    [self initSeekoutTableView];
    [self initSeekoutCards];
    [self initCategoryButton];
    [self initCategoriesView];
}

- (void)initData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sid = [userDefaults objectForKey:@"sid"];
    
    self.seekoutType = all;
    self.pageID = 0;
    
}


#pragma mark - UI init
- (void)initView
{
    [self.view setBackgroundColor:[UIColor colorWithRed:230.0f / 255.0f
                                                  green:230.0f / 255.0f
                                                   blue:230.0f / 255.0f
                                                  alpha:1]];

    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)initCustomNavBar
{
    UIView *customNavbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    
    // Set Bg Color
    customNavbarView.backgroundColor = [UIColor clearColor];
    
    // init Add Seekout Button
    self.addSeekoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addSeekoutButton setImage:[UIImage imageNamed:@"HPAddSeekoutButton"] forState:UIControlStateNormal];
    //    [self.addSeekoutButton setFrame: CGRectMake(([self.view getWidth] - 43) / 2,
    //                                                [self.seekoutTableView getOriginY] + [self.seekoutTableView getHeight] + 25,
    //                                                43, 43)];
    [self.addSeekoutButton setFrame: CGRectMake(553 / 2, 8, 28, 28)];
    [self.addSeekoutButton addTarget:self
                              action:@selector(didClickAddSeekoutButton:)
                    forControlEvents:UIControlEventTouchUpInside];
    
    // init MessageButton
    self.messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.messageButton setImage:[UIImage imageNamed:@"HPChatButton"] forState:UIControlStateNormal];
    [self.messageButton setFrame: CGRectMake([self.addSeekoutButton getOriginX] - 41.5, 8, 31, 31)];
    [self.messageButton addTarget:self
                           action:@selector(didClickMessageButton:)
                 forControlEvents:UIControlEventTouchUpInside];

    // init Profile Button
    self.profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.profileButton setImage:[UIImage imageNamed:@"HPProfileButton"] forState:UIControlStateNormal];
    [self.profileButton setFrame: CGRectMake([self.messageButton getOriginX] - 41.5, 8, 31, 31)];
    [self.profileButton addTarget:self
                           action:@selector(didClickProfileButton:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    // Add to Custome Nav Bar View
    [customNavbarView addSubview:self.profileButton];
    [customNavbarView addSubview:self.messageButton];
    [customNavbarView addSubview:self.addSeekoutButton];
    
    // Add to View
    [self.view addSubview:customNavbarView];
}

- (void)initCategoryButton
{
    // init Category Button
    self.categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.categoryButton setImage:[UIImage imageNamed:@"HPCategoriesButton"] forState:UIControlStateNormal];
    [self.categoryButton setFrame:CGRectMake(15, [self.seekoutTableView getOriginY] + [self.seekoutTableView getHeight] + 25, 31, 31)];
    [self.categoryButton addTarget:self
                            action:@selector(didClickCategoryButton:)
                  forControlEvents:UIControlEventTouchUpInside];
    
    // Add to View
    [self.view addSubview:self.categoryButton];
}

- (void)initCategoriesView
{
    self.CategoriesView = [[UIView alloc] init];
    [self.CategoriesView resetSize:CGSizeMake(118, 25)];
    [self.CategoriesView setCenter:CGPointMake([self.categoryButton getCenterX] + ([self.categoryButton getWidth] + [self.CategoriesView getWidth]) / 2 + 8, [self.categoryButton getCenterY])];
    
    // init Buttons
    UIButton *allSeekoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *peopleSeekoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *lifeTipsSeekoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *eventsSeekoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Set Button Image
    [allSeekoutButton setImage:[UIImage imageNamed:@"HPSeekoutTypeAllButton"] forState:UIControlStateNormal];
    [peopleSeekoutButton setImage:[UIImage imageNamed:@"HPSeekoutTypePeopleButton"] forState:UIControlStateNormal];
    [lifeTipsSeekoutButton setImage:[UIImage imageNamed:@"HPSeekoutTypeLifeTipsButton"] forState:UIControlStateNormal];
    [eventsSeekoutButton setImage:[UIImage imageNamed:@"HPSeekoutTypeEventsButton"] forState:UIControlStateNormal];

    // Set Frame
    [allSeekoutButton setFrame:CGRectMake(0, 0, 25, 25)];
    [peopleSeekoutButton setFrame:CGRectMake([allSeekoutButton getOriginX] + [allSeekoutButton getWidth] + 6, 0, 25, 25)];
    [lifeTipsSeekoutButton setFrame:CGRectMake([peopleSeekoutButton getOriginX] + [peopleSeekoutButton getWidth] + 6, 0, 25, 25)];
    [eventsSeekoutButton setFrame:CGRectMake([lifeTipsSeekoutButton getOriginX] + [lifeTipsSeekoutButton getWidth] + 6, 0, 25, 25)];
    
    // Add Actions
    [allSeekoutButton addTarget:self
                         action:@selector(didClickAllSeekoutButton:)
               forControlEvents:UIControlEventTouchUpInside];
    [peopleSeekoutButton addTarget:self
                            action:@selector(didClickPeopleSeekoutButton:)
                  forControlEvents:UIControlEventTouchUpInside];
    [lifeTipsSeekoutButton addTarget:self
                              action:@selector(didClickLifeTipsSeekoutButton:)
                    forControlEvents:UIControlEventTouchUpInside];
    [eventsSeekoutButton addTarget:self
                            action:@selector(didClickEventsSeekoutButton:)
                  forControlEvents:UIControlEventTouchUpInside];
    
    // Add to Catefories View
    [self.CategoriesView addSubview:allSeekoutButton];
    [self.CategoriesView addSubview:peopleSeekoutButton];
    [self.CategoriesView addSubview:lifeTipsSeekoutButton];
    [self.CategoriesView addSubview:eventsSeekoutButton];
    
    // Add to View?
//    [self.view addSubview:self.CategoriesView];
}

//
//- (void)initSeekoutScrollView
//{
//
//    [self.seekoutScrollView setBounces:NO];
//    self.seekoutScrollView = [[UIScrollView alloc] init];
//
//    [self.seekoutScrollView setFrame:CGRectMake(0,168/2, [self.view getWidth],[self.view getHeight]-168)];
//
//    
//
//    
//    [self.seekoutScrollView setContentSize:CGSizeMake([self.seekoutScrollView getWidth], [self.seekoutScrollView getHeight])];
//    [self.seekoutScrollView setShowsVerticalScrollIndicator:NO];
//    [self.view addSubview:self.seekoutScrollView];
//}

- (void)initSeekoutTableView
{
    // Init With Frame
    self.seekoutTableView = [[HPSeekoutTableView alloc] initWithFrame:CGRectMake(0,
                                                                          0,
                                                                          [self.view getHeight] - 168,
                                                                          [self.view getWidth])
                                                         style:UITableViewStylePlain];
    
    // Set Delegate
    self.seekoutTableView.delegate = self;
    self.seekoutTableView.dataSource = self;
    
    // Header and Footer Delegate
    self.seekoutTableView.header.delegate = self;
    self.seekoutTableView.footer.delegate = self;
    
    // Add to Subview
    [self.view addSubview:self.seekoutTableView];
}

- (void)initSeekoutCards
{
    self.seekoutArray = [[NSMutableArray alloc] init];
    
    self.seekoutCardsArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < 2; i++)
    {
        [self requestForNewSeekout];
    }
}

#pragma mark - Button Event
- (void)didClickMessageButton:(UIButton *)sender
{
    self.messageViewController = [[HPMessageViewController alloc] init];
    [self.navigationController pushViewController:self.messageViewController animated:YES];
}

- (void)didClickProfileButton:(UIButton *)sender
{
    self.profileViewController = [[HPProfileViewController alloc] init];

    [self.navigationController pushViewController:self.profileViewController animated:YES];
}

- (void)didClickAddSeekoutButton:(UIButton *)sender
{
    self.seekoutCreationViewController = [[HPSeekoutCreationViewController alloc] init];
    [self.navigationController pushViewController:self.seekoutCreationViewController animated:YES];
}

// TODO - Animation, Show Categories View
- (void)didClickCategoryButton:(UIButton *)sender
{
//    NSLog(@"Click Catefory Button");
    if ([self.view.subviews containsObject:self.CategoriesView])
    {
        [self.CategoriesView fadeOut];
        [self.CategoriesView removeFromSuperview];
    }
    else
    {
        [self.view addSubview:self.CategoriesView];
        [self.CategoriesView fadeIn];
    }
}

// TODO
- (void)didClickAllSeekoutButton:(UIButton *)sender
{
    self.seekoutType = all;
}

// TODO
- (void)didClickPeopleSeekoutButton:(UIButton *)sender
{
    self.seekoutType = people;
}

// TODO
- (void)didClickLifeTipsSeekoutButton:(UIButton *)sender
{
    self.seekoutType = tips;
}

// TODO
- (void)didClickEventsSeekoutButton:(UIButton *)sender
{
    self.seekoutType = events;
}

#pragma mark - Request
- (void)requestForNewSeekout
{
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@&typeId=%d&pageId=%d",SEEKOUT_LIST_URL, self.sid, self.seekoutType, self.pageID]];
    self.pageID++;
    NSLog(@"%d",self.pageID);
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    


    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        

        //connection successed
        if([data length] > 0 && connectionError == nil)
        {
            NSError *e = nil;
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
//            NSLog(@"%@",dataDict);
            //request success
            if([[dataDict objectForKey:@"code"] isEqualToString:@"10000"])
            {
                NSDictionary *resultDict = [dataDict objectForKey:@"result"];
                NSArray *seekoutList = [resultDict objectForKey:@"Seekout.list"];
                for (NSDictionary *s in seekoutList)
                {
                    HPSeekout *seekout = [[HPSeekout alloc]init];
                    [seekout setSeekoutID:[[s objectForKey:@"id"] integerValue]];
                    [seekout setContent:[s objectForKey:@"content"]];
                    [seekout setAuthor:[s objectForKey:@"author"]];
                    [seekout setCommentNumber:[[s objectForKey:@"comment"] integerValue]];
                    [seekout setState:[s objectForKey:@"seekoutstatu"]];
                    [seekout setType:[[s objectForKey:@"type"] integerValue]];
                    [seekout setTime:[s objectForKey:@"uptime"]];

                    
                    [self.seekoutArray addObject: seekout];
                    NSLog(@"%@",[s objectForKey:@"author"]);
//                    [self addSeekoutCard:seekout];
                }
                
                [self.seekoutTableView reloadData];

                
                
                
            }
            //login failed
            else if([[dataDict objectForKey:@"code"] isEqualToString:@"10001"])
            {
                //please login first
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


//#pragma mark - Add Card
//- (void)addSeekoutCard:(HPSeekout*)seekout
//{
//    if ([self.seekoutCardsArray count])
//    {
//        HPSeekoutCardView *lastSeekoutCardView = [self.seekoutCardsArray lastObject];
//
//        HPSeekoutCardView *newSeekoutCardView = [[HPSeekoutCardView alloc] initWithFrame:CGRectMake([lastSeekoutCardView getOriginX] + [lastSeekoutCardView getWidth] + 10, 0, 512/2, [self.seekoutScrollView getHeight])];
//        [newSeekoutCardView loadData:seekout];
//        [self.seekoutCardsArray addObject:newSeekoutCardView];
//        [self.seekoutScrollView setContentSize:CGSizeMake(self.seekoutScrollView.contentSize.width + [newSeekoutCardView getWidth] + 10, [self.seekoutScrollView getHeight])];
//        NSLog(@"%f",[self.seekoutScrollView getWidth]);
//        [self.seekoutScrollView addSubview:newSeekoutCardView];
//
//    }
//    else
//    {
//        HPSeekoutCardView *seekoutCardView = [[HPSeekoutCardView alloc] initWithFrame:CGRectMake(48/2+16/2, 0, 512/2, [self.seekoutScrollView getHeight])];
//        [self.seekoutCardsArray addObject:seekoutCardView];
//        [self.seekoutScrollView setContentSize:CGSizeMake([seekoutCardView getWidth]+48+16, [self.seekoutScrollView getWidth])];
//
//        [self.seekoutScrollView addSubview:seekoutCardView];
//    }
//}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.seekoutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HPSeekoutTableViewCell *cell = [[HPSeekoutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                 reuseIdentifier:@"seekout"
                                                                           frame:CGRectMake(0,
                                                                                            0,
                                                                                            512 / 2,
                                                                                            [tableView getHeight])
                                                                            data:[self.seekoutArray objectAtIndex:indexPath.row]];
    // Set Style
    cell.transform = CGAffineTransformMakeRotation(M_PI / 2);
    cell.userInteractionEnabled = NO;
    
    return cell;
}

// TODO
#pragma mark - MJRefreshBaseView Delegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"%@----开始进入刷新状态", refreshView.class);
    
    // 1.添加假数据
    
    
    // 2.2秒后刷新表格UI
    [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
}

- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"%@----刷新完毕", refreshView.class);
}

- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    switch (state) {
        case MJRefreshStateNormal:
            NSLog(@"%@----切换到：普通状态", refreshView.class);
            break;
            
        case MJRefreshStatePulling:
            NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
            break;
            
        case MJRefreshStateRefreshing:
            NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
            break;
        default:
            break;
    }
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.seekoutTableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}



@end