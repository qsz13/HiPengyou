//
//  HPSeekoutReplyTableViewCell.m
//  HiPengyou
//
//  Created by Tom Hu on 4/11/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPSeekoutCommentTableViewCell.h"
#import "UIView+Resize.h"
#import "HPAPIURL.h"
#import "UIImageView+AFNetworking.h"
#import "HPProfileViewController.h"


@interface HPSeekoutCommentTableViewCell ()

@property (strong, nonatomic) HPSeekoutComment *comment;
@property (strong, nonatomic) UIImageView *faceImageView;
@property (strong, nonatomic) UILabel *authorNameLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UIButton *faceButton;
@property (strong, nonatomic) UILabel *likeNumberLabel;
@property (strong, nonatomic) NSString *sid;
@property NSInteger userID;
@property (strong, nonatomic) UIAlertView *likeFailedAlertView;

@end

@implementation HPSeekoutCommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UI init

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              frame:(CGRect)frame
               data:(HPSeekoutComment *)comment
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.comment = comment;
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self initData];
        [self initFaceImageView];
        [self initAuthorNameLabel];
        [self initTimeLabel];
        [self initContent];
        [self initButton];
        [self initLikeNumberLabel];
        
    }
    return self;
}

- (void)initData
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sid = [userDefaults objectForKey:@"sid"];
    NSLog(@"%@",self.sid);
    self.userID = [userDefaults integerForKey:@"id"];
    
}


- (void)initFaceImageView
{
    self.faceImageView = [[UIImageView alloc]init];
   
    [self.faceImageView setImageWithURL:self.comment.author.userFaceURL  placeholderImage:[UIImage imageNamed:@"HPDefaultFaceImage"]];
    [self.faceImageView resetSize:CGSizeMake(40, 40)];
    [self.faceImageView setCenter:CGPointMake([self getWidth]/10, [self getHeight]/2)];
    [self.faceImageView.layer setMasksToBounds:YES];
    [self.faceImageView.layer setCornerRadius:[self.faceImageView getWidth]/2];
    [self addSubview:self.faceImageView];
}

- (void)initAuthorNameLabel
{
    self.authorNameLabel = [[UILabel alloc] init];
    [self.authorNameLabel resetSize:CGSizeMake(500, 30)];
    [self.authorNameLabel setText:self.comment.author.username];
    self.authorNameLabel.numberOfLines = 1;
    [self.authorNameLabel setTextColor:[UIColor colorWithRed:171.0f/255.0f green:104.0f/255.0f blue:102.0f/255.0f alpha:1]];
    [self.authorNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.authorNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];
    [self.authorNameLabel sizeToFit];
    [self.authorNameLabel resetOrigin:CGPointMake([self.faceImageView getOriginX]+[self.faceImageView getWidth] + 10, [self getHeight]/10)];
    [self addSubview:self.authorNameLabel];
}

- (void)initTimeLabel
{
    self.timeLabel = [[UILabel alloc] init];
    [self.timeLabel resetSize:CGSizeMake(500, 30)];
    [self.timeLabel setText:self.comment.time];
    self.timeLabel.numberOfLines = 1;
    [self.timeLabel setTextColor:[UIColor colorWithRed:144.0f/255.0f green:150.0f/255.0f blue:157.0f/255.0f alpha:1]];
    [self.timeLabel setBackgroundColor:[UIColor clearColor]];
    [self.timeLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:8]];
    [self.timeLabel sizeToFit];
    [self.timeLabel resetOrigin:CGPointMake([self.authorNameLabel getOriginX]+[self.authorNameLabel getWidth] + 10, [self.authorNameLabel getOriginY] + 2)];
    [self addSubview:self.timeLabel];
    
}

