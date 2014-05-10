//
//  HPSeekoutComment.h
//  HiPengyou
//
//  Created by Daniel Qiu on 4/29/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPUser.h"
@interface HPSeekoutComment : NSObject
@property NSInteger commentID;

//@property (strong, nonatomic) NSURL *faceImageURL;
@property (strong, nonatomic) NSString *content;
//@property (strong, nonatomic) NSString *author;
//@property NSInteger authorID;
@property (strong, nonatomic) NSString *time;
@property NSInteger likeNumber;
@property BOOL hasMedia;
@property (strong, nonatomic) NSURL *mediaURL;
@property BOOL ifLike;
@property (strong, nonatomic) HPUser *author;

@end
