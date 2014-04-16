//
//  HPSeekoutDetailViewController.h
//  HiPengyou
//
//  Created by Tom Hu on 4/6/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPSeekout.h"

@interface HPSeekoutDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

- (id)initWithSeekoutData:(HPSeekout *)seekoutData;

@end
