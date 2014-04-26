//
//  HPSeekoutType.h
//  HiPengyou
//
//  Created by Daniel Qiu on 4/4/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <Foundation/Foundation.h>

//seekout type
//self Post is used in profile page to retrieve seekouts posted by current user
//will modify in the future
typedef enum HPSeekoutType : NSInteger {
    all,
    people,
    tips,
    events,
    selfPost
    
} HPSeekoutType;