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
#import "GamePlayViewController.h"

@interface WerewolvesRootViewcontroller ()<IntroScreenViewControllerDelegate,GameSetupViewControllerDelegate,GamePlayViewControllerDelegate>

@end

@implementation WerewolvesRootViewcontroller

- (void) loadView
{
    [super loadView];
    [self displayContentController:[[IntroScreenViewController alloc] initWithViewFrame:self.view.bounds delegate:self]];
}

- (void) introScreenRequestsGamePlay
{
    [self displayContentController:[[GameSetupViewController alloc] initWithViewFrame:self.view.bounds delegate:self]];
}

- (void) gameSetupConfirmedWithGame:(Game *)g
{
    [self displayContentController:[[GamePlayViewController alloc] initWithViewFrame:self.view.bounds delegate:self game:g]];
}

- (void) gameSetupAborted
{
    [self displayContentController:[[IntroScreenViewController alloc] initWithViewFrame:self.view.bounds delegate:self]];
}

- (void) gamePlayViewControllerAborted
{
}

@end
