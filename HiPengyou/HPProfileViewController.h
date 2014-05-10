//
//  HPProfileViewController.h
//  HiPengyou
//
//  Created by Daniel Qiu on 3/26/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPUser.h"

@interface HPProfileViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property BOOL isSelfUser;
@property NSInteger profileUserID;

@end
