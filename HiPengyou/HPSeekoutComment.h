//
//  HPSeekoutComment.h
//  HiPengyou
//
//  Created by Daniel Qiu on 4/29/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPSeekoutComment : NSObject
@property NSInteger commentID;
@property (strong, atomic) NSURL *faceImageURL;
@property (strong, atomic) NSString *content;
@property (strong, atomic) NSString *author;
@property NSInteger authorID;
@property (strong, atomic) NSString *time;
@property NSInteger likeNumber;
@property BOOL hasMedia;
@property  (strong, atomic) NSURL *mediaURL;
@end
