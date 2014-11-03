//
//  TweetCellView.m
//  twitter
//
//  Created by Xiao Jiang on 11/2/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "TweetCellView.h"

@interface TweetCellView()

@property (strong, nonatomic) Tweet *_tweet;

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
}


@end
