//
//  GameSetupViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "GameSetupViewController.h"
#import "PlayerSplitOverviewView.h"
#import "Game.h"
#import "Player.h"
#import "PlayerSetupViewController.h"

@interface GameSetupViewController() <PlayerSetupViewControllerDelegate>
{
    UISlider *playersSlider;
    UISlider *splitSlider;
    UIImageView *werewolfView;
    UIImageView *villagerView;
    UIButton *hunterView;
    UIButton *healerView;
    PlayerSplitOverviewView *layoutView;
    UILabel *numPlayersLabel;
    UILabel *numWerewolvesLabel;
    UILabel *numVillagersLabel;
    UILabel *maxWerewolvesLabel;
    
    BOOL splitHasBeenEdited;
    
    Game *game;
    id<GameSetupViewControllerDelegate> __unsafe_unretained delegate;
}

@property (nonatomic, strong) UISlider *playersSlider;
@property (nonatomic, strong) UISlider *splitSlider;
@property (nonatomic, strong) UIImageView *werewolfView;
@property (nonatomic, strong) UIImageView *villagerView;
@property (nonatomic, strong) UIButton *hunterView;
@property (nonatomic, strong) UIButton *healerView;
@property (nonatomic, strong) PlayerSplitOverviewView *layoutView;
@property (nonatomic, strong) UILabel *numPlayersLabel;
@property (nonatomic, strong) UILabel *numWerewolvesLabel;
@property (nonatomic, strong) UILabel *numVillagersLabel;
@property (nonatomic, strong) UILabel *maxWerewolvesLabel;
@property (nonatomic, strong) Game *game;

- (IBAction) numPlayersChanged:(UISlider *)sender;
- (IBAction) splitChanged:(UISlider *)sender;
- (IBAction) startButtonTouched;

@end

@implementation GameSetupViewController

@synthesize playersSlider;
@synthesize splitSlider;
@synthesize werewolfView;
@synthesize villagerView;
@synthesize hunterView;
@synthesize healerView;
@synthesize layoutView;
@synthesize numPlayersLabel;
@synthesize numWerewolvesLabel;
@synthesize numVillagersLabel;
@synthesize maxWerewolvesLabel;
@synthesize game;

- (id) initWithViewFrame:(CGRect)f delegate:(id<GameSetupViewControllerDelegate>)d
{
    if(self = [super initWithViewFrame:f])
    {
        delegate = d;
        self.title = @"Game Setup";
        self.game = [[Game alloc] init];
        splitHasBeenEdited = NO;
    }
    return self;
}

- (void) loadView
{
    [super loadView];
    
    #define viewx self.view.frame.origin.x
    #define viewy self.view.frame.origin.y
    #define vieww self.view.frame.size.width
    #define viewh self.view.frame.size.height
    self.view.backgroundColor = [UIColor whiteColor];
    
    #define layoutViewx 10
    #define layoutViewy 10
    #define layoutVieww vieww/3
    #define layoutViewh vieww/3
    self.layoutView = [[PlayerSplitOverviewView alloc] initWithFrame:CGRectMake(layoutViewx, layoutViewy, layoutVieww, layoutViewh)];
    self.layoutView.backgroundColor = [UIColor whiteColor];
    self.layoutView.count      = self.game.numPlayers;
    self.layoutView.werewolves = self.game.numWerewolves;
    self.layoutView.hunter     = self.game.hunter;
    self.layoutView.healer     = self.game.healer;
    [self.view addSubview:self.layoutView];
    
    #define numPlayersPromptx layoutViewx+layoutVieww+10
    #define numPlayersPrompty 10
    #define numPlayersPromptw vieww-numPlayersPromptx-10
    #define numPlayersPrompth 20
    UILabel *numPlayersPrompt = [[UILabel alloc] initWithFrame:CGRectMake(numPlayersPromptx, numPlayersPrompty, numPlayersPromptw, numPlayersPrompth)];
    numPlayersPrompt.textAlignment = NSTextAlignmentRight;
    numPlayersPrompt.text = @"Number of Players:";
    [self.view addSubview:numPlayersPrompt];
    
    #define playersSliderx layoutViewx+layoutVieww+10
    #define playersSlidery layoutViewy+(layoutViewh/2)-10
    #define playersSliderw vieww-playersSliderx-10
    #define playersSliderh 20
    self.playersSlider = [[UISlider alloc] initWithFrame:CGRectMake(playersSliderx, playersSlidery, playersSliderw, playersSliderh)];
    [self.view addSubview:self.playersSlider];
    
    #define numPlayersLabelx playersSliderx
    #define numPlayersLabely playersSlidery+10
    #define numPlayersLabelw playersSliderw
    #define numPlayersLabelh 20
    self.numPlayersLabel = [[UILabel alloc] initWithFrame:CGRectMake(numPlayersLabelx, numPlayersLabely, numPlayersLabelw, numPlayersLabelh)];
    self.numPlayersLabel.textAlignment = NSTextAlignmentLeft;
    self.numPlayersLabel.text = @"10 People";
    [self.view addSubview:self.numPlayersLabel];
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.hunterView.alpha = 0.5;
    self.healerView.alpha = 0.5;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonSystemItemCancel target:self action:@selector(backButtonTouched)];
}

