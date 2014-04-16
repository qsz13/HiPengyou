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

@interface HPSeekoutCardView ()

@property (strong, atomic) UIButton *viewMoreButton;
@property (strong, atomic) UIView *seekoutContentView;
@property (strong, atomic) UILabel *seekoutAuthorNameLabel;
@property (strong, atomic) UILabel *seekoutTimeLabel;
@property (strong, atomic) UILabel *seekoutContentLabel;
@property (strong, atomic) UIImageView *seekoutAuthorFaceImageView;
@property (strong, atomic) UIImageView *seekoutTypeImageView;
@property (strong, atomic) UIButton *bgButton;

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
    [self.seekoutAuthorNameLabel setText:self.seekoutData.author];
//    [self.seekoutAuthorNameLabel setText:@"Tina Chou"];
    self.seekoutAuthorNameLabel.numberOfLines = 0;
    [self.seekoutAuthorNameLabel setTextColor:[UIColor colorWithRed:171.0f/255.0f green:104.0f/255.0f blue:102.0f/255.0f alpha:1]];
    [self.seekoutAuthorNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.seekoutAuthorNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [self.seekoutAuthorNameLabel sizeToFit];
    [self.seekoutAuthorNameLabel setCenter:CGPointMake([self getWidth]/2, [self getHeight]*0.1)];
    [self addSubview:self.seekoutAuthorNameLabel];
    
    self.seekoutTimeLabel = [[UILabel alloc] init];
    [self.seekoutTimeLabel setText:self.seekoutData.time];
//    [self.seekoutTimeLabel setText:@"01 Mar 04:25pm"];
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
    self.seekoutTypeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HPSeekoutTypePeopleImage"]];
    [self.seekoutTypeImageView setFrame:CGRectMake(20, 0, 29, 41)];
    [self addSubview:self.seekoutTypeImageView];
    
    self.seekoutAuthorFaceImageView = [[UIImageView alloc] init];
    [self.seekoutAuthorFaceImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.seekoutData.faceURL]]]];
    [self.seekoutAuthorFaceImageView setImage:self.seekoutData.faceImage];
    [self.seekoutAuthorFaceImageView resetSize:CGSizeMake(78,78)];
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
    
//    NSLog(@"seekoutAuthorFaceImageView: %f, %f, %f, %f",
//          [self.seekoutAuthorFaceImageView getOriginX],
//          [self.seekoutAuthorFaceImageView getOriginY],
//          [self.seekoutAuthorFaceImageView getWidth],
//          [self.seekoutAuthorFaceImageView getHeight]);
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
    
    [self initLabel];
    [self initImageView];
    [self initContentView];
    [self initButton];
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

@end
