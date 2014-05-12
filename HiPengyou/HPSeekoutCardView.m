//
//  HPSeekoutCardView.m
//  HiPengyou
//
//  Created by Daniel Qiu on 4/3/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPSeekoutCardView.h"
#import "UIView+Resize.h"
#import "HPSeekoutDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "HPProfileViewController.h"

@interface HPSeekoutCardView ()

@property (strong, nonatomic) UIButton *viewMoreButton;
@property (strong, nonatomic) UIView *seekoutContentView;
@property (strong, nonatomic) UILabel *seekoutAuthorNameLabel;
@property (strong, nonatomic) UILabel *seekoutTimeLabel;
@property (strong, nonatomic) UILabel *seekoutContentLabel;
@property (strong, nonatomic) UIImageView *seekoutAuthorFaceImageView;
@property (strong, nonatomic) UIButton *seekoutAuthorFaceButton;
@property (strong, nonatomic) UIImageView *seekoutTypeImageView;
@property (strong, nonatomic) UIButton *bgButton;
@property NSInteger userID;


@end


@implementation HPSeekoutCardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBackground];
        
        
    }
    return self;
}




#pragma mark - UI init
- (void)initBackground
{
    [self setBackgroundColor:[UIColor colorWithRed:244.0f / 255.0f
                                             green:244.0f / 255.0f
                                              blue:244.0f / 255.0f
                                             alpha:1]];
}


- (void)initLabel
{
    self.seekoutAuthorNameLabel = [[UILabel alloc] init];
    [self.seekoutAuthorNameLabel resetSize:CGSizeMake(500, 30)];
    [self.seekoutAuthorNameLabel setText:self.seekoutData.author.username];
    self.seekoutAuthorNameLabel.numberOfLines = 0;
    [self.seekoutAuthorNameLabel setTextColor:[UIColor colorWithRed:171.0f/255.0f green:104.0f/255.0f blue:102.0f/255.0f alpha:1]];
    [self.seekoutAuthorNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.seekoutAuthorNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [self.seekoutAuthorNameLabel sizeToFit];
    [self.seekoutAuthorNameLabel setCenter:CGPointMake([self getWidth]/2, [self getHeight]*0.1)];
    [self addSubview:self.seekoutAuthorNameLabel];

    self.seekoutTimeLabel = [[UILabel alloc] init];
    NSLog(@"%@",self.seekoutData.time);
    [self.seekoutTimeLabel setText:self.seekoutData.time];
    
    [self.seekoutTimeLabel resetSize:CGSizeMake(200, 30)];
    self.seekoutTimeLabel.numberOfLines = 1;
    
    [self.seekoutTimeLabel setTextColor:[UIColor colorWithRed:144.0f/255.0f green:150.0f/255.0f blue:157.0f/255.0f alpha:1]];
    [self.seekoutTimeLabel setBackgroundColor:[UIColor clearColor]];
    [self.seekoutTimeLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13]];
    [self.seekoutTimeLabel sizeToFit];
    [self.seekoutTimeLabel setCenter:CGPointMake([self getWidth]/2, [self.seekoutAuthorNameLabel getCenterY] + 33/2)];
    
    [self addSubview:self.seekoutTimeLabel];
}

- (void)initImageView
{
    if (self.seekoutData.type == people)
    {
        self.seekoutTypeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HPSeekoutTypePeopleImage"]];
    }
    else if (self.seekoutData.type == tips)
    {
        self.seekoutTypeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HPSeekoutTypeTipsImage"]];
    }
    else if (self.seekoutData.type == events)
    {
        self.seekoutTypeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HPSeekoutTypeEventsImage"]];
    }
    [self.seekoutTypeImageView setFrame:CGRectMake(20, 0, 29, 41)];
    [self addSubview:self.seekoutTypeImageView];
    
    self.seekoutAuthorFaceImageView = [[UIImageView alloc] init];
    [self.seekoutAuthorFaceImageView setImageWithURL:self.seekoutData.author.userFaceURL  placeholderImage:[UIImage imageNamed:@"HPDefaultFaceImage"]];
    [self.seekoutAuthorFaceImageView resetSize:CGSizeMake(78,78)];
    
    //make the face image to be circle
    [self.seekoutAuthorFaceImageView.layer setMasksToBounds:YES];
    [self.seekoutAuthorFaceImageView.layer setCornerRadius:self.seekoutAuthorFaceImageView.frame.size.width / 2];
    
    if ([self getHeight] < 630/2)
    {
        [self.seekoutAuthorFaceImageView setCenter:CGPointMake([self getWidth]/2, [self getHeight]*0.3)];
    }
    else
    {
        [self.seekoutAuthorFaceImageView setCenter:CGPointMake([self getWidth]/2, [self getHeight]*0.35)];
    }
    
    [self addSubview:self.seekoutAuthorFaceImageView];
    
}

