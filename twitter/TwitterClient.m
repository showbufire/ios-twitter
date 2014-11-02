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

@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end

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

- (void) loginWithCompletion:(void (^)(User *user, NSError *error))completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"xiaojiostwitter://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSLog(@"got the token");
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        completion(nil, error);
    }];
}

- (void) openURL:(NSURL *)url {
    [[TwitterClient sharedInstance] fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuthToken tokenWithQueryString:url.query] success:^(BDBOAuthToken *accessToken) {
        [self.requestSerializer saveAccessToken:accessToken];
        
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"current user: %@", responseObject);
            User *user = [[User alloc] initWithDictionary:responseObject];
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed to load the current user: %@", error);
        }];
    } failure:^(NSError *error) {
        NSLog(@"failed to get the access token: %@", error);
    }];
}

@end
