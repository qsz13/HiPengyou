//
//  HPSeekoutDetailViewController.m
//  HiPengyou
//
//  Created by Tom Hu on 4/6/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPSeekoutDetailViewController.h"
#import "UIView+Resize.h"
#import "HPSeekoutCommentTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "HPSeekoutComment.h"
#import "HPAPIURL.h"

@interface HPSeekoutDetailViewController ()

// Data
@property (strong, atomic) HPSeekout *seekoutData;
@property (strong, atomic) NSString *sid;

// UI
@property (strong, atomic) UIView *customNavBarView;

@property (strong, atomic) UIView *seekoutDetailView;
@property (strong, atomic) UILabel *seekoutContentLabel;
@property (strong, atomic) UIImageView *faceImageView;
@property (strong, atomic) UILabel *seekoutAuthorNameLabel;

@property (strong, atomic) UITableView *seekoutCommentTableView;
@property (strong, atomic) NSMutableArray *seekoutCommentArray;

@property (strong, atomic) UIView *seekoutReplyView;
@property (strong, atomic) UITextField *seekoutReplyTextField;
@property (strong, atomic) UIButton *replyButton;

@property (strong, atomic) UIAlertView *connectionFaiedAlertView;
@property (strong, atomic) UIAlertView *replyAlertView;


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
    //Data Method
    [self initData];
    [self initCommentData];
    // UI Mehtods
    [self initView];
    [self initCustomNavBar];
    [self initSeekoutDetailView];
    [self initSeekoutCommentTableView];
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
    [self.seekoutContentLabel setFont:[UIFont systemFontOfSize:20]];
    [self.seekoutContentLabel sizeToFit];
    [self.seekoutContentLabel setCenter:CGPointMake([self.seekoutDetailView getWidth]/2, [self.faceImageView getOriginY]/2)];
    [self.seekoutDetailView addSubview:self.seekoutContentLabel];
    
    
    
    // Add to Seekout Detail View
    [self.seekoutDetailView addSubview:self.faceImageView];
    [self.seekoutDetailView addSubview:self.seekoutAuthorNameLabel];
    
    // Add to View
    [self.view addSubview:self.seekoutDetailView];
}

- (void)initSeekoutCommentTableView
{
    // init Seekout Reply Table View
    self.seekoutCommentTableView = [[UITableView alloc] initWithFrame:CGRectMake([self.seekoutDetailView getOriginX],
                                                                               [self.seekoutDetailView getOriginY] + [self.seekoutDetailView getHeight] + 35 / 2,
                                                                               [self.seekoutDetailView getWidth],
                                                                               [UIScreen mainScreen].bounds.size.height - 40 - [self.seekoutDetailView getOriginY] - [self.seekoutDetailView getHeight] - 35 / 2 - 8)
                                                              style:UITableViewStylePlain];
    
    // Set Delegate
    self.seekoutCommentTableView.delegate = self;
    self.seekoutCommentTableView.dataSource = self;
    
    [self.seekoutCommentTableView setSeparatorInset:UIEdgeInsetsZero];
    self.seekoutCommentTableView.tableFooterView = [[UIView alloc]init];
    
    // Add to View
    [self.view addSubview:self.seekoutCommentTableView];
}

- (void)initSeekoutReplyView
{
    // init Seekout Reply View
    self.seekoutReplyView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, [UIScreen mainScreen].bounds.size.width, 40)];
    [self.seekoutReplyView setBackgroundColor:[UIColor colorWithRed:49.0f / 255.0f
                                                             green:188.0f / 255.0f
                                                              blue:234.0f / 255.0f
                                                              alpha:1]];

    
    
    
    // Seekout Reply Button
    self.replyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.replyButton setTitle:@"Send" forState:UIControlStateNormal];
    [self.replyButton sizeToFit];
    [self.replyButton setCenter:CGPointMake([self.view getWidth]-[self.replyButton getWidth]/2 - 10, [self.seekoutReplyView getHeight]/2)];
    [self.replyButton setTintColor:[UIColor whiteColor]];
    [self.replyButton addTarget:self action:@selector(didClickReplyButton) forControlEvents:UIControlEventTouchUpInside];
    
    // Seekout Reply Text Field
    self.seekoutReplyTextField = [[UITextField alloc] init];
    [self.seekoutReplyTextField setFrame:CGRectMake(10, 5, [self.seekoutReplyView getWidth]-20 - [self.replyButton getWidth] - 10, [self.seekoutReplyView getHeight]-10)];
    self.seekoutReplyTextField.delegate = self;
    [self.seekoutReplyTextField setPlaceholder:@"I can help it"];
    [self.seekoutReplyTextField setBackgroundColor:[UIColor whiteColor]];
    
    // Add to Seekout Reply View
    [self.seekoutReplyView addSubview:self.seekoutReplyTextField];
    [self.seekoutReplyView addSubview:self.replyButton];
    
    
    // Add to View
    [self.view addSubview:self.seekoutReplyView];
}

