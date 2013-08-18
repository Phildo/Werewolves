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
    SplitSetupViewController *ssvc;
    PlayerSetupViewController *psvc;
    TypeSetupViewController *tsvc;
    
    id<GameSetupViewControllerDelegate> __unsafe_unretained delegate;
}

@property (nonatomic, strong) SplitSetupViewController *ssvc;
@property (nonatomic, strong) PlayerSetupViewController *psvc;
@property (nonatomic, strong) TypeSetupViewController *tsvc;

@end

@implementation GameSetupViewController

@synthesize ssvc;
@synthesize psvc;
@synthesize tsvc;

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
    self.ssvc = [[SplitSetupViewController alloc] initWithViewFrame:self.view.bounds delegate:self];
    [self displayContentController:self.ssvc];
}

- (void) splitSetupDecidedWithGame:(Game *)g
{
    self.psvc = [[PlayerSetupViewController alloc] initWithViewFrame:self.view.bounds delegate:self game:g];
    [self displayContentController:self.psvc];
}

- (void) splitSetupAborted
{
    [delegate gameSetupAborted];
}

- (void) playerSetupDecidedWithGame:(Game *)g
{
    self.tsvc = [[TypeSetupViewController alloc] initWithViewFrame:self.view.bounds delegate:self game:g];
    [self displayContentController:self.tsvc];
}

- (void) playerSetupAborted
{
    [self displayContentController:self.ssvc];
}

- (void) typeSetupDecidedWithGame:(Game *)g
{
    [delegate gameSetupConfirmedWithGame:g];
}

- (void) typeSetupAborted
{
    [self displayContentController:self.psvc];
}
    
@end
