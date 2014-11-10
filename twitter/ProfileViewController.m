//
//  ProfileViewController.m
//  twitter
//
//  Created by Xiao Jiang on 11/9/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "ProfileViewController.h"
#import <UIImageView+AFNetworking.h>
#import "common.h"
#import "PostViewController.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageURL;
@property (weak, nonatomic) IBOutlet UIImageView *profileBackgroundImageURL;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = @"Profile";
    // 0x55acee
    self.navigationController.navigationBar.barTintColor = (UIColorFromRGB(0x55acee));
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem *postButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pen-24.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onTapPost)];
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logout-24.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
    
    self.navigationItem.leftBarButtonItem = postButton;
    self.navigationItem.rightBarButtonItem = logoutButton;

    [self.profileImageURL setImageWithURL:[NSURL URLWithString:self.user.profileImageURL]];
    [self.profileBackgroundImageURL setImageWithURL:[NSURL URLWithString:self.user.profileBackgroundImageURL]];
    
    self.tweetsLabel.text = [NSString stringWithFormat:@"%ld", self.user.tweetCounts];
    self.followersLabel.text = [NSString stringWithFormat:@"%ld", self.user.followerCounts];
    self.followingLabel.text = [NSString stringWithFormat:@"%ld", self.user.followingCounts];
}

- (void)onLogout {
    [User logout];
}

- (void)onTapPost {
    PostViewController *vc = [[PostViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
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
