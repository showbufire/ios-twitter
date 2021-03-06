//
//  LoginViewController.m
//  twitter
//
//  Created by Xiao Jiang on 10/28/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetsViewControlller.h"
#import "common.h"
#import "SideViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            // modally present tweets view
            SideViewController *svc = [[SideViewController alloc] init];
            [self presentViewController:svc animated:YES completion:nil];
        } else {
            // present error view
        }
    }];
        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = (UIColorFromRGB(0x55acee));
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
