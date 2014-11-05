//
//  TweetCellView.m
//  twitter
//
//  Created by Xiao Jiang on 11/2/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "TweetCellView.h"
#import <UIImageView+AFNetworking.h>
#import <DateTools.h>


@interface TweetCellView()

@property (strong, nonatomic) Tweet *_tweet;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;

@end

@implementation TweetCellView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    self._tweet = tweet;
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:tweet.user.profileImageURL]];
    CALayer * l = [self.profileImageView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];
    
    self.nameLabel.text = tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.timestampLabel.text = tweet.createdAt.shortTimeAgoSinceNow;    
    self.tweetTextLabel.text = tweet.text;    
}


@end
