//
//  HPSeekoutTableViewCell.m
//  HiPengyou
//
//  Created by Tom Hu on 4/4/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPHomeSeekoutTableViewCell.h"
#import "HPSeekoutCardView.h"
#import "UIView+Resize.h"


@interface HPHomeSeekoutTableViewCell ()

@end

@implementation HPHomeSeekoutTableViewCell

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
        // Set Style
        self.transform = CGAffineTransformMakeRotation(M_PI / 2);
        [self resetWidthByOffset:20];
        self.frame = frame;
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        HPSeekoutCardView *seekoutCardView = [[HPSeekoutCardView alloc] initWithFrame:frame];
        [seekoutCardView resetOriginXByOffset:10];
        [seekoutCardView loadData:seekout];

        // Clear Background Color
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        // Bg View
        UIView *bgView = [[UIView alloc] initWithFrame:frame];
        [bgView resetWidthByOffset:20];
        bgView.backgroundColor = [UIColor clearColor];
        
        // Add Seekout Card View To Content View
        [bgView addSubview:seekoutCardView];
        [self.contentView addSubview:bgView];
    }
    return self;
}


@end