#pragma mark - init Data
- (void)initData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sid = [userDefaults objectForKey:@"sid"];
    

}

- (void)initCommentData
{
    self.seekoutCommentArray = [[NSMutableArray alloc] init];
    [self requestForComment];

    
    
}


#pragma mark - network request
- (void)requestForComment
{
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@sid=%@&&seekoutId=%d&pageId=%d",COMMENT_LIST_URL,self.sid,self.seekoutData.seekoutID,0]];
    NSLog(@"%d",self.seekoutData.seekoutID);

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

                NSArray *seekoutList = [resultDict objectForKey:@"Comment.list"];
                for (NSDictionary *c in seekoutList)
                {
                    HPSeekoutComment *comment = [[HPSeekoutComment alloc]init];
                    [comment setCommentID:[[c objectForKey:@"id"] integerValue]];
                    NSURL* faceURL = [[NSURL alloc] initWithString:[c objectForKey:@"face"]];
                    [comment setFaceImageURL:faceURL];
                    [comment setContent:[c objectForKey:@"content"]];
                    [comment setAuthor:[c objectForKey:@"author"]];
                    [comment setAuthorID:[[c objectForKey:@"authorid"] integerValue]];
                    
                    
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@", [c objectForKey:@"uptime"]] doubleValue]];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
                    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                    [comment setTime:[dateFormatter stringFromDate:date]];
//                    NSLog(@"%d",[[c objectForKey:@"uptime"] integerValue]);
//                    NSLog(@"%@",date);
                    
                    [comment setLikeNumber:[[c objectForKey:@"likes"] integerValue]];
                    [comment setHasMedia:[[c objectForKey:@"hasmedia"] boolValue]];
                    NSURL* mediaURL = [[NSURL alloc] initWithString:[c objectForKey:@"mediaurl"]];
                    [comment setMediaURL:mediaURL];

                    
                    [self.seekoutCommentArray addObject:comment];
                    [self.seekoutCommentTableView reloadData];
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
    
    //callback
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}



// TODO - Add Data Source
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.seekoutCommentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    HPSeekoutComment *comment = [self.seekoutCommentArray objectAtIndex:indexPath.row];

    
    HPSeekoutCommentTableViewCell *cell = [[HPSeekoutCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SeekoutComment" frame:CGRectMake(0, 0, [self.view getWidth], 10) data:comment];
    
    


    return cell;
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

#pragma mark - Button event
- (void)didClickReplyButton
{
    [self createComment];
}

#pragma mark - network request
- (void)createComment
{
    
    NSString *replyContent = self.seekoutReplyTextField.text;
    if(replyContent.length <= 0)
    {
        self.replyAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"reply content cannot be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.replyAlertView show];

    }
    else
    {
        NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@sid=%@",CREATE_COMMENT_URL,self.sid]];
        
        
        NSData *postData = [[NSString stringWithFormat:@"seekoutId=%d&content=%@&hasmedia=%d&",self.seekoutData.seekoutID,replyContent,0] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        NSLog(@"%@",replyContent);
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            //connection successed
            if([data length] > 0 && connectionError == nil)
            {
                NSError *e = nil;
                NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
                //login successed
                if([[dataDict objectForKey:@"code"] isEqualToString:@"10000"])
                {
                    self.replyAlertView = [[UIAlertView alloc]initWithTitle:@"thanks" message:@"your reply has been sent" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [self.replyAlertView show];
                }
                //login failed
                else if([[dataDict objectForKey:@"code"] isEqualToString:@"10009"])
                {
                    self.connectionFaiedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"Seekout not exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [self.connectionFaiedAlertView show];
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
                NSLog(@"%@",data);
                self.connectionFaiedAlertView = [[UIAlertView alloc]  initWithTitle:@"Oops.." message:@"something wrong..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [self.connectionFaiedAlertView show];
            }
            
            
        }];

    }
    
    
    
    
    
}





@end
