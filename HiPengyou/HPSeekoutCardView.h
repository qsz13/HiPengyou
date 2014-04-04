//
//  HPSeekoutCardView.h
//  HiPengyou
//
//  Created by Daniel Qiu on 4/3/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPSeekoutType.h"

@interface HPSeekoutCardView : UIView

@property (strong, atomic) UIButton *replyButton;
@property (strong, atomic) UIImageView *seekoutTypeImageView;
@property (strong, atomic) UILabel *seekAuthorName;
@property (strong, atomic) UILabel *seekoutTime;
@property (strong, atomic) UIImageView *seekAuthorFace;
@property (strong, atomic) UIView *seekoutContentView;
@property (strong, atomic) UILabel *seekoutContentLabel;

@property HPSeekoutType seekoutType;

@end
