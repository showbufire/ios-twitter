//
//  TweetsViewControlller.m
//  twitter
//
//  Created by Xiao Jiang on 11/2/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "common.h"

#import "TweetsViewControlller.h"
#import "User.h"
#import "TweetCellView.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "PostViewController.h"
#import "TweetDetailViewController.h"

@interface TweetsViewControlller ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TweetsViewControlller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Home";
    // 0x55acee
    self.navigationController.navigationBar.barTintColor = (UIColorFromRGB(0x55acee));
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem *postButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pen-24.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onTapPost)];
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logout-24.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
    
    self.navigationItem.leftBarButtonItem = postButton;
    self.navigationItem.rightBarButtonItem = logoutButton;
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCellView" bundle:nil] forCellReuseIdentifier:@"TweetCellView"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self registerRefreshView];
    
    [[TwitterClient sharedInstance] loadTimeline:nil completion:^(NSArray *tweets, NSError *error) {
        if (error == nil) {
            self.tweets = [tweets mutableCopy];
            [self.tableView reloadData];
        } else {
            NSLog(@"Unable to load the timeline: %@", error);
        }
    }];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void) registerRefreshView {
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)onRefresh {
    [[TwitterClient sharedInstance] loadTimeline:nil completion:^(NSArray *tweets, NSError *error) {
        if (error == nil) {
            self.tweets = [tweets mutableCopy];
            [self.tableView reloadData];
        } else {
            NSLog(@"Unable to load the timeline: %@", error);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)onLogout {
    [User logout];
}

- (void)onTapPost {
    PostViewController *vc = [[PostViewController alloc] init];
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)postViewController:(PostViewController *)postViewController didPostTweet:(Tweet *)tweet {
    [self.tweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCellView *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCellView"];
    [cell setTweet:self.tweets[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetDetailViewController *vc = [[TweetDetailViewController alloc] init];
    vc.tweet = self.tweets[indexPath.row];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

/*
static TweetCellView *_prototypeTweetCellView;

- (TweetCellView *)prototypeTweetCellView {
    if (_prototypeTweetCellView == nil) {
        _prototypeTweetCellView = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCellView"];
    }
    
    return _prototypeTweetCellView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self prototypeTweetCellView] setTweet:self.tweets[indexPath.row]];
    CGSize size = [self.prototypeTweetCellView.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 50;
}
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
