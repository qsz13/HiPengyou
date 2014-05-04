//
//  HPConversationDetailViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 5/2/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPConversationDetailViewController.h"
#import "HPMessageTableViewCell.h"
#import "HPNaviBar.h"
#import "HPAPIURL.h"
#import "UIView+Resize.h"

@interface HPConversationDetailViewController ()

@property (strong, nonatomic) HPConversationThread *conversationThread;
@property (strong, nonatomic) HPNaviBar *naviBar;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UITableView *messageTableView;
@property (strong, nonatomic) UIView *sendMessageView;
@property (strong, nonatomic) UITextField *messageTextField;
@property (strong, nonatomic) UIButton *sendButton;
@property (strong, nonatomic) UIAlertView *replyAlertView;
@property (strong, nonatomic) UIAlertView *connectionFaiedAlertView;
@property (strong, nonatomic) NSString *sid;

@property NSInteger userID;
@end

@implementation HPConversationDetailViewController

- (id)initWithConvsersationThread:(HPConversationThread *)conversationThread
{
    self = [super init];
    if (self) {
        self.conversationThread = conversationThread;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self initNaviBar];
    [self initMessageTableView];
    [self initSendMessageView];

}

#pragma mark - Data init
- (void)initData
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.sid = [userDefaults objectForKey:@"sid"];
    self.userID = [userDefaults integerForKey:@"id"];


    
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
    [self.titleLable setText:[NSString stringWithFormat:@"%@%@",@"Chat with ",self.conversationThread.chatter.username]];
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
    [self.messageTableView setFrame:CGRectMake(0, [self.naviBar getOriginY] + [self.naviBar getHeight], [self.view getWidth], [self.view getHeight]*8/10)];
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    if ([self.messageTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.messageTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    self.messageTableView.tableFooterView = [[UIView alloc]init];
    [self.messageTableView setBackgroundColor:[UIColor colorWithRed:230.0f / 255.0f
                                                                         green:230.0f / 255.0f
                                                                          blue:230.0f / 255.0f
                                                                         alpha:1]];
    [self.view addSubview:self.messageTableView];
}

- (void)initSendMessageView
{
    self.sendMessageView = [[UIView alloc]init];
    [self.sendMessageView setFrame:CGRectMake(0, [self.messageTableView getHeight] + [self.messageTableView getOriginY], [self.view getWidth], [self.view getHeight]-([self.messageTableView getHeight] + [self.messageTableView getOriginY]))];
    [self.sendMessageView setBackgroundColor:[UIColor colorWithRed:220.0f / 255.0f
                                                             green:220.0f / 255.0f
                                                              blue:220.0f / 255.0f
                                                             alpha:1]];
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sendButton setTitle:@"Send" forState:UIControlStateNormal];
    [self.sendButton sizeToFit];
    [self.sendButton setCenter:CGPointMake([self.view getWidth]-[self.sendButton getWidth]/2 - 10, [self.sendMessageView getHeight]/2)];
    [self.sendButton setTintColor:[UIColor whiteColor]];
    [self.sendButton addTarget:self action:@selector(didClickSendButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.messageTextField = [[UITextField alloc] init];
    self.messageTextField.delegate = self;
    [self.messageTextField setFrame:CGRectMake(10, 5, [self.sendMessageView getWidth]-20 - [self.sendButton getWidth] - 10, [self.sendMessageView getHeight]-10)];
    [self.messageTextField setPlaceholder:@"input yout message"];
    [self.messageTextField setBackgroundColor:[UIColor whiteColor]];
    
    
    
    [self.sendMessageView addSubview:self.messageTextField];
    [self.sendMessageView addSubview:self.sendButton];
    
    [self.view addSubview:self.sendMessageView];
    

}

#pragma mark - Button Event

- (void)didClickBackButton
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didClickSendButton
{
    NSLog(@"request");
    
    
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.conversationThread.messageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"message";
    HPMessage *message = [self.conversationThread.messageList objectAtIndex:indexPath.row];

   

    HPMessageTableViewCell *cell = [[HPMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier frame:CGRectMake(0, 0, [self.view getWidth], 30) data:message];
    
    
    
    
    
    
    
    return cell;
    
}


#pragma mark - table view Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    [self animateTextField: textField up: YES];
    
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}


- (void)animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 215; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

#pragma mark - network request

- (void)requestForSendMessage
{
    
    
    NSString *replyContent = self.messageTextField.text;
    
    if(replyContent.length <= 0)
    {
        self.replyAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"reply content cannot be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.replyAlertView show];
        
    }
    else
    {
        NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@sid=%@",SEND_MESSAGE_URL,self.sid]];
       
        NSData *postData = [[NSString stringWithFormat:@"content=%@&sender=%d&reciever=%d&hasmedia=%d",replyContent, self.userID, self.conversationThread.chatter.userID,0] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];

        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            //connection successed
            if([data length] > 0 && connectionError == nil)
            {
                NSError *e = nil;
                NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
                //successed
                if([[dataDict objectForKey:@"code"] isEqualToString:@"10000"])
                {
                    self.replyAlertView = [[UIAlertView alloc]initWithTitle:@"thanks" message:@"your reply has been sent" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [self.replyAlertView show];
                    
                }
//                //login failed
//                else if([[dataDict objectForKey:@"code"] isEqualToString:@"10009"])
//                {
//                    self.connectionFaiedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"Seekout not exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [self.connectionFaiedAlertView show];
//                }
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
                NSLog(@"%@",data);
                self.connectionFaiedAlertView = [[UIAlertView alloc]  initWithTitle:@"Oops.." message:@"something wrong..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [self.connectionFaiedAlertView show];
            }
            
            
        }];
        
    }

}




@end
