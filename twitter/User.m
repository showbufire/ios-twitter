//
//  User.m
//  twitter
//
//  Created by Xiao Jiang on 11/2/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageURL = dictionary[@"profile_image_url"];
        self.tagLine = dictionary[@"description"];
    }
    
    return self;
}

@end
