//
//  GamePlayViewController.m
//  werewolves
//
//  Created by Phil Dougherty on 8/18/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "GamePlayViewController.h"
#import "TurnViewController.h"
#import "Game.h"

@interface GamePlayViewController()<TurnViewControllerDelegate>
{
    Game *game;
    id<GamePlayViewControllerDelegate> __unsafe_unretained delegate;
}
@property (nonatomic, strong) Game *game;

@end

@implementation GamePlayViewController

@synthesize game;

- (id) initWithViewFrame:(CGRect)f delegate:(id<GamePlayViewControllerDelegate>)d game:(Game *)g
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
    [self displayContentController:[[TurnViewController alloc] initWithViewFrame:self.view.bounds delegate:self game:self.game]];
}

@end
