//
//  HPProfileViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/26/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPProfileViewController.h"
#import "HPProfileSettingViewController.h"
#import "HPSeekout.h"
#import "HPAPIURL.h"
#import "UIView+Resize.h"
#import "UIImageView+AFNetworking.h"
#import "HPProfileSeekoutTableViewCell.h"
#import "HPSeekoutDetailViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "HPConversationDetailViewController.h"
#import "HPNaviBar.h"



@interface HPProfileViewController ()
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIButton *settingButton;
@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UIView *personalInfoView;
@property (strong, nonatomic) UIImageView *faceImageView;
@property (strong, nonatomic) UIImageView *faceBackgroundImageView;
@property (strong, nonatomic) UITableView *seekoutListTableView;
@property (strong, nonatomic) NSMutableArray *seekoutArray;
@property (strong, nonatomic) UIAlertView *connectionFaiedAlertView;
@property (strong, nonatomic) HPNaviBar *naviBar;
@property (strong, nonatomic) UIButton *messageButton;
@property (strong, nonatomic) UIImageView *likeImage;
@property (strong, nonatomic) UILabel *likeNumLabel;

@property (strong, nonatomic) HPUser *user;

//@property NSInteger userID;
@property NSInteger pageID;
@property (strong, nonatomic) NSString *sid;
@end

@implementation HPProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self initNaviBar];
    [self initPersonalInfoView];
    [self initSeekoutListTableView];

}

- (void)initData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sid = [userDefaults objectForKey:@"sid"];
    self.user = [[HPUser alloc]init];
    if(self.isSelfUser)
    {

        self.profileUserID = [userDefaults integerForKey:@"id"];
        [self requestForUserInfo:self.profileUserID];
        
    }
    else
    {
        [self requestForUserInfo:self.profileUserID];
    }


    self.pageID = 0;
    self.seekoutArray = [[NSMutableArray alloc]init];
    if(self.isSelfUser)
    {
        [self requestForSeekoutList];
    }
    
}

- (void)reloadData
{
    [self.faceImageView setImageWithURL:self.user.userFaceURL];
    [self.usernameLabel setText:self.user.username];
    [self.usernameLabel setText:self.user.username];
    self.usernameLabel.numberOfLines = 1;
    [self.usernameLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                     green:188.0f / 255.0f
                                                      blue:235.0f / 255.0f
                                                     alpha:1]];
    [self.usernameLabel setBackgroundColor:[UIColor clearColor]];
    [self.usernameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [self.usernameLabel sizeToFit];
    [self.usernameLabel setCenter:CGPointMake([self.view getWidth]/2, [self.faceImageView getOriginY]+[self.faceImageView getHeight]+[self.usernameLabel getHeight]/2 + 10)];
    
    
    [self.likeNumLabel setText:[NSString stringWithFormat:@"%d",self.user.likeNum]];
    
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
    if(self.isSelfUser)
    {
        [self.titleLable setText:@"Your Page"];
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
    }
    
    
    

    
    if(self.isSelfUser)
    {
        self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.settingButton setImage:[UIImage imageNamed:@"HPProfileSettingButton"] forState:UIControlStateNormal];
        [self.settingButton resetSize:CGSizeMake(31, 31)];
        [self.settingButton setCenter:CGPointMake(560/2+[self.settingButton getWidth]/2, [self.naviBar getHeight]/2)];
        [self.settingButton addTarget:self action:@selector(didClickSettingButton) forControlEvents:UIControlEventTouchUpInside];
        [self.naviBar addSubview:self.settingButton];
        
        

    }
    [self.view addSubview:self.naviBar];
    
}

