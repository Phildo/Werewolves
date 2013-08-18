//
//  TypeSetupViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/21/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "TypeSetupViewController.h"
#import "AppConstants.h"
#import "Game.h"
#import "Player.h"
#import "CampfireCircleView.h"
 
@interface TypeSetupViewController() <CampfireCircleViewDelegate>
{
    UILabel *titleLabel;
    UIButton *nextButton;
    UIButton *diceButton;
    CampfireCircleView *campFireCircle;
    
    int numLeft;
    int sceneType; //0- werewolf; 1- hunter; 2- healer;
    
    Game *game;
    
    id<TypeSetupViewControllerDelegate> __unsafe_unretained delegate;
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *diceButton;
@property (nonatomic, strong) CampfireCircleView *campFireCircle;
@property (nonatomic, assign) int numLeft;
@property (nonatomic, assign) int sceneType;
@property (nonatomic, strong) Game *game;

@end
 
@implementation TypeSetupViewController

@synthesize titleLabel;
@synthesize nextButton;
@synthesize diceButton;
@synthesize campFireCircle;
@synthesize numLeft;
@synthesize sceneType;
@synthesize game;

- (id) initWithViewFrame:(CGRect)f delegate:(id<TypeSetupViewControllerDelegate>)d game:(Game *)g
{
    if(self = [super initWithViewFrame:f])
    {
        self.game = g;
        self.title = @"role setup";
        
        delegate = d;
    }
    return self;
} 

- (void) loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.campFireCircle = [[CampfireCircleView alloc] initWithFrame:self.view.bounds delegate:self players:self.game.players];
    [self.view addSubview:self.campFireCircle];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10,self.view.bounds.size.width,20)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    [self.view addSubview:self.titleLabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, self.view.bounds.size.height-40, (self.view.bounds.size.width-20)/2, 40);
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton setTitle:@"< back" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height-40, (self.view.bounds.size.width-20)/2, 40);
    self.nextButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.nextButton setTitle:@"name players >" forState:UIControlStateNormal];
    [self.nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    
    self.diceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.diceButton setTitle:@"dice" forState:UIControlStateNormal];
    [self.diceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.diceButton.frame = CGRectMake(10, 30, 40, 20);
    [self.diceButton addTarget:self action:@selector(diceButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.diceButton];
    
    [self setSceneType:C_WEREWOLF];
}
 
- (void) refreshView
{
    if(sceneType == C_WEREWOLF) self.titleLabel.text = @"choose your werewolves";
    if(sceneType == C_HUNTER)   self.titleLabel.text = @"choose your hunter";
    if(sceneType == C_HEALER)   self.titleLabel.text = @"choose your healer";
    
    if(numLeft > 0)
        [self.nextButton setTitle:[NSString stringWithFormat:@"(%d remaining)",numLeft] forState:UIControlStateNormal];
    else
        [self.nextButton setTitle:@"next >" forState:UIControlStateNormal];
    
    [self.campFireCircle updatePlayers:self.game.players];
    [self.campFireCircle refresh];
}

- (void) setSceneType:(int)s
{
    sceneType = s;
    
    int curNum = 0;
    for(int i = 0; i < self.game.numPlayers; i++)
        if(((Player *)[self.game.players objectAtIndex:i]).type == s) curNum++;
    
    if(s == C_WEREWOLF) self.numLeft = (self.game.numWerewolves) - curNum;
    if(s == C_HUNTER)   self.numLeft = (game.hunter ? 1 : 0)     - curNum;
    if(s == C_HEALER)   self.numLeft = (game.healer ? 1 : 0)     - curNum;
    
    [self refreshView];
}

- (void) backButtonTouched
{
    if(self.sceneType == C_WEREWOLF)
    {
        for(int x = 0; x < self.game.numPlayers; x++)
            ((Player *)[self.game.players objectAtIndex:x]).type = C_VILLAGER;
        [delegate typeSetupAborted];
    }
    else if(self.sceneType == C_HUNTER)
    {
        for(int x = 0; x < self.game.numPlayers; x++)
            if(((Player *)[self.game.players objectAtIndex:x]).type == C_HUNTER) 
                ((Player *)[self.game.players objectAtIndex:x]).type = C_VILLAGER;
        [self setSceneType:C_WEREWOLF];
    }
    else if(self.sceneType == C_HEALER)
    {
        for(int x = 0; x < self.game.numPlayers; x++)
            if(((Player *)[self.game.players objectAtIndex:x]).type == C_HEALER) 
                ((Player *)[self.game.players objectAtIndex:x]).type = C_VILLAGER;
        if(self.game.hunter)
            [self setSceneType:C_HUNTER];
        else
            [self setSceneType:C_WEREWOLF];
    }
}

- (void) nextButtonTouched
{
    if(numLeft > 0) return;
    
    if(self.sceneType == C_WEREWOLF)
    {
        if(self.game.hunter)
            [self setSceneType:C_HUNTER];
        else if(self.game.healer)
            [self setSceneType:C_HEALER];
        else
            [delegate typeSetupDecidedWithGame:self.game];
    }
    else if(self.sceneType == C_HUNTER)
    {
        if(self.game.healer)
            [self setSceneType:C_HEALER];
        else
            [delegate typeSetupDecidedWithGame:self.game];
    }
    else if(self.sceneType == C_HEALER)
            [delegate typeSetupDecidedWithGame:self.game];
}

- (void) player:(Player *)p wasReleasedBeforePosition:(int)pos
{
    [self refreshView];
}

- (void) playerWasTouched:(Player *)p
{
    if(numLeft > 0 && p.type == C_VILLAGER)
    {
        numLeft--;
        p.type = sceneType;
    }
    else if(p.type == sceneType)
    {
        numLeft++;
        p.type = C_VILLAGER;
    }
                
    [self refreshView];
}

- (void) diceButtonTouched
{
    int numEligiblePlayers = 0;
    for(int i = 0; i < self.game.numPlayers; i++)
    {
        if(((Player *)[self.game.players objectAtIndex:i]).type == sceneType)
        {
            numLeft++;
            ((Player *)[self.game.players objectAtIndex:i]).type = C_VILLAGER;
        }
        if(((Player *)[self.game.players objectAtIndex:i]).type == C_VILLAGER)
            numEligiblePlayers++;
    }
    
    for(int i = 0; i < self.game.numPlayers; i++)
    {
        if(((Player *)[self.game.players objectAtIndex:i]).type == C_VILLAGER)
        {
            int prob = arc4random() % (numEligiblePlayers)+1;
            if(prob <= self.numLeft)
                [self playerWasTouched:[self.game.players objectAtIndex:i]];
            numEligiblePlayers--;
        }
    }
}

@end
