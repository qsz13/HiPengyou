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

@property (strong, atomic) HPSeekout *seekoutData;
@property HPSeekoutType seekoutType;

-(void)loadData:(HPSeekout*)seekout;
- (void)addViewMoreButtonAction:(SEL)selector;

@end
