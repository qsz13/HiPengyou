//
//  HPProfileSeekoutTableViewCell.m
//  HiPengyou
//
//  Created by Daniel Qiu on 4/24/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPProfileSeekoutTableViewCell.h"
#import "HPSeekoutType.h"
#import "UIView+Resize.h"

@interface HPProfileSeekoutTableViewCell ()

@property (strong, atomic) UIImageView *seekoutTypeImage;
@property (strong, atomic) HPSeekout *seekout;
@property (strong, atomic) UILabel *seekoutContentLabel;
    
@end

@implementation HPProfileSeekoutTableViewCell

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
               data:(HPSeekout*)seekout
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.seekout = seekout;
        self.frame = frame;
        [self initSeekoutTypeImage];
        [self initSeekoutContentLabel];
        
        
        
//        // Set Style
//        self.transform = CGAffineTransformMakeRotation(M_PI / 2);
//        [self resetWidthByOffset:20];
//        self.frame = frame;
//        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
//        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
//        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
//        
//        HPSeekoutCardView *seekoutCardView = [[HPSeekoutCardView alloc] initWithFrame:frame];
//        [seekoutCardView resetOriginXByOffset:10];
//        [seekoutCardView loadData:seekout];
//        
//        // Clear Background Color
//        self.contentView.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor clearColor];
//        
//        // Bg View
//        UIView *bgView = [[UIView alloc] initWithFrame:frame];
//        [bgView resetWidthByOffset:20];
//        bgView.backgroundColor = [UIColor clearColor];
//        
//        // Add Seekout Card View To Content View
//        [bgView addSubview:seekoutCardView];
//        [self.contentView addSubview:bgView];
    }
    return self;
}

- (void)initSeekoutTypeImage
{
    if(self.seekout.type == people)
    {
        self.seekoutTypeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HPSeekoutTypePeopleImage"]];
        
    }
    else if(self.seekout.type == tips)
    {
        self.seekoutTypeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HPSeekoutTypeTipsImage"]];
    }
    else if(self.seekout.type == events)
    {
        self.seekoutTypeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HPSeekoutTypeEventsImage"]];
    }
//    NSLog(@"%d",self.seekout.type);
    [self.contentView addSubview:self.seekoutTypeImage];
    
}

- (void)initSeekoutContentLabel
{
    self.seekoutContentLabel = [[UILabel alloc] init];

    [self.seekoutContentLabel setBackgroundColor:[UIColor clearColor]];
    [self.seekoutContentLabel resetSize:CGSizeMake([self.contentView getHeight],[self.contentView getWidth])];
    [self.seekoutContentLabel setText:self.seekout.content];
    [self.seekoutContentLabel setNumberOfLines:1];
    [self.seekoutContentLabel setTextColor:[UIColor colorWithRed:48.0f / 255.0f
                                                            green:188.0f / 255.0f
                                                             blue:235.0f / 255.0f
                                                            alpha:1]];
    [self.seekoutContentLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [self.seekoutContentLabel sizeToFit];
    [self.seekoutContentLabel setCenter:CGPointMake([self.contentView getWidth]/2, [self.contentView getHeight]/2)];
    [self.contentView addSubview:self.seekoutContentLabel];
    
    


}

@end
