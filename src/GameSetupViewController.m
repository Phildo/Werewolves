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
    UILabel *hunterLabel;
    UILabel *healerLabel;
    
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
@property (nonatomic, strong) UILabel *hunterLabel;
@property (nonatomic, strong) UILabel *healerLabel;
@property (nonatomic, strong) Game *game;

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
@synthesize hunterLabel;
@synthesize healerLabel;
@synthesize game;

- (id) initWithViewFrame:(CGRect)f delegate:(id<GameSetupViewControllerDelegate>)d
{
    if(self = [super initWithViewFrame:f])
    {
        delegate = d;
        self.title = @"game setup";
        self.game = [[Game alloc] init];
        splitHasBeenEdited = NO;
    }
    return self;
}

- (void) loadView
{
    [super loadView];
    
    CGFloat viewpadding = 10;
    CGFloat vieww = self.view.bounds.size.width;
    CGFloat viewh = self.view.bounds.size.height;
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat layoutViewx = (viewpadding);
    CGFloat layoutViewy = (20+44+viewpadding);
    CGFloat layoutVieww = ((int)(vieww/3));
    CGFloat layoutViewh = ((int)(vieww/3));
    self.layoutView = [[PlayerSplitOverviewView alloc] initWithFrame:CGRectMake(layoutViewx, layoutViewy, layoutVieww, layoutViewh)];
    self.layoutView.backgroundColor = [UIColor whiteColor];
    self.layoutView.count      = self.game.numPlayers;
    self.layoutView.werewolves = self.game.numWerewolves;
    self.layoutView.hunter     = self.game.hunter;
    self.layoutView.healer     = self.game.healer;
    [self.view addSubview:self.layoutView];
    
    CGFloat playersSliderx = (layoutViewx+layoutVieww+viewpadding);
    CGFloat playersSlidery = (layoutViewy+(layoutViewh/2)-10);
    CGFloat playersSliderw = (vieww-playersSliderx-viewpadding);
    CGFloat playersSliderh = (20);
    self.playersSlider = [[UISlider alloc] initWithFrame:CGRectMake(playersSliderx, playersSlidery, playersSliderw, playersSliderh)];
    self.playersSlider.minimumValue = 5;
    self.playersSlider.maximumValue = 30;
    self.playersSlider.value = 10;
    [self.playersSlider addTarget:self action:@selector(numPlayersChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.playersSlider];
    
    CGFloat numPlayersPromptx = (layoutViewx+layoutVieww+viewpadding);
    CGFloat numPlayersPrompty = (playersSlidery-viewpadding-20);
    CGFloat numPlayersPromptw = (vieww-numPlayersPromptx-viewpadding);
    CGFloat numPlayersPrompth = (20);
    UILabel *numPlayersPrompt = [[UILabel alloc] initWithFrame:CGRectMake(numPlayersPromptx, numPlayersPrompty, numPlayersPromptw, numPlayersPrompth)];
    numPlayersPrompt.text = @"number of players:";
    [self.view addSubview:numPlayersPrompt];
    
    CGFloat numPlayersLabelx = (playersSliderx);
    CGFloat numPlayersLabely = (playersSlidery+playersSliderh+viewpadding);
    CGFloat numPlayersLabelw = (playersSliderw);
    CGFloat numPlayersLabelh = (20);
    self.numPlayersLabel = [[UILabel alloc] initWithFrame:CGRectMake(numPlayersLabelx, numPlayersLabely, numPlayersLabelw, numPlayersLabelh)];
    self.numPlayersLabel.text = @"10 people";
    [self.view addSubview:self.numPlayersLabel];
    
    CGFloat werewolfx = (viewpadding);
    CGFloat werewolfy = (layoutViewy+layoutViewh+(3*viewpadding));
    CGFloat werewolfw = ((int)(vieww/5));
    CGFloat werewolfh = ((werewolfw/[UIImage imageNamed:@"werewolf.png"].size.width)*[UIImage imageNamed:@"werewolf.png"].size.height);
    UIImageView *werewolf = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"werewolf.png"]];
    werewolf.frame = CGRectMake(werewolfx, werewolfy, werewolfw, werewolfh);
    [self.view addSubview:werewolf];
    
    CGFloat villagerx = (vieww-werewolfw-viewpadding);
    CGFloat villagery = (werewolfy);
    CGFloat villagerw = (werewolfw);
    CGFloat villagerh = (werewolfh);
    UIImageView *villager = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"villager.png"]];
    villager.frame = CGRectMake(villagerx, villagery, villagerw, villagerh);
    [self.view addSubview:villager];
    
    CGFloat splitSliderx = (werewolfx+werewolfw+viewpadding);
    CGFloat splitSlidery = (werewolfy+((int)(werewolfh/2))-10);
    CGFloat splitSliderw = (vieww-(2*werewolfw)-(4*viewpadding));
    CGFloat splitSliderh = (20);
    self.splitSlider = [[UISlider alloc] initWithFrame:CGRectMake(splitSliderx, splitSlidery, splitSliderw, splitSliderh)];
    self.splitSlider.minimumValue = 1;
    self.splitSlider.maximumValue = 4;
    self.splitSlider.value = 3;
    [self.splitSlider addTarget:self action:@selector(splitChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.splitSlider];
    
    CGFloat splitPromptx = (splitSliderx);
    CGFloat splitPrompty = (splitSlidery-viewpadding-20);
    CGFloat splitPromptw = (splitSliderw);
    CGFloat splitPrompth = (20);
    UILabel *splitPrompt = [[UILabel alloc] initWithFrame:CGRectMake(splitPromptx, splitPrompty, splitPromptw, splitPrompth)];
    splitPrompt.textAlignment = NSTextAlignmentCenter;
    splitPrompt.text = @"wolf/villager split:";
    [self.view addSubview:splitPrompt];
    
    CGFloat numWerewolvesLabelx = (werewolfx);
    CGFloat numWerewolvesLabely = (werewolfy+werewolfh+viewpadding);
    CGFloat numWerewolvesLabelw = (werewolfw);
    CGFloat numWerewolvesLabelh = (20);
    self.numWerewolvesLabel = [[UILabel alloc] initWithFrame:CGRectMake(numWerewolvesLabelx, numWerewolvesLabely, numWerewolvesLabelw, numWerewolvesLabelh)];
    self.numWerewolvesLabel.textAlignment = NSTextAlignmentCenter;
    self.numWerewolvesLabel.text = @"3";
    [self.view addSubview:self.numWerewolvesLabel];
    
    CGFloat numVillagersLabelx = (villagerx);
    CGFloat numVillagersLabely = (villagery+villagerh+viewpadding);
    CGFloat numVillagersLabelw = (villagerw);
    CGFloat numVillagersLabelh = (20);
    self.numVillagersLabel = [[UILabel alloc] initWithFrame:CGRectMake(numVillagersLabelx, numVillagersLabely, numVillagersLabelw, numVillagersLabelh)];
    self.numVillagersLabel.textAlignment = NSTextAlignmentCenter;
    self.numVillagersLabel.text = @"7";
    [self.view addSubview:self.numVillagersLabel];
    
    CGFloat hunterx = (viewpadding);
    CGFloat huntery = (numWerewolvesLabely+numWerewolvesLabelh+(2*viewpadding));
    CGFloat hunterw = (werewolfw);
    CGFloat hunterh = (werewolfh);
    self.hunterView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hunterView.frame = CGRectMake(hunterx, huntery, hunterw, hunterh);
    [self.hunterView setImage:[UIImage imageNamed:@"hunter.png"] forState:UIControlStateNormal];
    self.hunterView.alpha = 0.5;
    [self.hunterView addTarget:self action:@selector(hunterTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.hunterView];
    
    CGFloat healerx = (vieww-hunterw-viewpadding);
    CGFloat healery = (huntery);
    CGFloat healerw = (hunterw);
    CGFloat healerh = (hunterh);
    self.healerView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.healerView.frame = CGRectMake(healerx, healery, healerw, healerh);
    [self.healerView setImage:[UIImage imageNamed:@"healer.png"] forState:UIControlStateNormal];
    self.healerView.alpha = 0.5;
    [self.healerView addTarget:self action:@selector(healerTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.healerView];
    
    CGFloat hunterLabelx = (hunterx+hunterw+viewpadding);
    CGFloat hunterLabely = (huntery+(3*viewpadding));
    CGFloat hunterLabelw = (splitSliderw); //technically shouldn't be constrained on that, but they end up being the same
    CGFloat hunterLabelh = (20);
    self.hunterLabel = [[UILabel alloc] initWithFrame:CGRectMake(hunterLabelx, hunterLabely, hunterLabelw, hunterLabelh)];
    self.hunterLabel.textAlignment = NSTextAlignmentCenter;
    self.hunterLabel.text = @"hunter: disabled";
    [self.view addSubview:self.hunterLabel];
    
    CGFloat healerLabelx = (hunterLabelx);
    CGFloat healerLabely = (healery+healerh-(3*viewpadding)-20);
    CGFloat healerLabelw = (hunterLabelw);
    CGFloat healerLabelh = (20);
    self.healerLabel = [[UILabel alloc] initWithFrame:CGRectMake(healerLabelx, healerLabely, healerLabelw, healerLabelh)];
    self.healerLabel.text = @"healer: disabled";
    self.healerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.healerLabel];
    
    CGFloat startButtonx = (viewpadding);
    CGFloat startButtony = (viewh-viewpadding-40);
    CGFloat startButtonw = (vieww-(2*viewpadding));
    CGFloat startButtonh = (40);
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(startButtonx, startButtony, startButtonw, startButtonh);
    [startButton setTitle:@"start" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonSystemItemCancel target:self action:@selector(backButtonTouched)];
}

- (void) updateViews
{
    self.layoutView.count  = self.game.numPlayers;
    self.layoutView.werewolves = self.game.numWerewolves;
    [self updateSlider:self.splitSlider toValue:self.game.numWerewolves withMinValue:1 andMaxValue:[self.game maxWerewolves]];
    self.numPlayersLabel.text    = [NSString stringWithFormat:@"%d people", self.game.numPlayers];
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

- (void) numPlayersChanged
{
    if(self.game.numPlayers == (int)(self.playersSlider.value+0.5)) return;
    self.game.numPlayers = (int)(self.playersSlider.value+0.5);
    
    if(!splitHasBeenEdited)
        self.game.numWerewolves = ((int)(self.playersSlider.value*0.33));
    else if(self.game.numWerewolves > [self.game maxWerewolves])
        self.game.numWerewolves = [self.game maxWerewolves];
    
    [self updateViews];
}

- (void) splitChanged
{
    if(self.game.numWerewolves == (int)(self.splitSlider.value+0.5)) return;
    self.game.numWerewolves = (int)(self.splitSlider.value+0.5);
    splitHasBeenEdited = YES;
    
    [self updateViews];
}

- (void) hunterTouched
{
    self.game.hunter = !self.game.hunter;
    self.hunterView.alpha = self.game.hunter ? 1.0 : 0.5;
    self.hunterLabel.text = self.game.hunter ? @"hunter: enabled" : @"hunter: disabled";
    self.layoutView.hunter = self.game.hunter;
}

- (void) healerTouched
{
    self.game.healer = !self.game.healer;
    self.healerView.alpha = self.game.healer ? 1.0 : 0.5;
    self.healerLabel.text = self.game.healer ? @"healer: enabled" : @"healer: disabled";
    self.layoutView.healer = self.game.healer;
}

- (void) backButtonTouched
{
    [delegate gameSetupAborted];
}

- (void) startButtonTouched
{
    [self.navigationController pushViewController:[[PlayerSetupViewController alloc] initWithViewFrame:self.view.bounds delegate:self numPlayers:self.game.numPlayers] animated:YES];
}

@end
