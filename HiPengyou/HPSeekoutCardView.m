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

@property (strong, atomic) UIButton *replyButton;
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
    [self.seekoutAuthorFaceImageView setImage:[UIImage imageNamed:@"avatar"]];
    [self.seekoutAuthorFaceImageView resetSize:CGSizeMake(78,78)];
    if([self getHeight] < 630/2)
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
//    [self.seekoutContentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"HPSeekoutContentBgImage"]]];
    [self.seekoutContentView setFrame:CGRectMake(27, [self.seekoutAuthorFaceImageView getOriginY]+[self.seekoutAuthorFaceImageView getHeight]+5, 208, 117)];
    
    // Add bg Button
    self.bgButton = [[UIButton alloc] initWithFrame:self.seekoutContentView.bounds];
    [self.bgButton setBackgroundImage:[UIImage imageNamed:@"HPSeekoutContentBgImage"] forState:UIControlStateNormal];
    [self.bgButton addTarget:self
                      action:@selector(didClickContentBgButton:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.seekoutContentView addSubview:self.bgButton];
    
    self.seekoutContentLabel = [[UILabel alloc] init];
    [self.seekoutContentLabel setBackgroundColor:[UIColor clearColor]];
    [self.seekoutContentLabel resetSize:CGSizeMake([self.seekoutContentView getWidth]-2*10, [self.seekoutContentView getHeight])];
    self.seekoutContentLabel.numberOfLines = 4;
    [self.seekoutContentLabel setText:self.seekoutData.content];
//    [self.seekoutContentLabel setText:@"kasfasl;dfjknckashdfkljhsdflkjahsdlfkjahsldkfjhalksjdfhlaksjdfhal;skfjnc;alksdjncalkdjfncalkdjsfcnaldjkfanfjklncfjalkfdsjcnladksjfcnladskjf"];
    [self.seekoutContentLabel setTextColor:[UIColor colorWithRed:144.0f/255.0f green:150.0f/255.0f blue:157.0f/255.0f alpha:1]];
    [self.seekoutContentLabel setFont:[UIFont systemFontOfSize:16]];
    [self.seekoutContentLabel sizeToFit];
    [self.seekoutContentLabel setCenter:CGPointMake([self.seekoutContentView getWidth]/2, [self.seekoutContentView getHeight]/2)];
    [self.seekoutContentView addSubview:self.seekoutContentLabel];
    
    [self addSubview:self.seekoutContentView];
}

- (void)initButton
{
    self.replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.replyButton setBackgroundImage:[UIImage imageNamed:@"HPReplyButton"] forState:UIControlStateNormal];
    [self.replyButton setTitle:@"I can help it" forState:UIControlStateNormal];
    [self.replyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.replyButton resetSize:CGSizeMake(126, 36)];
    if([self getHeight] < 630/2)
    {
        [self.replyButton setCenter:CGPointMake([self getWidth]/2, [self.seekoutContentView getOriginY]+[self.seekoutContentView getHeight]+9+[self.replyButton getHeight]/2)];
    }
    else
    {
        [self.replyButton setCenter:CGPointMake([self getWidth]/2, [self.seekoutContentView getOriginY]+[self.seekoutContentView getHeight]+28+[self.replyButton getHeight]/2)];
    }
    [self addSubview:self.replyButton];
    
    
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

#pragma mark - Button Event
- (void)didClickContentBgButton:(UIButton *)sender
{
    HPSeekoutDetailViewController *vc = [[HPSeekoutDetailViewController alloc] init];
}

@end
