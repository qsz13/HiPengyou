//
//  MJRefreshConst.h
//  MJRefresh
//
//  Created by mj on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#ifdef DEBUG
#define MJLog(...) NSLog(__VA_ARGS__)
#else
#define MJLog(...)
#endif

// 文字颜色
#define HPRefreshLabelTextColor [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0]

extern const CGFloat HPRefreshViewHeight;
extern const CGFloat HPRefreshAnimationDuration;

extern NSString *const HPRefreshBundleName;
#define kSrcName(file) [HPRefreshBundleName stringByAppendingPathComponent:file]

extern NSString *const HPRefreshFooterPullToRefresh;
extern NSString *const HPRefreshFooterReleaseToRefresh;
extern NSString *const HPRefreshFooterRefreshing;

extern NSString *const HPRefreshHeaderPullToRefresh;
extern NSString *const HPRefreshHeaderReleaseToRefresh;
extern NSString *const HPRefreshHeaderRefreshing;
extern NSString *const HPRefreshHeaderTimeKey;

extern NSString *const HPRefreshContentOffset;
extern NSString *const HPRefreshContentSize;