- (void)initContent
{
    
    self.contentLabel = [[UILabel alloc] init];
    [self.contentLabel resetSize:CGSizeMake(500, 30)];
    [self.contentLabel setText:self.comment.content];
    self.contentLabel.numberOfLines = 1;
    [self.contentLabel setTextColor:[UIColor colorWithRed:144.0f/255.0f green:150.0f/255.0f blue:157.0f/255.0f alpha:1]];
    [self.contentLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [self.contentLabel sizeToFit];
    [self.contentLabel resetOrigin:CGPointMake([self.authorNameLabel getOriginX], ([self getHeight]+[self.authorNameLabel getHeight])/2-[self.contentLabel getHeight]/2)];
    [self addSubview:self.contentLabel];
    
    
}

- (void)initButton
{
    //face button
    self.faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.faceButton setFrame:self.faceImageView.frame];
    [self.faceButton.layer setMasksToBounds:YES];
    [self.faceButton.layer setCornerRadius:[self.faceImageView getWidth]/2];
    [self.faceButton addTarget:self action:@selector(didClickFaceButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.faceButton];
    
    
    
    
    
    //like button
    self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeButton setFrame:CGRectMake([self.timeLabel getOriginX] + [self.timeLabel getWidth] + 50, [self getHeight]/2, 23, 20)];
    
    [self.likeButton addTarget:self action:@selector(didClickLikeButton) forControlEvents:UIControlEventTouchUpInside];
    
    if(self.comment.ifLike)
    {
        [self.likeButton setImage:[UIImage imageNamed:@"HPLikeButton"] forState:UIControlStateNormal];
    }
    else
    {
        [self.likeButton setImage:[UIImage imageNamed:@"HPUnlikeButton"] forState:UIControlStateNormal];
    }
    
    
    [self addSubview:self.likeButton];

}

- (void)initLikeNumberLabel
{
    self.likeNumberLabel = [[UILabel alloc]init];
    self.likeNumberLabel = [[UILabel alloc] init];
    [self.likeNumberLabel resetSize:CGSizeMake(500, 30)];
    [self.likeNumberLabel setText:[NSString stringWithFormat:@"%d",self.comment.likeNumber]];
    self.likeNumberLabel.numberOfLines = 1;
    [self.likeNumberLabel setTextColor:[UIColor colorWithRed:144.0f/255.0f green:150.0f/255.0f blue:157.0f/255.0f alpha:1]];
    [self.likeNumberLabel setBackgroundColor:[UIColor clearColor]];
    [self.likeNumberLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [self.likeNumberLabel sizeToFit];
    [self.likeNumberLabel resetOrigin:CGPointMake([self.likeButton getOriginX]+[self.likeButton getWidth]+5, [self getHeight]/2)];
    [self addSubview:self.likeNumberLabel];

}

#pragma mark - Button Event
- (void)didClickLikeButton
{

    [self.likeButton setImage:[UIImage imageNamed:@"HPLikeButton"] forState:UIControlStateNormal];
    self.comment.likeNumber++;
    [self.likeNumberLabel setText:[NSString stringWithFormat:@"%d",self.comment.likeNumber]];
    [self likeRequest];
}

- (void)didClickFaceButton
{
    HPProfileViewController *profileViewController = [[HPProfileViewController alloc]init];
    
    if(self.userID == self.comment.author.userID)
    {
        [profileViewController setIsSelfUser:YES];
    }
    else
    {
        [profileViewController setIsSelfUser:NO];
        [profileViewController setProfileUserID:self.comment.author.userID];
        
    }

    UINavigationController *navigationController = (UINavigationController *)[[UIApplication sharedApplication] delegate].window.rootViewController;
    [navigationController pushViewController:profileViewController animated:YES];
}

#pragma mark - Network Request
- (void)likeRequest
{
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@sid=%@",LIKE_CREATE_URL, self.sid]];
    NSLog(@"%@",[NSString stringWithFormat:@"%@sid=%@",LIKE_CREATE_URL, self.sid]);

    NSData *postData = [[NSString stringWithFormat:@"commentid=%d&giverid=%d&",self.comment.commentID,self.userID] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

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
            //register successed
            if([[dataDict objectForKey:@"code"] isEqualToString:@"10000"])
            {
            
            }

            //reigister failed
            else if([[dataDict objectForKey:@"code"] isEqualToString:@"14009"])
            {
                self.likeFailedAlertView = [[UIAlertView alloc]  initWithTitle:@"failed" message:@"Create seekout failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [self.likeFailedAlertView show];
            }
        }
        //connection failed
        else if (connectionError != nil)
        {
            self.likeFailedAlertView = [[UIAlertView alloc]initWithTitle:@"Oops.." message:@"connection error." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.likeFailedAlertView show];

        }
        //unknow error
        else
        {
            self.likeFailedAlertView = [[UIAlertView alloc]  initWithTitle:@"Oops.." message:@"something wrong..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.likeFailedAlertView show];
        }
        
        
    }];

}

@end
