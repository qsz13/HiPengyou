//
//  HPSeekoutCreationViewController.m
//  HiPengyou
//
//  Created by Daniel Qiu on 3/30/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPSeekoutCreationViewController.h"
#import "HPAPIURL.h"
#import "HPSeekoutType.h"
#import "UIView+Resize.h"
#import "UIImage+ImageEffects.h"

@interface HPSeekoutCreationViewController ()

@property (strong, atomic) UIButton *backButton;
@property (strong, atomic) UILabel *titleButton;
@property (strong, atomic) UITextView *seekoutContentTextView;
@property (strong, atomic) UIButton *seekoutTypeButton;
@property (strong, atomic) UIButton *seekoutLanguageButton;
@property (strong, atomic) UIButton *seekoutLocationButton;
@property (strong, atomic) UILabel *seekoutTypeLabel;
@property (strong, atomic) UITableView *seekoutTypeTableView;
@property (strong, atomic) NSArray *seekoutTypeArray;
@property (strong, atomic) UIImageView *seekoutTypeIcon;
@property (strong, atomic) UIImageView *seekoutLanguageIcon;
@property (strong, atomic) UIImageView *seekoutLocationIcon;
@property (strong, atomic) UIButton *seekoutPostButton;
//@property (strong, atomic) UITableView *seekoutTypeTable;
@property (strong, atomic) UIAlertView *postSuccessAlertView;
@property (strong, atomic) UIAlertView *postFailedAlertView;
@property (strong, atomic) UIImageView *blurredBackgroundImageView;
@property (strong, atomic) NSString *sid;
@property HPSeekoutType seekoutType;

@end

@implementation HPSeekoutCreationViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self initNaviBar];
    [self initTextView];
    [self initButton];
    [self initTableView];
}

- (void)initData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sid = [userDefaults objectForKey:@"sid"];
    self.seekoutType = people;
    self.seekoutTypeArray = @[@"     People Seekout",@"     Tips Seekout",@"     Events Seekout"];
    
    
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

    
    
    self.titleButton = [[UILabel alloc]init];
    [self.titleButton resetSize:CGSizeMake(500, 30)];
    [self.titleButton setText:@"Create My Seekout"];
    self.titleButton.numberOfLines = 1;
    [self.titleButton setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                   green:188.0f / 255.0f
                                                    blue:235.0f / 255.0f
                                                   alpha:1]];
    [self.titleButton setBackgroundColor:[UIColor clearColor]];
    [self.titleButton setFont:[UIFont fontWithName:@"Helvetica-light" size:20]];
    [self.titleButton sizeToFit];
    [self.titleButton setCenter:CGPointMake([self.view getWidth]/2, 87.5/2)];
    [self.view addSubview:self.titleButton];
}

- (void)initTextView
{
    self.seekoutContentTextView = [[UITextView alloc]init];

    [self.seekoutContentTextView resetSize:CGSizeMake(300, [self.view getHeight]*0.3)];
    [self.seekoutContentTextView setCenter:CGPointMake([self.view getWidth]/2, 150/2+[self.seekoutContentTextView getHeight]/2)];
    
    [self.view addSubview:self.seekoutContentTextView];
    
    
}

