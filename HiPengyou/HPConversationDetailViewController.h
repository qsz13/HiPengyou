//
//  HPConversationDetailViewController.h
//  HiPengyou
//
//  Created by Daniel Qiu on 5/2/14.
//  Copyright (c) 2014 HiPengyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPConversationThread.h"

@interface HPConversationDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

- (id)initWithConvsersationThread:(HPConversationThread *)conversationThread;


@end
