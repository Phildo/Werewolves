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
        self.game.state = C_VILLAGER;
        self.selectedPerson = [[Player alloc] init]; //Start on "finished" villager turn, putting them right into night upon confirmation
        [self.game.history addObject:[[Move alloc] initWithType:self.game.state player:nil]];
        delegate = d;
    }
    return self;
}

- (void) loadView
{
    [super loadView];
    self.campfireCircle = [[CampfireCircleView alloc] initWithFrame:self.view.bounds delegate:self players:self.game.players];
    [self.view addSubview:self.campfireCircle];
    self.historyBrowser = [[HistoryBrowserView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,80) delegate:self history:self.game.history];
    [self.view addSubview:self.historyBrowser];
    
    self.prompt = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-80, self.view.bounds.size.height/2-20, 160, 40)];
    self.prompt.textAlignment = NSTextAlignmentCenter;
    self.prompt.lineBreakMode = NSLineBreakByCharWrapping;
    self.prompt.font = [UIFont fontWithName:@"Helvetica" size:30];
    self.prompt.text = @"Begin!";
    self.prompt.userInteractionEnabled = YES;
    self.prompt.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.5];
    [self.prompt addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(promptTouched:)]];
    [self.view addSubview:self.prompt];
}

- (void) promptTouched:(UITapGestureRecognizer *)r //note- should only be possible (view userInteractionEnabled) if player selected (or start of game)
{
    if([self checkWin]) return;
    [self checkStatisticalWin];
    [self nextTurn];
}

- (BOOL) checkWin
{
    int villagersLeft = 0;
    int werewolvesLeft = 0;
    int huntersLeft = 0;
    int healersLeft = 0;
    for(int i = 0; i < [self.game.players count]; i++)
    {
        Player *p = [self.game.players objectAtIndex:i];
        if(p.type == C_VILLAGER && p.state != C_DEAD) villagersLeft++;
        if(p.type == C_WEREWOLF && p.state != C_DEAD) werewolvesLeft++;
        if(p.type == C_HUNTER   && p.state != C_DEAD) huntersLeft++;
        if(p.type == C_HEALER   && p.state != C_DEAD) healersLeft++;
    }
    
    if(werewolvesLeft == 0)                                 { [self displayWin:C_VILLAGER]; return YES; }
    else if(villagersLeft + huntersLeft + healersLeft == 0) { [self displayWin:C_WEREWOLF]; return YES; }
    return NO;
}

- (int) checkStatisticalWin //returns team that is guaranteed to win if exists
{
    return C_NONE;
}

- (void) displayWin:(int)type
{
    if(type == C_WEREWOLF)      self.prompt.text = @"Werewolves Win!";
    else if(type == C_VILLAGER) self.prompt.text = @"Villagers Win!";
    
    UILabel *playAgain = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-80,self.view.bounds.size.width/2+80,160,40)];
    playAgain.text = @"Play again?";
    [self.view addSubview:playAgain];
}

- (void) nextTurn
{
    switch(self.game.state)
    {
        case C_VILLAGER:
        case C_WEREWOLF:
            self.selectedPerson.state = C_DEAD; break;
        case C_HUNTER: break; //do nothing
        case C_HEALER: self.selectedPerson.state = C_SLEEP; break;
    }
    ((Move *)[self.game.history objectAtIndex:[self.game.history count]-1]).player = self.selectedPerson;
    self.selectedPerson = nil;

    self.game.state = self.game.nextState;
    
    //Put everyone to sleep except current types
    for(int i = 0; i < [self.game.players count]; i++)
    {
        Player *p = [self.game.players objectAtIndex:i];
        if(p.state != C_DEAD) p.state = (p.type == self.game.state || self.game.state == C_VILLAGER) ? C_AWAKE : C_SLEEP;
    }
    
    [self.game.history addObject:[[Move alloc] initWithType:self.game.state player:nil]];
    
    [self updatePrompt];
    [self.historyBrowser updateHistory:self.game.history];
    [self.campfireCircle updatePlayers:self.game.players];
}

