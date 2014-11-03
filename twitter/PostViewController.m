//
//  PostViewController.m
//  twitter
//
//  Created by Xiao Jiang on 11/2/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "common.h"

#import "PostViewController.h"
#import "User.h"
#import <UIImageView+AFNetworking.h>
#import "TwitterClient.h"

NSString * const postTextPlaceHolder = @"Yo, what's up?";

@interface PostViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *postTextView;


@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    User *user = [User currentUser];
    self.nameLabel.text = user.name;
    self.screenNameLabel.text = user.screenName;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:user.profileImageURL]];
    
    [self.postTextView setTextColor:[UIColor lightGrayColor]];
    [self.postTextView setText:postTextPlaceHolder];
    self.postTextView.delegate = self;
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = (UIColorFromRGB(0x55acee));
    
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
    
    self.navigationItem.leftBarButtonItem = tweetButton;
    self.navigationItem.rightBarButtonItem = cancelButton;
}

- (void) onCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onTweet {
    NSString *text = self.postTextView.text;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:text forKey:@"status"];
    [[TwitterClient sharedInstance] statusUpdate:dict completion:^(Tweet *tweet, NSError *error) {
        if (error == nil) {
           [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"tweet succeded");
        } else {
            NSLog(@"tweet failed %@", error);
        }
    }];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = postTextPlaceHolder;
        [textView resignFirstResponder];
    }
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