- (void)initContentView
{
    self.seekoutContentView = [[UIView alloc] init];
    [self.seekoutContentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"HPSeekoutContentBgImage"]]];
    [self.seekoutContentView setFrame:CGRectMake(27, [self.seekoutAuthorFaceImageView getOriginY]+[self.seekoutAuthorFaceImageView getHeight]+5, 208, 117)];
    
    self.seekoutContentLabel = [[UILabel alloc] init];
    [self.seekoutContentLabel setBackgroundColor:[UIColor clearColor]];
    [self.seekoutContentLabel resetSize:CGSizeMake([self.seekoutContentView getWidth]-2*10, [self.seekoutContentView getHeight])];
    self.seekoutContentLabel.numberOfLines = 4;
    [self.seekoutContentLabel setText:self.seekoutData.content];
    
    [self.seekoutContentLabel setTextColor:[UIColor colorWithRed:144.0f/255.0f green:150.0f/255.0f blue:157.0f/255.0f alpha:1]];
    [self.seekoutContentLabel setFont:[UIFont systemFontOfSize:16]];
    [self.seekoutContentLabel sizeToFit];
    [self.seekoutContentLabel setCenter:CGPointMake([self.seekoutContentView getWidth]/2, [self.seekoutContentView getHeight]/2)];
    [self.seekoutContentView addSubview:self.seekoutContentLabel];
    
    [self addSubview:self.seekoutContentView];
}

- (void)initButton
{
    //face button
    self.seekoutAuthorFaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.seekoutAuthorFaceButton setFrame:self.seekoutAuthorFaceImageView.frame];
    [self.seekoutAuthorFaceButton.layer setMasksToBounds:YES];
    [self.seekoutAuthorFaceButton.layer setCornerRadius:self.seekoutAuthorFaceImageView.frame.size.width / 2];
    [self.seekoutAuthorFaceButton addTarget:self action:@selector(didClickAuthorFaceButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.seekoutAuthorFaceButton];
    
    //view more button
    self.viewMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.viewMoreButton setBackgroundImage:[UIImage imageNamed:@"HPReplyButton"] forState:UIControlStateNormal];
    [self.viewMoreButton setTitle:@"View More" forState:UIControlStateNormal];
    [self.viewMoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.viewMoreButton resetSize:CGSizeMake(126, 36)];
    if([self getHeight] < 630/2)
    {
        [self.viewMoreButton setCenter:CGPointMake([self getWidth]/2, [self.seekoutContentView getOriginY]+[self.seekoutContentView getHeight]+9+[self.viewMoreButton getHeight]/2)];
    }
    else
    {
        [self.viewMoreButton setCenter:CGPointMake([self getWidth]/2, [self.seekoutContentView getOriginY]+[self.seekoutContentView getHeight]+28+[self.viewMoreButton getHeight]/2)];
    }
    [self.viewMoreButton addTarget:self
                            action:@selector(didClickViewMoreButton:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.viewMoreButton];
    
    
}

#pragma mark - Load Seekout Data
- (void)loadData:(HPSeekout*)seekout
{
    self.seekoutData = seekout;
    
    [self initData];
    [self initLabel];
    [self initImageView];
    [self initContentView];
    [self initButton];
}

- (void)initData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.userID = [userDefaults integerForKey:@"id"];

}

#pragma mark - Add Button Event
- (void)addViewMoreButtonAction:(SEL)selector
{
    [self.viewMoreButton addTarget:self
                            action:selector
                  forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClickViewMoreButton:(UIButton *)sender
{
    HPSeekoutDetailViewController *vc = [[HPSeekoutDetailViewController alloc] initWithSeekoutData:self.seekoutData];
    UINavigationController *nc = (UINavigationController *)[[UIApplication sharedApplication] delegate].window.rootViewController;
    [nc pushViewController:vc animated:YES];
    
}

- (void)didClickAuthorFaceButton
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
//    HPUser *user = [[HPUser alloc]init];
//    [user setUsername:self.seekoutData.author];
//    [user setUserFaceURL:self.seekoutData.faceImageURL];
//    [profileViewController setProfileUserID:self.seekoutData.authorID];
    UINavigationController *navigationController = (UINavigationController *)[[UIApplication sharedApplication] delegate].window.rootViewController;
    [navigationController pushViewController:profileViewController animated:YES];
    
}

@end