- (void)initButton
{
    
    self.seekoutTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.seekoutTypeButton setBackgroundImage:[UIImage imageNamed:@"HPSeekoutInfoButtonBgImage"] forState:UIControlStateNormal];
    [self.seekoutTypeButton resetSize:CGSizeMake(300, 42)];
    [self.seekoutTypeButton setCenter:CGPointMake([self.view getWidth]/2, [self.seekoutContentTextView getOriginY] + [self.seekoutContentTextView getHeight] + 13/2 + [self.seekoutTypeButton getHeight]/2)];
    
    self.seekoutTypeIcon = [[UIImageView alloc]init];
    [self.seekoutTypeIcon setImage:[UIImage imageNamed:@"HPSeekoutInfoCategoriesButtonIcon"]];
    [self.seekoutTypeIcon resetSize:CGSizeMake(24, 24)];
    [self.seekoutTypeIcon setCenter:CGPointMake([self.seekoutTypeButton getHeight]/2, [self.seekoutTypeButton getHeight]/2)];
    [self.seekoutTypeButton addSubview:self.seekoutTypeIcon];
    
    self.seekoutTypeLabel = [[UILabel alloc] init];
    [self.seekoutTypeLabel setBackgroundColor:[UIColor clearColor]];
    [self.seekoutTypeLabel resetSize:CGSizeMake([self.seekoutTypeButton getWidth]/2, [self.seekoutTypeButton getHeight])];
    self.seekoutTypeLabel.numberOfLines = 1;

    [self refreshSeekoutTypeLabel];
    
    [self.seekoutTypeLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                   green:188.0f / 255.0f
                                                    blue:235.0f / 255.0f
                                                        alpha:1]];
    [self.seekoutTypeLabel setFont:[UIFont systemFontOfSize:16]];
    [self.seekoutTypeLabel sizeToFit];
    [self.seekoutTypeLabel resetOrigin:CGPointMake([self.seekoutTypeIcon getOriginX] + [self.seekoutTypeIcon getWidth] + 10, [self.seekoutTypeButton getHeight]/2 - [self.seekoutTypeLabel getHeight]/2)];
//    [self.seekoutTypeLabel setCenter:CGPointMake([self.seekoutTypeButton getWidth]/2, [self.seekoutTypeButton getHeight]/2)];
    [self.seekoutTypeButton addSubview:self.seekoutTypeLabel];
    
    
    
    
    
    [self.seekoutTypeButton addTarget:self action:@selector(didClickTypeButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.seekoutTypeButton];
    
    self.seekoutPostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.seekoutPostButton setTitle:@"Post" forState:UIControlStateNormal];
    [self.seekoutPostButton setBackgroundImage:[UIImage imageNamed:@"HPSeekoutPostButton"] forState:UIControlStateNormal];
    [self.seekoutPostButton resetSize:CGSizeMake(300, 42)];
    [self.seekoutPostButton setCenter:CGPointMake([self.view getWidth]/2, [self.seekoutTypeButton getCenterY] + [self.seekoutTypeButton getHeight] + 13/2)];
    [self.seekoutPostButton addTarget:self action:@selector(didClickPostButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.seekoutPostButton];

    
    
//    self.seekoutLanguageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.seekoutLanguageButton setBackgroundImage:[UIImage imageNamed:@"HPSeekoutInfoButtonBgImage"] forState:UIControlStateNormal];
//    [self.seekoutLanguageButton resetSize:CGSizeMake(300, 42)];
//    [self.seekoutLanguageButton setCenter:CGPointMake([self.view getWidth]/2, [self.seekoutTypeButton getOriginY] + [self.seekoutTypeButton getHeight] + 13/2 + [self.seekoutLanguageButton getHeight]/2)];
//    
//    
//    self.seekoutLanguageIcon = [[UIImageView alloc]init];
//    [self.seekoutLanguageIcon setImage:[UIImage imageNamed:@"HPSeekoutInfoLanguageButtonIcon"]];
//    [self.seekoutLanguageIcon resetSize:CGSizeMake(24, 24)];
//    [self.seekoutLanguageIcon setCenter:CGPointMake([self.seekoutTypeButton getHeight]/2, [self.seekoutTypeButton getHeight]/2)];
//
//    [self.seekoutLanguageButton addSubview:self.seekoutLanguageIcon];
//    [self.view addSubview:self.seekoutLanguageButton];
//    
//    
//    self.seekoutLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.seekoutLocationButton setBackgroundImage:[UIImage imageNamed:@"HPSeekoutInfoButtonBgImage"] forState:UIControlStateNormal];
//    [self.seekoutLocationButton resetSize:CGSizeMake(300, 42)];
//    [self.seekoutLocationButton setCenter:CGPointMake([self.view getWidth]/2, [self.seekoutLanguageButton getOriginY] + [self.seekoutLanguageButton getHeight] + 13/2 + [self.seekoutLocationButton getHeight]/2)];
//    
//    
//    self.seekoutLocationIcon = [[UIImageView alloc]init];
//    [self.seekoutLocationIcon setImage:[UIImage imageNamed:@"HPSeekoutInfoLocationButtonIcon"]];
//    [self.seekoutLocationIcon resetSize:CGSizeMake(24, 24)];
//    [self.seekoutLocationIcon setCenter:CGPointMake([self.seekoutTypeButton getHeight]/2, [self.seekoutTypeButton getHeight]/2)];
//    
//    [self.seekoutLocationButton addSubview:self.seekoutLocationIcon];
//    [self.view addSubview:self.seekoutLocationButton];

}