- (void) updatePrompt
{
    self.prompt.userInteractionEnabled = (self.selectedPerson != nil);
    switch(self.game.state)
    {
        case C_VILLAGER: self.prompt.text = (self.selectedPerson ? @"Confirm Kill"   : @"Find Werewolf");    break;
        case C_WEREWOLF: self.prompt.text = (self.selectedPerson ? @"Confirm Kill"   : @"Select Victim");    break;
        case C_HUNTER:   self.prompt.text = (self.selectedPerson ? @"Confirm Sleuth" : @"Question Suspect"); break;
        case C_HEALER:   self.prompt.text = (self.selectedPerson ? @"Confirm Heal"   : @"Protect Villager"); break;
    }
}

- (BOOL) isValidSelection:(Player *)p
{
    if(self.selectedPerson) return NO;
        
    if(p.state == C_DEAD && self.game.state == C_HEALER)
        return [self wasLastKilledByWerewolves:p];
    
    return p.state != C_DEAD;
}

- (BOOL) wasLastKilledByWerewolves:(Player *)p
{
    Move *m;                 m = [self.game.history objectAtIndex:[self.game.history count] - 1]; //this turn
    if(m.type != C_WEREWOLF) m = [self.game.history objectAtIndex:[self.game.history count] - 2]; //last turn
    if(m.type != C_WEREWOLF) m = [self.game.history objectAtIndex:[self.game.history count] - 3]; //1 turn ago
    if(m.type != C_WEREWOLF) m = [self.game.history objectAtIndex:[self.game.history count] - 4]; //2 turns ago
    return m.player == p;
}

- (void) playerWasTouched:(Player *)p
{
    if(self.selectedPerson == p) //undo selection
    {
        switch(self.game.state)
        {
            case C_VILLAGER: p.state = C_AWAKE; break;
            case C_WEREWOLF: p.state = (p.type == C_WEREWOLF) ? C_AWAKE : C_SLEEP; break;
            case C_HUNTER:   /* nothing */ break;
            case C_HEALER:   p.state = [self wasLastKilledByWerewolves:p] ? C_DEAD : (p.type == C_HEALER ? C_AWAKE : C_SLEEP); break; //lol god that's ugly...
        }
        self.selectedPerson = nil;
    }
    else if([self isValidSelection:p]) //make selection
    {
        switch(self.game.state)
        {
            case C_VILLAGER: p.state = C_DEAD;  break;
            case C_WEREWOLF: p.state = C_DEAD;  break;
            case C_HUNTER:   /* nothing */      break;
            case C_HEALER:   p.state = C_SLEEP; break;
        }
        self.selectedPerson = p;
    }   
    
    [self updatePrompt];
    [self.campfireCircle updatePlayers:self.game.players];
}

- (void) player:(Player *)p wasReleasedBeforePosition:(int)pos
{
}

- (void) moveWasTouched:(Move *)m
{
    if(self.selectedPerson) [self playerWasTouched:self.selectedPerson];
    
    for(int i = 0; i < [self.game.players count]; i++)
        ((Player *)[self.game.players objectAtIndex:i]).state = C_AWAKE;
    
    for(int i = 0; i < [self.game.history count]; i++)
    {
        Move *hm = [self.game.history objectAtIndex:i];
        if(hm == m) { self.game.state = hm.type; break; }
        switch(m.type)
        {
            case C_VILLAGER: m.player.state = C_DEAD;  break;
            case C_WEREWOLF: m.player.state = C_DEAD;  break;
            case C_HUNTER:   /* nothing */             break;
            case C_HEALER:   m.player.state = C_AWAKE; break;
        }
    }
    
    [self updatePrompt];
    [self.historyBrowser updateHistory:self.game.history];
    [self.campfireCircle updatePlayers:self.game.players];
}

@end
