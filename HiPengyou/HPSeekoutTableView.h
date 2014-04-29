//
//  HPSeekoutTableView.h
//  HiPengyou
//
//  Created by Tom Hu on 4/5/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPRefresh.h"

@interface HPSeekoutTableView : UITableView <HPRefreshBaseViewDelegate>

@property (strong, nonatomic) HPRefreshHeaderView *header;
@property (strong, nonatomic) HPRefreshFooterView *footer;

@end