- (void)refreshSeekoutTypeLabel
{
    if (self.seekoutType == people)
    {
        [self.seekoutTypeLabel setText:@"People Seekout"];
    }
    else if (self.seekoutType == tips)
    {
        [self.seekoutTypeLabel setText:@"Tips Seekout"];
    }
    else if (self.seekoutType == events)
    {
        [self.seekoutTypeLabel setText:@"Events Seekout"];
    }
}

- (void)initTableView
{
    self.seekoutTypeTableView = [[UITableView alloc] init];
    [self.seekoutTypeTableView resetSize:CGSizeMake([self.view getWidth]*2/3, [self.seekoutContentTextView getHeight])];
    [self.seekoutTypeTableView setCenter:CGPointMake([self.view getWidth]/2, [self.view getHeight]/2)];
    self.seekoutTypeTableView.tableFooterView = [[UIView alloc] init];
    self.seekoutTypeTableView.scrollEnabled = NO;
    self.seekoutTypeTableView.delegate = self;
    self.seekoutTypeTableView.dataSource = self;
    [self.seekoutTypeTableView setSeparatorInset:UIEdgeInsetsZero];
    
    UIView *headerView = [[UIView alloc] init];
    [headerView setFrame:CGRectMake(0, 0, [self.seekoutTypeTableView getWidth], [self.seekoutTypeTableView getHeight]/4)];
    [headerView setBackgroundColor:[UIColor colorWithRed:48.0f / 255.0f
                                                   green:188.0f / 255.0f
                                                    blue:235.0f / 255.0f
                                                   alpha:1]];
    UILabel *headerLabel = [[UILabel alloc] init];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [headerLabel setTextColor:[UIColor whiteColor]];
    [headerLabel resetSize:CGSizeMake([self.seekoutTypeTableView getWidth], [self.seekoutTypeTableView getHeight])];
    [headerLabel setText:@"Seekout Category"];
    [headerLabel setFont:[UIFont systemFontOfSize:20]];
    headerLabel.numberOfLines = 1;
    [headerLabel sizeToFit];
    [headerLabel resetCenter:CGPointMake([headerView getWidth]/2, [headerView getHeight]/2)];
    [headerView  addSubview:headerLabel];
    
    self.seekoutTypeTableView.tableHeaderView = headerView;


 
}

- (void)removeTableView
{
    if([self.seekoutTypeTableView isDescendantOfView:self.view])
    {
        [self.seekoutTypeTableView removeFromSuperview];
    }
    if([self.blurredBackgroundImageView isDescendantOfView:self.view])
    {
        [self.blurredBackgroundImageView removeFromSuperview];
    }
}


- (void)blurBackground
{
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    backgroundImage = [backgroundImage applyLightEffect];
    self.blurredBackgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    [self.view addSubview:self.blurredBackgroundImageView];
    
}



#pragma mark - Keyboard Dismiss
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    [self.seekoutContentTextView resignFirstResponder];

}

