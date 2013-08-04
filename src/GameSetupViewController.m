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

@interface GameSetupViewController()
{
    IBOutlet UISlider *playersSlider;
    IBOutlet UISlider *splitSlider;
    IBOutlet UIImageView *werewolfView;
    IBOutlet UIImageView *villagerView;
    IBOutlet UIButton *hunterView;
    IBOutlet UIButton *healerView;
    IBOutlet PlayerSplitOverviewView *layoutView;
    IBOutlet UILabel *numPlayersLabel;
    IBOutlet UILabel *numWerewolvesLabel;
    IBOutlet UILabel *numVillagersLabel;
    IBOutlet UILabel *maxWerewolvesLabel;
    
    BOOL splitHasBeenEdited;
    
    Game *game;
    id<GameSetupViewControllerDelegate> __unsafe_unretained delegate;
}

@property (nonatomic, strong) IBOutlet UISlider *playersSlider;
@property (nonatomic, strong) IBOutlet UISlider *splitSlider;
@property (nonatomic, strong) IBOutlet UIImageView *werewolfView;
@property (nonatomic, strong) IBOutlet UIImageView *villagerView;
@property (nonatomic, strong) IBOutlet UIButton *hunterView;
@property (nonatomic, strong) IBOutlet UIButton *healerView;
@property (nonatomic, strong) IBOutlet PlayerSplitOverviewView *layoutView;
@property (nonatomic, strong) IBOutlet UILabel *numPlayersLabel;
@property (nonatomic, strong) IBOutlet UILabel *numWerewolvesLabel;
@property (nonatomic, strong) IBOutlet UILabel *numVillagersLabel;
@property (nonatomic, strong) IBOutlet UILabel *maxWerewolvesLabel;
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

- (id) initWithDelegate:(id)d
{
    if(self = [super initWithNibName:@"GameSetupViewController" bundle:nil])
    {
        delegate = d;
        self.title = @"Game Setup";
        self.game = [[Game alloc] init];
        splitHasBeenEdited = NO;
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.layoutView.count      = self.game.numPlayers;
    self.layoutView.werewolves = self.game.numWerewolves;
    self.layoutView.hunter     = self.game.hunter;
    self.layoutView.healer     = self.game.healer;
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

- (IBAction) numPlayersChanged:(UISlider *)sender
{
    if(self.game.numPlayers == (int)(sender.value+0.5)) return;
    self.game.numPlayers = (int)(sender.value+0.5);
    
    if(!splitHasBeenEdited)
        self.game.numWerewolves = ((int)(self.playersSlider.value*0.33));
    else if(self.game.numWerewolves > [self.game maxWerewolves])
        self.game.numWerewolves = [self.game maxWerewolves];
    
    [self updateViews];
}

- (IBAction) splitChanged:(UISlider *)sender
{
    if(self.game.numWerewolves == (int)(sender.value+0.5)) return;
    self.game.numWerewolves = (int)(sender.value+0.5);
    splitHasBeenEdited = YES;
    
    [self updateViews];
}

- (IBAction) hunterTouched
{
    self.game.hunter = !self.game.hunter;
    self.hunterView.alpha = self.game.hunter ? 1.0 : 0.5;
    self.layoutView.hunter = self.game.hunter;
}

- (IBAction) healerTouched
{
    self.game.healer = !self.game.healer;
    self.healerView.alpha = self.game.healer ? 1.0 : 0.5;
    self.layoutView.healer = self.game.healer;
}

- (void) backButtonTouched
{
    [delegate gameSetupAborted];
}

- (IBAction) startButtonTouched
{
    [self.navigationController pushViewController:[[UIViewController alloc] init] animated:NO];
    return;
    NSMutableArray *players = [[NSMutableArray alloc] initWithCapacity:self.game.numPlayers];
    for(int x = 0; x < self.game.numPlayers; x++)
        [players addObject:[[Player alloc] initWithName:[NSString stringWithFormat:@"Player %d", x+1]]];
    self.game.players = players;
}

@end
