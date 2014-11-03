//
//  PostViewController.h
//  twitter
//
//  Created by Xiao Jiang on 11/2/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface PostViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) Tweet *replyToTweet;

@end
