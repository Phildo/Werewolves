//
//  ContentViewController.m
//  werewolves
//
//  Created by Phil Dougherty on 8/2/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()
{
    UIViewController *currentChildViewController;
}
@end

@implementation ContentViewController

- (void) loadView
{
    [super loadView];
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    self.view.frame = [UIScreen mainScreen].applicationFrame;
}

- (void) displayContentController:(UIViewController*)content
{
    if(currentChildViewController) [self hideContentController:currentChildViewController];
    
    [self addChildViewController:content];
    content.view.frame = self.view.bounds;
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];
    
    currentChildViewController = content;
}

- (void) hideContentController:(UIViewController*)content
{
    [content willMoveToParentViewController:nil];
    [content.view removeFromSuperview];
    [content removeFromParentViewController];
    
    currentChildViewController = nil;
}

@end
