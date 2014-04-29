//
//  HPSeekoutTableView.m
//  HiPengyou
//
//  Created by Tom Hu on 4/5/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import "HPSeekoutTableView.h"
#import "UIView+Resize.h"

@interface HPSeekoutTableView ()

@end

@implementation HPSeekoutTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Set Style
        [self initTableView];
    }
    return self;
}



#pragma mark - UI init
- (void)initTableView
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.anchorPoint = CGPointMake(0, 0);
    self.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    [self resetOrigin:CGPointMake(0, [self getHeight] + 168 / 2)];
    self.showsVerticalScrollIndicator = NO;
    self.rowHeight = 512.0f / 2 + 20; // 20 is for the seperate space
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self initHeader];
    [self initFooter];
}

- (void)initHeader
{
    // 3.集成刷新控件
    // 3.1.下拉刷新
    HPRefreshHeaderView *header = [HPRefreshHeaderView header];
    header.scrollView = self;

    // 自动刷新
    [header beginRefreshing];
    self.header = header;
}

- (void)initFooter
{
    // 3.2.上拉加载更多
    HPRefreshFooterView *footer = [HPRefreshFooterView footer];
    footer.scrollView = self;
    self.footer = footer;
}

@end
