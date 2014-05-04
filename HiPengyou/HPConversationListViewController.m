//
//  HPMessageViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/26/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPConversationListViewController.h"
#import "HPConversationDetailViewController.h"
#import "HPConversationThread.h"
#import "HPNaviBar.h"
#import "HPAPIURL.h"
#import "HPUser.h"
#import "HPMessage.h"
#import "UIView+Resize.h"

@interface HPConversationListViewController ()

@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) HPNaviBar *naviBar;
@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UIButton *settingButton;
@property (strong, nonatomic) UITableView *conversationThreadTableView;
@property (strong, nonatomic) UIAlertView *connectionFaiedAlertView;
@property (strong, nonatomic) NSString *sid;
@property NSInteger upTime;
@property NSInteger userID;
@property NSInteger pageID;
@property (strong, nonatomic) NSMutableArray *messageArray;
@property (strong, nonatomic) NSMutableArray *conversationThreadArray;



@end

@implementation HPConversationListViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initData];
    [self initNaviBar];
    [self initConversationTableView];
    


    
}

#pragma mark - Data init
- (void)initData
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sid = [userDefaults objectForKey:@"sid"];
    self.userID = [userDefaults integerForKey:@"id"];
    NSLog(@"%d",self.userID);
    self.pageID = 0;
    self.upTime = 0;
    self.conversationThreadArray = [[NSMutableArray alloc]init];
    self.messageArray = [[NSMutableArray alloc]init];
    [self requestForMessageList];

}

- (void)manageMessageData
{
    for(HPMessage *m in self.messageArray)
    {
        if(m.sender.userID == self.userID)
        {
            m.sentByMe = YES;
            BOOL isNewThread = YES;
            for(HPConversationThread *t in self.conversationThreadArray)
            {
                if(t.chatter.userID == m.reciever.userID)
                {
                    isNewThread = NO;
                    [t addMessage:m];
                }
                
            }
            if (isNewThread)
            {
                HPConversationThread *conversationThread = [[HPConversationThread alloc]init];
                [conversationThread setChatter:m.reciever];
                [conversationThread addMessage:m];
                [self.conversationThreadArray addObject:conversationThread];
            }
   
            
            
        }
        else if(m.reciever.userID == self.userID)
        {

            m.sentByMe = YES;
            BOOL isNewThread = YES;
            for(HPConversationThread *t in self.conversationThreadArray)
            {
                if(t.chatter.userID == m.sender.userID)
                {
                    isNewThread = NO;
                    [t addMessage:m];
                }
                
            }
            if (isNewThread)
            {
                HPConversationThread *conversationThread = [[HPConversationThread alloc]init];
                [conversationThread setChatter:m.sender];
                [conversationThread addMessage:m];
                [self.conversationThreadArray addObject:conversationThread];
            }
            

        }
        

    }
    [self.conversationThreadTableView reloadData];
}

#pragma mark - UI init

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


- (void)initConversationTableView
{
    self.conversationThreadTableView = [[UITableView alloc] init];
    self.conversationThreadTableView.delegate = self;
    self.conversationThreadTableView.dataSource = self;
    [self.conversationThreadTableView setFrame:CGRectMake(0, [self.naviBar getOriginY] + [self.naviBar getHeight], [self.view getWidth], [self.view getHeight] - [self.naviBar getOriginY] - [self.naviBar getHeight])];
    self.conversationThreadTableView.tableFooterView = [[UIView alloc]init];
    [self.conversationThreadTableView setBackgroundColor:[UIColor colorWithRed:230.0f / 255.0f
                                                                        green:230.0f / 255.0f
                                                                         blue:230.0f / 255.0f
                                                                         alpha:1]];
    [self.view addSubview:self.conversationThreadTableView];
    
    
}


#pragma mark - Button Event

- (void)didClickBackButton
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Network Request

- (void)requestForMessageList
{
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@sid=%@&uptime=%d&userId=%d&pageId=%d&",MESSAGE_LIST_URL, self.sid, self.upTime ,self.userID,self.pageID]];
    self.pageID++;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //connection successed
        if([data length] > 0 && connectionError == nil)
        {
            NSError *e = nil;
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            NSLog(@"%@", dataDict);
            //request success
            if([[dataDict objectForKey:@"code"] isEqualToString:@"10000"])
            {
                NSDictionary *resultDict = [dataDict objectForKey:@"result"];
                NSArray *messageList = [resultDict objectForKey:@"message.list"];
                for (NSDictionary *m in messageList)
                {
                    HPMessage *message = [[HPMessage alloc]init];
                    [message setMessageID:[[m objectForKey:@"id"] integerValue]];
                    HPUser *sender = [[HPUser alloc] init];
                    [sender setUserID:[[m objectForKey:@"sender"] integerValue]];
                    [sender setUsername:[m objectForKey:@"sendername"]];
                    [sender setUserFaceURL:[NSURL URLWithString:[m objectForKey:@"senderface"]]];
                    [message setSender:sender];
                    
                    HPUser *reciever = [[HPUser alloc]init];
                    [reciever setUserID:[[m objectForKey:@"reciever"] integerValue]];
                    [reciever setUsername:[m objectForKey:@"recievername"]];
                    [reciever setUserFaceURL:[NSURL URLWithString:[m objectForKey:@"recieverface"]]];
                    [message setReciever:reciever];
                    
                    [message setContent:[m objectForKey:@"content"]];
                    
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@", [m objectForKey:@"uptime"]] doubleValue]];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
                    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                    [message setTime:[dateFormatter stringFromDate:date]];
                    [message setStatus:[[m objectForKey:@"status"] integerValue]];
                    [message setHasMedia:[[m objectForKey:@"hasmedia"] boolValue]];
                    
                    [self.messageArray addObject:message];
                    
                }
                [self manageMessageData];
                
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


#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.conversationThreadArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"conversation";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    HPConversationThread *t = [self.conversationThreadArray objectAtIndex:indexPath.row];
    

    if(![t.chatter.username isKindOfClass:[NSNull class]])
    {
        cell.textLabel.text = t.chatter.username;

    }
    else{
        cell.textLabel.text = @"null";
    }
    [cell setBackgroundColor:[UIColor colorWithRed:247.0f / 255.0f
                                             green:247.0f / 255.0f
                                              blue:247.0f / 255.0f
                                             alpha:1]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                 green:188.0f / 255.0f
                                                  blue:235.0f / 255.0f
                                                 alpha:1]];
   
    return cell;

    
}



#pragma mark - table view Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HPConversationThread *ct = [self.conversationThreadArray objectAtIndex:indexPath.row];
    HPConversationDetailViewController *vc = [[HPConversationDetailViewController alloc] initWithConvsersationThread:ct];
    
    [self.navigationController pushViewController:vc animated:YES];

    
}


@end
