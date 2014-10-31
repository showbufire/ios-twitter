//
//  TwitterClient.m
//  twitter
//
//  Created by Xiao Jiang on 10/28/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"3EdCdiGOUDrWj164V7f9wL3M5";
NSString * const kTwitterConsumerSecret = @"DV1R2Rmutvs2FkfGU4gNngk40wjmQzurRhBjBjS21wLA9mLyXp";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    return instance;
}

@end
