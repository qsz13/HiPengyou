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
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "HPProfileViewController.h"
#import "HPSeekoutComment.h"
#import "HPAPIURL.h"
#import "HPUser.h"

@interface HPSeekoutDetailViewController ()

// Data
@property (strong, nonatomic) HPSeekout *seekoutData;
@property (strong, nonatomic) NSString *sid;
@property NSInteger userID;

// UI
@property (strong, nonatomic) UIView *customNavBarView;

@property (strong, nonatomic) UIView *seekoutDetailView;
@property (strong, nonatomic) UILabel *seekoutContentLabel;
@property (strong, nonatomic) UIImageView *faceImageView;
@property (strong, nonatomic) UIButton *faceImageButton;
@property (strong, nonatomic) UILabel *seekoutAuthorNameLabel;

@property (strong, nonatomic) UITableView *seekoutCommentTableView;
@property (strong, nonatomic) NSMutableArray *seekoutCommentArray;

@property (strong, nonatomic) UIView *seekoutReplyView;
@property (strong, nonatomic) UITextView *seekoutReplyTextView;
@property (strong, nonatomic) UIButton *replyButton;

@property (strong, nonatomic) UIAlertView *connectionFaiedAlertView;


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
    [self.faceImageView setImageWithURL:self.seekoutData.author.userFaceURL  placeholderImage:[UIImage imageNamed:@"HPDefaultFaceImage"]];
    [self.faceImageView resetSize:CGSizeMake(100 / 2, 100 / 2)];
    [self.faceImageView resetOrigin:CGPointMake(10, [self.seekoutDetailView getHeight] - [self.faceImageView getHeight] - 10)];
    
    //make the face image to be circle
    [self.faceImageView.layer setMasksToBounds:YES];
    [self.faceImageView.layer setCornerRadius:self.faceImageView.frame.size.width / 2];
    [self.seekoutDetailView addSubview:self.faceImageView];

    //face Button
    self.faceImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.faceImageButton resetSize:CGSizeMake(100 / 2, 100 / 2)];
    [self.faceImageButton resetOrigin:CGPointMake(10, [self.seekoutDetailView getHeight] - [self.faceImageView getHeight] - 10)];
    [self.faceImageButton addTarget:self action:@selector(didClickFaceButton) forControlEvents:UIControlEventTouchUpInside];
    [self.seekoutDetailView addSubview:self.faceImageButton];
    
    // Author Name
    self.seekoutAuthorNameLabel = [[UILabel alloc] init];
    [self.seekoutAuthorNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.seekoutAuthorNameLabel setTextColor:[UIColor
                                               colorWithRed:171.0f/255.0f
                                               green:104.0f/255.0f
                                               blue:102.0f/255.0f
                                               alpha:1]];
    
    

    [self.seekoutAuthorNameLabel resetSize:CGSizeMake(500, 30)];
    [self.seekoutAuthorNameLabel setText:self.seekoutData.author.username];
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
    
    if ([self.seekoutCommentTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.seekoutCommentTableView setSeparatorInset:UIEdgeInsetsZero];
    }
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
    self.replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.replyButton setTitle:@"Send" forState:UIControlStateNormal];
    [self.replyButton sizeToFit];
    [self.replyButton setCenter:CGPointMake([self.view getWidth]-[self.replyButton getWidth]/2 - 10, [self.seekoutReplyView getHeight]/2)];
    [self.replyButton setTintColor:[UIColor whiteColor]];
    [self.replyButton addTarget:self action:@selector(didClickReplyButton) forControlEvents:UIControlEventTouchUpInside];
    
    // Seekout Reply Text Field
    self.seekoutReplyTextView = [[UITextView alloc] init];
    [self.seekoutReplyTextView setFrame:CGRectMake(10, 5, [self.seekoutReplyView getWidth]-20 - [self.replyButton getWidth] - 10, [self.seekoutReplyView getHeight]-10)];
    self.seekoutReplyTextView.delegate = self;
    [self.seekoutReplyTextView setBackgroundColor:[UIColor whiteColor]];
    
    // Add to Seekout Reply View
    [self.seekoutReplyView addSubview:self.seekoutReplyTextView];
    [self.seekoutReplyView addSubview:self.replyButton];
    
    
    // Add to View
    [self.view addSubview:self.seekoutReplyView];
}

#pragma mark - init Data
- (void)initData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sid = [userDefaults objectForKey:@"sid"];
    self.userID = [userDefaults integerForKey:@"id"];
    
}

- (void)initCommentData
{
    self.seekoutCommentArray = [[NSMutableArray alloc] init];
    [self requestForComment];

    
    
}