- (void) updateViews
{
    self.layoutView.count  = self.game.numPlayers;
    self.layoutView.werewolves = self.game.numWerewolves;
    [self updateSlider:self.splitSlider toValue:self.game.numWerewolves withMinValue:1 andMaxValue:[self.game maxWerewolves]];
    self.numPlayersLabel.text    = [NSString stringWithFormat:@"%d People", self.game.numPlayers];
    self.maxWerewolvesLabel.text = [NSString stringWithFormat:@"(max:%d)", [self.game maxWerewolves]];
    self.numWerewolvesLabel.text = [NSString stringWithFormat:@"%d", self.game.numWerewolves];
    self.numVillagersLabel.text  = [NSString stringWithFormat:@"%d", self.game.numPlayers-self.game.numWerewolves];
}

- (void) updateSlider:(UISlider *)slider toValue:(int)val withMinValue:(int)min andMaxValue:(int)max
{
    slider.maximumValue = max;
    slider.minimumValue = min;
    slider.value = min;
    slider.value = max;
    slider.value = val;
}

- (void) numPlayersChanged:(UISlider *)sender
{
    if(self.game.numPlayers == (int)(sender.value+0.5)) return;
    self.game.numPlayers = (int)(sender.value+0.5);
    
    if(!splitHasBeenEdited)
        self.game.numWerewolves = ((int)(self.playersSlider.value*0.33));
    else if(self.game.numWerewolves > [self.game maxWerewolves])
        self.game.numWerewolves = [self.game maxWerewolves];
    
    [self updateViews];
}

- (void) splitChanged:(UISlider *)sender
{
    if(self.game.numWerewolves == (int)(sender.value+0.5)) return;
    self.game.numWerewolves = (int)(sender.value+0.5);
    splitHasBeenEdited = YES;
    
    [self updateViews];
}

- (void) hunterTouched
{
    self.game.hunter = !self.game.hunter;
    self.hunterView.alpha = self.game.hunter ? 1.0 : 0.5;
    self.layoutView.hunter = self.game.hunter;
}

- (void) healerTouched
{
    self.game.healer = !self.game.healer;
    self.healerView.alpha = self.game.healer ? 1.0 : 0.5;
    self.layoutView.healer = self.game.healer;
}

- (void) backButtonTouched
{
    [delegate gameSetupAborted];
}

- (void) startButtonTouched
{
    [self.navigationController pushViewController:[[PlayerSetupViewController alloc] initWithDelegate:self numPlayers:self.game.numPlayers] animated:NO];
    return;
    NSMutableArray *players = [[NSMutableArray alloc] initWithCapacity:self.game.numPlayers];
    for(int x = 0; x < self.game.numPlayers; x++)
        [players addObject:[[Player alloc] initWithName:[NSString stringWithFormat:@"Player %d", x+1]]];
    self.game.players = players;
}

@end
