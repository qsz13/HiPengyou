//
//  HPSeekout.h
//  HiPengyou
//
//  Created by Daniel Qiu on 4/5/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPSeekout : NSObject

@property NSInteger seekoutID;
@property NSString *faceURL;
@property NSString *content;
@property NSString *author;
@property NSInteger commentNumber;
@property NSString *state;
@property NSInteger type;
@property NSString *time;
//@property UIImage *faceImage;
@property NSURL *faceImageURL;

@end