#pragma mark - network request
- (void)requestForComment
{
    
    [NSString stringWithFormat:@"%@sid=%@&&seekoutId=%d&pageId=%d&giverid=%d&",COMMENT_LIST_URL,self.sid,self.seekoutData.seekoutID,0,self.userID];
    
    NSString *urlString = COMMENT_LIST_URL;
    NSString *sid = self.sid;
    NSNumber *seekoutID = [NSNumber numberWithInteger:self.seekoutData.seekoutID];
    NSNumber *pageID = @0;
    NSNumber *userID = [NSNumber numberWithInteger:self.userID];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *params = @{@"sid": sid,
                             @"seekoutId": seekoutID,
                             @"pageId": pageID,
                             @"giverid": userID};
    
    [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject[@"code"] isEqual:@"10000"])
        {
            NSDictionary *resultDict = [responseObject objectForKey:@"result"];
            
            NSArray *seekoutList = [resultDict objectForKey:@"Comment.list"];
            for (NSDictionary *c in seekoutList)
            {
                HPSeekoutComment *comment = [[HPSeekoutComment alloc]init];
                HPUser *user = [[HPUser alloc]init];
                [comment setCommentID:[[c objectForKey:@"id"] integerValue]];
                NSURL* faceURL = [[NSURL alloc] initWithString:[c objectForKey:@"face"]];
                
                [user setUserFaceURL:faceURL];
                [user setUserID:[[c objectForKey:@"authorid"] integerValue]];
                [user setUsername:[c objectForKey:@"author"]];
                [comment setAuthor:user];
                [comment setContent:[c objectForKey:@"content"]];
                [comment setIfLike:[[c objectForKey:@"iflike"] boolValue]];
                
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@", [c objectForKey:@"uptime"]] doubleValue]];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
                [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                [comment setTime:[dateFormatter stringFromDate:date]];
                
                [comment setLikeNumber:[[c objectForKey:@"likes"] integerValue]];
                [comment setHasMedia:[[c objectForKey:@"hasmedia"] boolValue]];
                NSURL* mediaURL = [[NSURL alloc] initWithString:[c objectForKey:@"mediaurl"]];
                [comment setMediaURL:mediaURL];
                
                
                [self.seekoutCommentArray addObject:comment];
                [self.seekoutCommentTableView reloadData];
            }
        }
        else
        {
            NSLog(@"JSON: %@", responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.connectionFaiedAlertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"connection error." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.connectionFaiedAlertView show];
    }];
    
}




#pragma mark - Button Event
- (void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Keyboard Dismiss
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.seekoutReplyTextView resignFirstResponder];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}



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

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    [self animateTextField: textView up: YES];

    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self animateTextField: textView up: NO];
}


- (void)animateTextField: (UITextView*) textField up: (BOOL) up
{
    const int movementDistance = 215; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    
    [UIView beginAnimations: @"MoveUITextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.seekoutReplyView.frame = CGRectOffset(self.seekoutReplyView.frame, 0, movement);
    [UIView commitAnimations];
}

#pragma mark - Button event
- (void)didClickReplyButton
{
    [self createComment];
}

- (void)didClickFaceButton
{
    HPProfileViewController *profileViewController = [[HPProfileViewController alloc]init];
    
    if(self.userID == self.seekoutData.author.userID)
    {
        [profileViewController setIsSelfUser:YES];
    }
    else
    {
        [profileViewController setIsSelfUser:NO];
        [profileViewController setProfileUserID:self.seekoutData.author.userID];
        
    }
    
    UINavigationController *navigationController = (UINavigationController *)[[UIApplication sharedApplication] delegate].window.rootViewController;
    [navigationController pushViewController:profileViewController animated:YES];

}

#pragma mark - network request
- (void)createComment
{
    NSString *urlString = [NSString stringWithFormat:@"%@sid=%@",CREATE_COMMENT_URL,self.sid];
    NSNumber *seekoutID = [NSNumber numberWithInteger:self.seekoutData.seekoutID];
    NSString *contentText = self.seekoutReplyTextView.text;
    NSNumber *hasMedia = @NO;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *params = @{@"seekoutId": seekoutID,
                             @"content": contentText,
                             @"hasmedia": hasMedia};

    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject[@"code"] isEqual:@"10000"])
        {
            
            
            [self requestForComment];
            [self.seekoutReplyTextView setText:@""];
            [self.seekoutReplyTextView resignFirstResponder];

        }
        else
        {
            NSLog(@"JSON: %@", responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.connectionFaiedAlertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"connection error." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.connectionFaiedAlertView show];
    }];
    
    
    
    
    
}





@end
