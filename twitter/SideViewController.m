//
//  SideViewController.m
//  twitter
//
//  Created by Xiao Jiang on 11/9/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "SideViewController.h"
#import "MenuViewController.h"

@interface SideViewController ()

@property (nonatomic, strong) UIViewController *mainViewController;
@property (nonatomic, strong) MenuViewController *menuViewController;

@property (nonatomic) CGPoint lastPanLocation;
@property (nonatomic) BOOL isMenuOpen;

@property (nonatomic) CGFloat menuOpenWidth;

@end

@implementation SideViewController

- (SideViewController *) initWithMainController:(UIViewController *)mainViewController {
    self = [super init];
    if (self) {
        self.mainViewController = mainViewController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.menuViewController = [[MenuViewController alloc] init];

    [self.view addSubview:self.menuViewController.view];
    [self.view addSubview:self.mainViewController.view];

    
    self.mainViewController.view.frame = self.view.bounds;
    self.menuViewController.view.frame = self.view.bounds;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.menuOpenWidth = screenRect.size.width * 0.618;
    
    self.isMenuOpen = NO;
}

const NSTimeInterval FullDuration = 0.4;

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        self.lastPanLocation = [sender locationInView:self.view];
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        CGRect frame = self.mainViewController.view.frame;
        CGPoint location = [sender locationInView:self.view];
        frame.origin.x = MIN(MAX(0, frame.origin.x + location.x - self.lastPanLocation.x), self.menuOpenWidth);
        self.mainViewController.view.frame = frame;
        self.lastPanLocation = location;
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [sender velocityInView:self.view];
        CGFloat xTranslation = self.mainViewController.view.frame.origin.x;
        
        if (!self.isMenuOpen && (velocity.x > 100 || (xTranslation > 0.5 * self.menuOpenWidth && xTranslation < self.menuOpenWidth))) {
            NSTimeInterval duration = (self.menuOpenWidth - xTranslation) / self.menuOpenWidth * FullDuration;
            [UIView animateWithDuration:duration animations:^{
                CGRect frame = self.mainViewController.view.frame;
                frame.origin.x = self.menuOpenWidth;
                self.mainViewController.view.frame = frame;
            } completion:^(BOOL finished) {
                self.isMenuOpen = YES;
            }];
        } else if (self.isMenuOpen && (velocity.x < -100 || (xTranslation > 0 && xTranslation < 0.5 * self.menuOpenWidth))) {
            NSTimeInterval duration = xTranslation / self.menuOpenWidth * FullDuration;
            [UIView animateWithDuration:duration animations:^{
                CGRect frame = self.mainViewController.view.frame;
                frame.origin.x = 0;
                self.mainViewController.view.frame = frame;
            } completion:^(BOOL finished) {
                self.isMenuOpen = NO;
            }];
        } else if (self.isMenuOpen) {
            NSTimeInterval duration = (self.menuOpenWidth - xTranslation) / self.menuOpenWidth * FullDuration;
            [UIView animateWithDuration:duration animations:^{
                CGRect frame = self.mainViewController.view.frame;
                frame.origin.x = self.menuOpenWidth;
                self.mainViewController.view.frame = frame;
            }];
        } else {
            NSTimeInterval duration = xTranslation / self.menuOpenWidth * FullDuration;
            [UIView animateWithDuration:duration animations:^{
                CGRect frame = self.mainViewController.view.frame;
                frame.origin.x = 0;
                self.mainViewController.view.frame = frame;
            }];
        }
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