#pragma mark - button event
- (void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickTypeButton
{
    
    [self blurBackground];
    [self.view addSubview:self.seekoutTypeTableView];
}

- (void)didClickPostButton
{
    NSString *seekoutContentText = self.seekoutContentTextView.text;
    if([seekoutContentText length] <= 0)
    {
        self.postFailedAlertView = [[UIAlertView alloc]  initWithTitle:@"Oops.." message:@"pleas say somthing before you say somethig" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.postFailedAlertView show];
    }

    [self postRequest];
    
}

#pragma mark - http request
-(void)postRequest
{
    
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@sid=%@",SEEKOUT_CREATE_URL, self.sid] ];
    NSString *seekoutContentText = self.seekoutContentTextView.text;
    
    
    
    //content=test%20test%20test&towhom=All&towhere=All%20cities&country=China&city=Shanghai&type=0&hasmedia=0&
//    NSDictionary *postDictionary = @{
//                                     @"content":seekoutContentText,
//                                     @"towhom":@"All",
//                                     @"towhere":@"Allcities",
//                                     @"country":@"China",
//                                     @"city":@"Shanghai",
//                                     @"type":@0,
//                                     @"hasmedia":@0
//                                     };
    
//    NSData *postData = [NSKeyedArchiver ar:postDictionary];
//    NSString *strData = [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
//    NSLog(@"!!!%@",strData);
    NSData *postData = [[NSString stringWithFormat:@"content=%@&towhom=%@&towhere=%@&country=%@&city=%@&type=%d&hasmedia=%@&",seekoutContentText,@"All",@"All cities",@"China",@"Shanghai",self.seekoutType,@0] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
        NSLog(@"%@",request);

    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //connection successed
        if([data length] > 0 && connectionError == nil)
        {
            NSError *e = nil;
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            
            NSLog(@"%@",dataDict);
            //register successed
            if([[dataDict objectForKey:@"code"] isEqualToString:@"10000"])
            {
                self.postSuccessAlertView = [[UIAlertView alloc]  initWithTitle:@"success" message:@"Create seekout ok" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [self.postSuccessAlertView show];
            }
            
            //reigister failed
            else if([[dataDict objectForKey:@"code"] isEqualToString:@"14009"])
            {
                self.postFailedAlertView = [[UIAlertView alloc]  initWithTitle:@"failed" message:@"Create seekout failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [self.postFailedAlertView show];
            }
        }
        //connection failed
        else if (connectionError != nil)
        {
            self.postFailedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"connection error." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.postFailedAlertView show];
            
        }
        //unknow error
        else
        {
            NSLog(@"%@",data);
            self.postFailedAlertView = [[UIAlertView alloc]  initWithTitle:@"Oops.." message:@"something wrong..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.postFailedAlertView show];
        }
        
        
    }];

    
    
    
    
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == self.postSuccessAlertView.cancelButtonIndex){
        [self didClickBackButton];
    }
}


#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.seekoutTypeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"seekoutType";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.seekoutTypeArray objectAtIndex:indexPath.row];
    [cell setBackgroundColor:[UIColor colorWithRed:247.0f / 255.0f
                                            green:247.0f / 255.0f
                                             blue:247.0f / 255.0f
                                             alpha:1]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                green:188.0f / 255.0f
                                                 blue:235.0f / 255.0f
                                                 alpha:1]];
    UIImageView *typeIcon = nil;
    if (indexPath.row == 0)
    {
        typeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HPSeekoutTypePeopleButton"]];
    }
    else if (indexPath.row == 1)
    {
        typeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HPSeekoutTypeLifeTipsButton"]];
    }
    else if (indexPath.row == 2)
    {
        typeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HPSeekoutTypeEventsButton"]];
    }
    [typeIcon setCenter:CGPointMake(20, [cell getHeight]/2)];
    [cell.contentView addSubview:typeIcon];
    
    return cell;
    
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0)
    {
        //people
        self.seekoutType = people;
    }
    else if(indexPath.row == 1)
    {
        //tips
        self.seekoutType = tips;
    }
    else if(indexPath.row ==2)
    {
        //events
        self.seekoutType = events;
    }
    [self refreshSeekoutTypeLabel];
    
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(removeTableView) userInfo:nil repeats:NO];
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self.seekoutTypeTableView getHeight] / 4;
}



@end
