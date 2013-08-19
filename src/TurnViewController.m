//
//  TurnViewController.m
//  werewolves
//
//  Created by Phil Dougherty on 8/18/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "TurnViewController.h"
#import "HistoryBrowserView.h"
#import "CampfireCircleView.h"
#import "AppConstants.h"
#import "Game.h"
#import "Player.h"
#import "Move.h"

@interface TurnViewController() <HistoryBrowserViewDelegate, CampfireCircleViewDelegate>
{
    Game *game;
    Player *selectedPerson;
    
    HistoryBrowserView *historyBrowser;
    CampfireCircleView *campfireCircle;
    UILabel *prompt;
    
    UIButton *help;
    UIButton *deadToggle;
    
    id<TurnViewControllerDelegate> __unsafe_unretained delegate;
}
@property (nonatomic, strong) Game *game;
@property (nonatomic, strong) Player *selectedPerson;
@property (nonatomic, strong) HistoryBrowserView *historyBrowser;
@property (nonatomic, strong) CampfireCircleView *campfireCircle;
@property (nonatomic, strong) UILabel *prompt;
@property (nonatomic, strong) UIButton *help;
@property (nonatomic, strong) UIButton *deadToggle;
@end

@implementation TurnViewController

@synthesize game;
@synthesize selectedPerson;
@synthesize historyBrowser;
@synthesize campfireCircle;
@synthesize prompt;
@synthesize help;
@synthesize deadToggle;

- (id) initWithViewFrame:(CGRect)f delegate:(id<TurnViewControllerDelegate>)d game:(Game *)g
{
    if(self = [super initWithViewFrame:f])
    {
        self.game = g;
        [self.game.history addObject:[[Move alloc] initWithType:C_VILLAGER player:nil]];
        self.selectedPerson = [[Player alloc] init]; //Start on "finished" villager turn, putting them right into night upon confirmation
        delegate = d;
    }
    return self;
}

- (void) loadView
{
    [super loadView];
    self.campfireCircle = [[CampfireCircleView alloc] initWithFrame:self.view.bounds delegate:self players:self.game.players];
    [self.view addSubview:self.campfireCircle];
    self.historyBrowser = [[HistoryBrowserView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,40) delegate:self history:self.game.history];
    [self.view addSubview:self.historyBrowser];
    
    self.prompt = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-40, self.view.bounds.size.height/2-40, 80, 80)];
    self.prompt.textAlignment = NSTextAlignmentCenter;
    self.prompt.lineBreakMode = NSLineBreakByCharWrapping;
    self.prompt.font = [UIFont fontWithName:@"Helvetica" size:30];
    self.prompt.text = @"Begin!";
    [self.prompt addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(promptTouched:)]];
    [self.view addSubview:self.prompt];
}

- (void) promptTouched:(UITapGestureRecognizer *)r
{
    if(self.selectedPerson) [self nextTurn];
}

- (void) nextTurn
{
    self.game.state = self.game.nextState;
    
    for(int i = 0; i < [self.game.players count]; i++)
    {
        if(((Player *)[self.game.players objectAtIndex:i]).state != C_DEAD)
        {
            ((Player *)[self.game.players objectAtIndex:i]).state = C_SLEEP;
            if(((Player *)[self.game.players objectAtIndex:i]).type == self.game.state)
                ((Player *)[self.game.players objectAtIndex:i]).type = C_AWAKE;
        }
    }
    
    [self.game.history addObject:[[Move alloc] initWithType:self.game.state player:nil]];
    
    [self.historyBrowser updateHistory:self.game.history];
    [self.campfireCircle updatePlayers:self.game.players];
}

- (void) playerWasTouched:(Player *)p
{
}

- (void) player:(Player *)p wasReleasedBeforePosition:(int)pos
{
}

@end
