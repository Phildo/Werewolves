//
//  GameSetupViewController.m
//  werewolves
//
//  Created by Phil Dougherty on 8/17/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "GameSetupViewController.h"
#import "SplitSetupViewController.h"
#import "PlayerSetupViewController.h"
#import "TypeSetupViewController.h"

@interface GameSetupViewController() <SplitSetupViewControllerDelegate, PlayerSetupViewControllerDelegate, TypeSetupViewControllerDelegate>
{
    id<GameSetupViewControllerDelegate> __unsafe_unretained delegate;
}
@end

@implementation GameSetupViewController

- (id) initWithViewFrame:(CGRect)f delegate:(id<GameSetupViewControllerDelegate>)d
{
    if(self = [super initWithViewFrame:f])
    {
        delegate = d;
    }
    return self;
}

- (void) loadView
{
    [super loadView];
    [self displayContentController:[[SplitSetupViewController alloc] initWithViewFrame:self.view.bounds delegate:self]];
}

- (void) splitSetupDecidedWithGame:(Game *)g
{
    [self displayContentController:[[PlayerSetupViewController alloc] initWithViewFrame:self.view.bounds delegate:self game:g]];
}

- (void) splitSetupAborted
{
    [delegate gameSetupAborted];
}

- (void) playerSetupDecidedWithGame:(Game *)g
{
    [self displayContentController:[[TypeSetupViewController alloc] initWithViewFrame:self.view.bounds delegate:self game:g]];
}

- (void) playerSetupAborted
{
    
}

- (void) typeSetupDecidedWithGame:(Game *)g
{
}

- (void) typeSetupAborted
{
}
    
@end
