//
//  WerewolvesRootViewcontroller.m
//  werewolves
//
//  Created by Phil Dougherty on 7/30/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "WerewolvesRootViewcontroller.h"
#import "IntroScreenViewController.h"
#import "GameSetupViewController.h"

@interface WerewolvesRootViewcontroller ()<IntroScreenViewControllerDelegate,GameSetupViewControllerDelegate>
{
    UIViewController *currentChildViewController;
}

@end

@implementation WerewolvesRootViewcontroller

- (id) init
{
    if(self = [super init])
    {
    }
    return self;
}

- (void) loadView
{
    [super loadView];
    [self displayContentController:[[IntroScreenViewController alloc] initWithDelegate:self]];
}

- (void) introScreenRequestsGamePlay
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[GameSetupViewController alloc] initWithDelegate:self]];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [self displayContentController:nav];
}

- (void) gameSetupConfirmedWithGame:(Game *)g
{
    [self displayContentController:[[UIViewController alloc] init]];
}

- (void) gameSetupAborted
{
    [self displayContentController:[[IntroScreenViewController alloc] initWithDelegate:self]];
}

@end