- (void)initPersonalInfoView
{
    self.personalInfoView = [[UIView alloc] init];
    [self.personalInfoView setBackgroundColor:[UIColor whiteColor]];
    [self.personalInfoView setFrame:CGRectMake(0, [self.naviBar getOriginY]+[self.naviBar getHeight], [self.view getWidth], 190)];
    NSLog(@"%f",[self.view getHeight]);
    //init face image view
    self.faceImageView = [[UIImageView alloc]init];
    [self.faceImageView setImageWithURL:self.user.userFaceURL];
    [self.faceImageView resetSize:CGSizeMake(98, 99)];
    [self.faceImageView setCenter:CGPointMake([self.view getWidth]/2, [self.personalInfoView getHeight]/3)];
    [self.faceImageView.layer setMasksToBounds:YES];
    [self.faceImageView.layer setCornerRadius:[self.faceImageView getWidth]/2];
    [self.personalInfoView addSubview:self.faceImageView];
    
    self.usernameLabel = [[UILabel alloc]init];
    [self.usernameLabel resetSize:CGSizeMake(500, 30)];
    [self.usernameLabel setText:self.user.username];
    self.usernameLabel.numberOfLines = 1;
    [self.usernameLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                     green:188.0f / 255.0f
                                                      blue:235.0f / 255.0f
                                                     alpha:1]];
    [self.usernameLabel setBackgroundColor:[UIColor clearColor]];
    [self.usernameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [self.usernameLabel sizeToFit];
    [self.usernameLabel setCenter:CGPointMake([self.view getWidth]/2, [self.faceImageView getOriginY]+[self.faceImageView getHeight]+[self.usernameLabel getHeight]/2 + 8)];
    [self.personalInfoView addSubview:self.usernameLabel];
    
    //init like image
    self.likeImage = [[UIImageView alloc]init];
    [self.likeImage setImage:[UIImage imageNamed:@"HPLikeButton"]];
    [self.likeImage resetSize:CGSizeMake(23, 20)];
    [self.likeImage setCenter:CGPointMake([self.view getWidth]/2, [self.usernameLabel getOriginY]+[self.usernameLabel getHeight] + [self.likeImage getHeight] + 20)];
    [self.personalInfoView addSubview:self.likeImage];

    //init like number Label
    self.likeNumLabel = [[UILabel alloc]init];
    [self.likeNumLabel resetSize:CGSizeMake(500, 30)];
    [self.likeNumLabel setText:[NSString stringWithFormat:@"%d",self.user.likeNum]];
    self.likeNumLabel.numberOfLines = 1;
    [self.likeNumLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                     green:188.0f / 255.0f
                                                      blue:235.0f / 255.0f
                                                     alpha:1]];
    [self.likeNumLabel setBackgroundColor:[UIColor clearColor]];
    [self.likeNumLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
    [self.likeNumLabel sizeToFit];
    
    [self.likeNumLabel setCenter:CGPointMake([self.view getWidth]/2, [self.likeImage getOriginY]+[self.likeImage getHeight]+[self.likeNumLabel getHeight]/2 + 3)];
    [self.personalInfoView addSubview:self.likeNumLabel];
    
    
    //init message button
    if(!self.isSelfUser)
    {
        self.messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.messageButton setImage:[UIImage imageNamed:@"HPSendMessageButton"] forState:UIControlStateNormal];

        [self.messageButton resetSize:CGSizeMake(136/2, 50/2)];
        [self.messageButton setCenter:CGPointMake([self.usernameLabel getCenterX] + [self.messageButton getWidth] + 10, [self.usernameLabel getCenterX])];
        [self.messageButton addTarget:self action:@selector(didClickMessageButton) forControlEvents:UIControlEventTouchUpInside];
        [self.personalInfoView addSubview:self.messageButton];
    }
    
    [self.view addSubview:self.personalInfoView];
}




- (void)initSeekoutListTableView
{
    self.seekoutListTableView = [[UITableView alloc]init];
    self.seekoutListTableView.delegate = self;
    self.seekoutListTableView.dataSource = self;
    [self.seekoutListTableView setFrame:CGRectMake(0, [self.personalInfoView getOriginY]+[self.personalInfoView getHeight] + 10, [self.view getWidth], [self.view getHeight] - ([self.faceImageView getCenterY] + [self.faceImageView getHeight]) - 30)];
    self.seekoutListTableView.tableFooterView = [[UIView alloc]init];
    
    
    [self.view addSubview:self.seekoutListTableView];
    

}




