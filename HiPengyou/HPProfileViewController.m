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


@interface HPProfileViewController ()
@property (strong, atomic) UIButton *backButton;
@property (strong, atomic) UIButton *settingButton;
@property (strong, atomic) UILabel *usernameLabel;
@property (strong, atomic) NSString *username;
@property (strong, atomic) UIImageView *faceImageView;
@property (strong, atomic) UIImageView *faceBackgroundImageView;
@property (strong, atomic) UITableView *seekoutListTableView;
@property (strong, atomic) NSMutableArray *seekoutArray;
@property (strong, atomic) UIAlertView *connectionFaiedAlertView;
@property NSInteger userID;
@property NSInteger pageID;
@property (strong, atomic) NSString *sid;
@end

@implementation HPProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self initNaviBar];
    [self initFace];
    [self requestForSeekoutList];
    [self initSeekoutListTableView];

    

}
- (void)initData
{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.username = [userDefaults objectForKey:@"username"];
    self.userID = [userDefaults integerForKey:@"id"];
    self.sid = [userDefaults objectForKey:@"sid"];
    self.pageID = 0;
    self.seekoutArray = [[NSMutableArray alloc]init];

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
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"HPBackButton"] forState:UIControlStateNormal];
    [self.backButton resetSize:CGSizeMake(20, 20)];
    [self.backButton setCenter:CGPointMake(19/2+10, 43)];
    [self.backButton addTarget:self action:@selector(didClickBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    self.usernameLabel = [[UILabel alloc]init];
    [self.usernameLabel resetSize:CGSizeMake(500, 30)];
    [self.usernameLabel setText:self.username];
    self.usernameLabel.numberOfLines = 1;
    [self.usernameLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                     green:188.0f / 255.0f
                                                      blue:235.0f / 255.0f
                                                     alpha:1]];
    [self.usernameLabel setBackgroundColor:[UIColor clearColor]];
    [self.usernameLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [self.usernameLabel sizeToFit];
    [self.usernameLabel setCenter:CGPointMake([self.view getWidth]/2, 87.5/2)];
    [self.view addSubview:self.usernameLabel];
    
    self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.settingButton setImage:[UIImage imageNamed:@"HPProfileSettingButton"] forState:UIControlStateNormal];
    [self.settingButton resetSize:CGSizeMake(31, 31)];
    [self.settingButton setCenter:CGPointMake(584/2+[self.settingButton getWidth]/2, 87.5/2)];
    [self.settingButton addTarget:self action:@selector(didClickSettingButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.settingButton];
    
}

- (void)initFace
{
    self.faceImageView = [[UIImageView alloc]init];
    NSURL *faceImageURL = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%d.png",FACE_IMAGE_URL,self.userID]];
    [self.faceImageView setImageWithURL:faceImageURL];
    [self.faceImageView resetSize:CGSizeMake(98, 99)];
    [self.faceImageView setCenter:CGPointMake([self.view getWidth]/2, 157/2+[self.faceImageView getHeight]/2)];
    [self.faceImageView.layer setMasksToBounds:YES];
    [self.faceImageView.layer setCornerRadius:[self.faceImageView getWidth]/2];
    [self.view addSubview:self.faceImageView];
    
}


- (void)initSeekoutListTableView
{
    self.seekoutListTableView = [[UITableView alloc]init];
    self.seekoutListTableView.delegate = self;
    self.seekoutListTableView.dataSource = self;
    [self.seekoutListTableView setFrame:CGRectMake(0, [self.faceImageView getCenterY]+[self.faceImageView getHeight], [self.view getWidth], [self.view getHeight] - ([self.faceImageView getCenterY]+[self.faceImageView getHeight]) - 30)];
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

#pragma mark - table
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
                                                            500)
                                           data:seekout];

    return cell;

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
                    
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@", [s objectForKey:@"uptime"]] doubleValue]];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
                    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                    [seekout setTime:[dateFormatter stringFromDate:date]];
                    NSURL* faceURL = [[NSURL alloc] initWithString:[s objectForKey:@"face"]];
                    [seekout setFaceImageURL:faceURL];
                    [self.seekoutArray addObject: seekout];
//                    NSLog(@"%@",seekout);
                    [self.seekoutListTableView reloadData];
                }
//                NSLog(@"%@",self.seekoutArray);
               
                
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


@end
