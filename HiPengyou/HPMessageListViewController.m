//
//  HPMessageViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/26/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPMessageListViewController.h"
#import "HPNaviBar.h"
#import "HPAPIURL.h"
#import "HPMessage.h"
#import "UIView+Resize.h"

@interface HPMessageListViewController ()

@property (strong, atomic) UIButton *backButton;
@property (strong, atomic) HPNaviBar *naviBar;
@property (strong, atomic) UILabel *titleLable;
@property (strong, atomic) UIButton *settingButton;
@property (strong, atomic) UITableView *messageTableView;
@property (strong, atomic) NSString *sid;
@property NSInteger upTime;
@property NSInteger userID;
@property NSInteger pageID;
@property (strong, atomic) NSMutableDictionary *messageDictionary;



@end

@implementation HPMessageListViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initData];
    [self requestForMessageList];
    [self initNaviBar];
    [self initMessageTableView];
    
}

- (void)initData
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sid = [userDefaults objectForKey:@"sid"];
    self.userID = [userDefaults integerForKey:@"id"];
    self.pageID = 0;
    self.upTime = 0;
    self.messageDictionary = [[NSMutableDictionary alloc]init];
    
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
    self.naviBar = [[HPNaviBar alloc]init];
    [self.naviBar setFrame:CGRectMake(0, 20, [self.view getWidth], 40)];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"HPBackButton"] forState:UIControlStateNormal];
    [self.backButton resetSize:CGSizeMake(20, 20)];
    [self.backButton setCenter:CGPointMake(19/2+10, [self.naviBar getHeight]/2)];
    [self.backButton addTarget:self action:@selector(didClickBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.naviBar addSubview:self.backButton];
    
    
    self.titleLable = [[UILabel alloc]init];
    [self.titleLable resetSize:CGSizeMake(500, 30)];
    [self.titleLable setText:@"Your Conversation"];
    self.titleLable.numberOfLines = 1;
    [self.titleLable setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                  green:188.0f / 255.0f
                                                   blue:235.0f / 255.0f
                                                  alpha:1]];
    [self.titleLable setBackgroundColor:[UIColor clearColor]];
    [self.titleLable setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [self.titleLable sizeToFit];
    [self.titleLable setCenter:CGPointMake([self.view getWidth]/2, [self.naviBar getHeight]/2)];
    [self.naviBar addSubview:self.titleLable];
    
    
    
    
    [self.view addSubview:self.naviBar];
    
}


- (void)initMessageTableView
{
    self.messageTableView = [[UITableView alloc] init];
    [self.messageTableView setFrame:CGRectMake(0, [self.naviBar getOriginY] + [self.naviBar getHeight], [self.view getWidth], [self.view getHeight] - [self.naviBar getOriginY] - [self.naviBar getHeight])];
    [self.view addSubview:self.messageTableView];
    
    
}



#pragma mark - Button Event

- (void)didClickBackButton
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Network Request

- (void)requestForMessageList
{
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@sid=%@&uptime=%d&userId=%d&pageId=%d&",PERSONAL_SEEKOUT_URL, self.sid, self.upTime ,self.userID,self.pageID]];
    self.pageID++;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //connection successed
        if([data length] > 0 && connectionError == nil)
        {
            NSError *e = nil;
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            
            //request success
            if([[dataDict objectForKey:@"code"] isEqualToString:@"10000"])
            {
                NSDictionary *resultDict = [dataDict objectForKey:@"result"];
                NSArray *seekoutList = [resultDict objectForKey:@"message.list"];
                for (NSDictionary *s in seekoutList)
                {
                    HPSeekout *seekout = [[HPSeekout alloc]init];
                    [seekout setSeekoutID:[[s objectForKey:@"id"] integerValue]];
                    [seekout setContent:[s objectForKey:@"content"]];
                    [seekout setAuthor:[s objectForKey:@"author"]];
                    [seekout setCommentNumber:[[s objectForKey:@"comment"] integerValue]];
                    [seekout setState:[s objectForKey:@"seekoutstatu"]];
                    [seekout setType:[[s objectForKey:@"type"] integerValue]];
                    
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@", [s objectForKey:@"uptime"]] doubleValue]];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
                    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                    [seekout setTime:[dateFormatter stringFromDate:date]];
                    NSURL* faceURL = [[NSURL alloc] initWithString:[s objectForKey:@"face"]];
                    [seekout setFaceImageURL:faceURL];
                    [self.seekoutArray addObject: seekout];
                    [self.seekoutListTableView reloadData];
                }
                
                
                
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

}



@end
