//
//  TwitterClient.h
//  twitter
//
//  Created by Xiao Jiang on 10/28/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *) sharedInstance;

- (void) loginWithCompletion:(void (^)(User *user, NSError *error))completion;

- (void) openURL:(NSURL *)url;

@end
