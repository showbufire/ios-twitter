//
//  MenuViewController.h
//  twitter
//
//  Created by Xiao Jiang on 11/9/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

@protocol MenuViewControllerDelegate <NSObject>

- (void) onSelectHomeOption:(MenuViewController *)menuViewController;
- (void) onSelectProfileOption:(MenuViewController *)menuViewController;

@end

@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<MenuViewControllerDelegate> delegate;

@end
