//
//  HPSeekoutCardView.h
//  HiPengyou
//
//  Created by Daniel Qiu on 4/3/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPSeekoutType.h"
#import "HPSeekout.h"
#import "MJRefresh.h"

@interface HPSeekoutCardView : UIView

@property (strong, atomic) NSString *seekoutAuthorName;

@property (strong, atomic) UIImage *seekoutAuthorFace;

@property (strong, atomic) NSString *seekoutTime;

@property (strong, atomic) NSString *seekoutContent;

@property HPSeekoutType seekoutType;

-(void)loadData:(HPSeekout*)seekout;

@end