#pragma mark - button event

- (void)didClickBackButton
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didClickSettingButton
{
    HPProfileSettingViewController *settingViewController = [[HPProfileSettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:YES];
    
    
}

- (void)didClickMessageButton
{

    HPConversationThread *conversationThread = [[HPConversationThread alloc]init];
    [conversationThread setChatter:self.user];
    HPConversationDetailViewController *conversationDetailViewController = [[HPConversationDetailViewController alloc]initWithConvsersationThread:conversationThread];

    [self.navigationController pushViewController:conversationDetailViewController animated:YES];
}


#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.seekoutArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HPSeekout *seekout = [self.seekoutArray objectAtIndex:indexPath.row];

    
    HPProfileSeekoutTableViewCell *cell = [[HPProfileSeekoutTableViewCell alloc]
                                           initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:@"profileSeekout"
                                           frame:CGRectMake(0,
                                                            0,
                                                            [self.view getWidth],
                                                            50)
                                           data:seekout];

    return cell;

}

#pragma mark - Table View delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HPSeekout *seekoutData = [self.seekoutArray objectAtIndex:indexPath.row];
    HPSeekoutDetailViewController *vc = [[HPSeekoutDetailViewController alloc] initWithSeekoutData:seekoutData];

    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - Network Request
- (void)requestForSeekoutList
{
    
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@sid=%@&pageid=%d",PERSONAL_SEEKOUT_URL, self.sid, self.pageID]];
    self.pageID++;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //connection successed
        if([data length] > 0 && connectionError == nil)
        {
            NSError *e = nil;
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            NSLog(@"%@",dataDict);
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
                    HPUser *user = [[HPUser alloc]init];
                    [user setUserID:[[s objectForKey:@"authorfaceid"]integerValue ]];
                    [user setUsername:[s objectForKey:@"author"]];
                    NSURL* faceURL = [[NSURL alloc] initWithString:[s objectForKey:@"face"]];
                    [user setUserFaceURL:faceURL];
                    [seekout setAuthor:user];
                    [seekout setCommentNumber:[[s objectForKey:@"comment"] integerValue]];
                    [seekout setState:[s objectForKey:@"seekoutstatu"]];
                    [seekout setType:[[s objectForKey:@"type"] integerValue]];
                    
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@", [s objectForKey:@"uptime"]] doubleValue]];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
                    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                    [seekout setTime:[dateFormatter stringFromDate:date]];
                    
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
    
    [self.seekoutListTableView reloadData];
}

- (void)requestForUserInfo:(NSInteger)userID
{

//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *params = @{@"userId": [NSNumber numberWithInteger:self.profileUserID]};
//
//    [manager POST:[NSString stringWithFormat:@"%@sid=%@",USER_INFO, self.sid] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@sid=%@",USER_INFO, self.sid]];

    
    
    
    
    

    NSData *postData = [[NSString stringWithFormat:@"userId=%d",self.profileUserID] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
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
            NSLog(@"%@",dataDict);
            //request success
            if([[dataDict objectForKey:@"code"] isEqualToString:@"10000"])
            {
                NSDictionary *resultDict = [dataDict objectForKey:@"result"];
                NSDictionary *userDict = [resultDict objectForKey:@"User"];
                [self.user setUserID:[[userDict objectForKey:@"id"] integerValue]];
                [self.user setUsername:[userDict objectForKey:@"name"]];
                [self.user setFirstLanguage:[userDict objectForKey:@"firstlanguage"]];
                NSURL
                *faceURL = [[NSURL alloc]initWithString:[userDict objectForKey:@"faceurl"]];
                [self.user setUserFaceURL:faceURL];
                [self.user setLikeNum:[[userDict objectForKey:@"getlikes"] integerValue]];
                
                [self reloadData];

                
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
