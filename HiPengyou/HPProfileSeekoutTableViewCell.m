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

@property (strong, nonatomic) UIView *commentNumView;
@property (strong, nonatomic) HPSeekout *seekout;
@property (strong, nonatomic) UILabel *seekoutContentLabel;
@property (strong, nonatomic) UILabel *timeLabel;
    
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
        [self initCommentNumView];
        [self initSeekoutContentLabel];
        [self initTimeLabel];

    }
    return self;
}

- (void)initCommentNumView
{
    self.commentNumView = [[UIView alloc] init];
    [self.commentNumView setFrame:CGRectMake(0, 0, 60, [self getHeight])];
    [self.commentNumView setBackgroundColor:[UIColor colorWithRed:48.0f / 255.0f
                                                            green:188.0f / 255.0f
                                                             blue:235.0f / 255.0f
                                                            alpha:1]];
    
    UILabel *commentNum = [[UILabel alloc]init];

    
    [commentNum setBackgroundColor:[UIColor clearColor]];
    [commentNum resetSize:CGSizeMake([self.contentView getHeight],[self.contentView getWidth])];
    [commentNum setText:[NSString stringWithFormat:@"%d",self.seekout.commentNumber]];
    [commentNum setNumberOfLines:1];
    [commentNum setTextColor:[UIColor whiteColor]];
    [commentNum setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [commentNum sizeToFit];
    [commentNum setCenter:CGPointMake([self.commentNumView getWidth]/2, [self.commentNumView getHeight]/2)];

    
    
    
    [self.commentNumView addSubview:commentNum];
    [self addSubview:self.commentNumView];
    
}


- (void)initSeekoutContentLabel
{
    self.seekoutContentLabel = [[UILabel alloc] init];

    [self.seekoutContentLabel setBackgroundColor:[UIColor clearColor]];
    [self.seekoutContentLabel resetSize:CGSizeMake([self getWidth] - 60,[self getHeight])];
    [self.seekoutContentLabel setText:self.seekout.content];
    [self.seekoutContentLabel setNumberOfLines:0];
    [self.seekoutContentLabel setTextColor:[UIColor colorWithRed:144.0f/255.0f green:150.0f/255.0f blue:157.0f/255.0f alpha:1]];
    [self.seekoutContentLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [self.seekoutContentLabel sizeToFit];
    [self.seekoutContentLabel resetOrigin:CGPointMake(65, 5)];
    [self.contentView addSubview:self.seekoutContentLabel];

}

- (void)initTimeLabel
{
    self.timeLabel = [[UILabel alloc]init];
    
    
    
}

@end
