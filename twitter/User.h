//
//  User.h
//  twitter
//
//  Created by Xiao Jiang on 11/2/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageURL;
@property (nonatomic, strong) NSString *tagLine;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (User *)currentUser;

+ (void)setCurrentUser:(User *)currentUser;

+ (void)logout;

@end
