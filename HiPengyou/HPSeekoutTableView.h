//
//  HPSeekoutTableView.h
//  HiPengyou
//
//  Created by Tom Hu on 4/5/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface HPSeekoutTableView : UITableView <MJRefreshBaseViewDelegate>

@property (strong, nonatomic) MJRefreshHeaderView *header;
@property (strong, nonatomic) MJRefreshFooterView *footer;

@end
