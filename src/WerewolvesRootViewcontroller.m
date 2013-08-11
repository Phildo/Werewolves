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

@end

@implementation WerewolvesRootViewcontroller

- (void) loadView
{
    [super loadView];
    [self displayContentController:[[IntroScreenViewController alloc] initWithViewFrame:self.view.bounds delegate:self]];
}

- (void) introScreenRequestsGamePlay
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[GameSetupViewController alloc] initWithViewFrame:self.view.bounds delegate:self]];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [self displayContentController:nav];
}

- (void) gameSetupConfirmedWithGame:(Game *)g
{
    [self displayContentController:[[UIViewController alloc] init]];
}

- (void) gameSetupAborted
{
    [self displayContentController:[[IntroScreenViewController alloc] initWithViewFrame:self.view.bounds delegate:self]];
}

@end
