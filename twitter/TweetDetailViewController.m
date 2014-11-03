//
//  TweetDetailViewController.m
//  twitter
//
//  Created by Xiao Jiang on 11/2/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "common.h"
#import <UIImageView+AFNetworking.h>
#import "TwitterClient.h"
#import "Tweet.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favButton;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Tweet";
    // 0x55acee
    self.navigationController.navigationBar.barTintColor = (UIColorFromRGB(0x55acee));
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    User *user = self.tweet.user;
    self.nameLabel.text = user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", user.screenName];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:user.profileImageURL]];
    self.tweetTextLabel.text = self.tweet.text;
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:self.tweet.createdAt
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    self.timestampLabel.text = dateString;
    
    [self refreshFav];
    
    [self refreshRetweet];
    
    UIBarButtonItem *replyButton = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onReply)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(onBackToHome)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.rightBarButtonItem = replyButton;
}
- (IBAction)onTapReply:(id)sender {
    [self onReply];
}

- (void)onReply {
    
}

- (IBAction)onRetweet:(id)sender {
    [[TwitterClient sharedInstance] createRetweet:self.tweet.tweetID completion:^(Tweet *tweet, NSError *error) {
        if (error == nil) {
            self.tweet = tweet;
            [self refreshRetweet];
        } else {
            NSLog(@"rt failied: %@", error);
        }
    }];
}

- (void)refreshRetweet {
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.retweetCount];
    
    if (self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"rt_on.png"] forState:UIControlStateNormal];
    } else {
        [self.retweetButton setImage:[UIImage imageNamed:@"rt.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)onFav:(id)sender {
    [[TwitterClient sharedInstance] createFav:self.tweet.tweetID completion:^(Tweet *tweet, NSError *error) {
        if (error == nil) {
            self.tweet = tweet;
            [self refreshFav];
        } else {
            NSLog(@"fav failied: %@", error);
        }
    }];
}

- (void)refreshFav {
    [self.favCountLabel setText:[NSString stringWithFormat:@"%ld", self.tweet.favCount]];
    
    if (self.tweet.favorited) {
        [self.favButton setImage:[UIImage imageNamed:@"fav_on.png"] forState:UIControlStateNormal];
    } else {
        [self.favButton setImage:[UIImage imageNamed:@"fav.png"] forState:UIControlStateNormal];
    }
}

- (void)onBackToHome {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
