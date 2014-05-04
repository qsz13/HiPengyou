//
//  HPSeekoutReplyTableViewCell.m
//  HiPengyou
//
//  Created by Tom Hu on 4/11/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPSeekoutCommentTableViewCell.h"
#import "UIView+Resize.h"
#import "UIImageView+AFNetworking.h"


@interface HPSeekoutCommentTableViewCell ()

@property (strong, nonatomic) HPSeekoutComment *comment;
@property (strong, nonatomic) UIImageView *faceImageView;
@property (strong, nonatomic) UILabel *authorNameLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *contentLabel;


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
        [self initFaceImageView];
        [self initAuthorNameLabel];
        [self initTimeLabel];
        [self initContent];
        
//        [self.]
        
        
        // Set Style
//        self.transform = CGAffineTransformMakeRotation(M_PI / 2);
//        [self resetWidthByOffset:20];
//        self.frame = frame;
//        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
//        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
//        [self setSelectionStyle:UITableViewCellSelectionStyleNone];s
        
//        HPSeekoutCardView *seekoutCardView = [[HPSeekoutCardView alloc] initWithFrame:frame];
//        [seekoutCardView resetOriginXByOffset:10];
//        [seekoutCardView loadData:seekout];
        
        // Clear Background Color
//        self.contentView.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor clearColor];
        
//        // Bg View
//        UIView *bgView = [[UIView alloc] initWithFrame:frame];
//        [bgView resetWidthByOffset:20];
//        bgView.backgroundColor = [UIColor clearColor];
        
        // Add Seekout Card View To Content View
//        [bgView addSubview:seekoutCardView];
//        [self.contentView addSubview:bgView];
        
    }
    return self;
}


- (void)initFaceImageView
{
    self.faceImageView = [[UIImageView alloc]init];
   
    [self.faceImageView setImageWithURL:self.comment.faceImageURL];
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
    [self.authorNameLabel setText:self.comment.author];
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
    [self.timeLabel resetOrigin:CGPointMake([self.authorNameLabel getOriginX]+[self.authorNameLabel getWidth] + 10, [self getHeight]/10)];
    [self addSubview:self.timeLabel];
    
}

- (void)initContent
{
    
    self.contentLabel = [[UILabel alloc]init];
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

@end
