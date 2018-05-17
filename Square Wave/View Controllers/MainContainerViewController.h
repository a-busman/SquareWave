//
//  MainContainerViewController.h
//  Square Wave
//
//  Created by Alex Busman on 5/8/18.
//  Copyright © 2018 Alex Busman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainContainerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *songListView;
@property (weak, nonatomic) IBOutlet UIView *nowPlayingView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nowPlayingViewTopConstraint;

@end
