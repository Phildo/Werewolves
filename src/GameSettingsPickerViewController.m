//
//  GameSettingsPickerViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "GameSettingsPickerViewController.h"


@implementation GameSettingsPickerViewController

@synthesize playersSlider;
@synthesize splitSlider;
@synthesize werewolf;
@synthesize villager;
@synthesize hunter;
@synthesize healer;
@synthesize layout;
@synthesize numPlayers;
@synthesize numWerewolves;
@synthesize numVillagers;
@synthesize maxWerewolves;

@synthesize splitEdited;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.splitEdited = NO;
    }
    return self;
}

//The Following method is a ridiculous way to get around the bullshit that I can't override to ALWAYS update the UI
- (void) bullshitUpdateSlider:(UISlider *)slider toValue:(int)val withMinValue:(int)min andMaxValue:(int)max{
    slider.value = min;
    slider.value = max;
    slider.value = val;
}

- (void) numPlayersChanged:(UISlider *)sender
{
    int maxWolves = (int)((sender.value/2)-1);
    self.splitSlider.maximumValue = maxWolves;
    self.maxWerewolves.text = [NSString stringWithFormat:@"(max:%d)", maxWolves];
    if(!self.splitEdited){
        [self bullshitUpdateSlider:self.splitSlider toValue:((int)(sender.value * 0.33)) withMinValue:1 andMaxValue:maxWolves];
        [Game instance].numWerewolves = (int) self.splitSlider.value;
        self.numWerewolves.text = [NSString stringWithFormat:@"%d", (int)self.splitSlider.value];
    }
    else if([Game instance].numWerewolves > maxWolves){
        [self bullshitUpdateSlider:self.splitSlider toValue:maxWolves withMinValue:1 andMaxValue:maxWolves];
        [Game instance].numWerewolves = maxWolves;
        self.numWerewolves.text = [NSString stringWithFormat:@"%d", maxWolves];
    }
    else{
        [self bullshitUpdateSlider:self.splitSlider toValue:[Game instance].numWerewolves withMinValue:1 andMaxValue:maxWolves];
    }
    self.numVillagers.text = [NSString stringWithFormat:@"%d", ((int) sender.value) - ((int) self.splitSlider.value)];
    self.numPlayers.text = [NSString stringWithFormat:@"%d People", (int) sender.value];
    [Game instance].numPlayers = (int) sender.value;
    self.layout.count = [Game instance].numPlayers;
    self.layout.wolves = [Game instance].numWerewolves;
}

- (IBAction)splitChanged:(UISlider *)sender
{
    self.splitEdited = YES;
    self.numWerewolves.text = [NSString stringWithFormat:@"%d", (int) sender.value];
    self.numVillagers.text = [NSString stringWithFormat:@"%d", ((int) self.playersSlider.value) - ((int) sender.value)];
    [Game instance].numWerewolves = (int) sender.value;
    self.layout.wolves = [Game instance].numWerewolves;
}

- (IBAction)startButtonPressed
{
    NSMutableArray *players = [[NSMutableArray alloc] initWithCapacity:[Game instance].numPlayers];
    for(int x = 0; x < [Game instance].numPlayers; x++){
        Player *p = [[Player alloc] init ];
        p.name = [NSString stringWithFormat:@"Player %d", x+1];
        [players insertObject:p atIndex:x];
    }
    [Game instance].players = players;
    
    PlayerNameViewController *names = [[PlayerNameViewController alloc] init];
    [self.navigationController pushViewController:names animated:YES];
}

- (IBAction)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void) viewWillAppear:(BOOL)animated
{
    self.layout.location = -1;
    self.layout.wolves = [Game instance].numWerewolves;
    self.layout.hunter = [Game instance].hunter;
    self.layout.healer = [Game instance].healer;
    self.layout.count = [Game instance].numPlayers;
    self.layout.delegate = self;
    self.werewolf.delegate = self;
    self.villager.delegate = self;
    self.hunter.delegate = self;
    self.healer.delegate = self;
    [self.werewolf setAppearanceToType:C_WEREWOLF state:C_AWAKE faded:NO];
    [self.villager setAppearanceToType:C_VILLAGER state:C_AWAKE faded:NO];
    [self.hunter setAppearanceToType:C_HUNTER state:C_AWAKE faded:![Game instance].hunter];
    [self.healer setAppearanceToType:C_HEALER state:C_AWAKE faded:![Game instance].healer];
    UITapGestureRecognizer *tapHunter = [[UITapGestureRecognizer alloc] initWithTarget:hunter action:@selector(iWasTouched)];
    UITapGestureRecognizer *tapHealer = [[UITapGestureRecognizer alloc] initWithTarget:healer action:@selector(iWasTouched)];
    [self.hunter setUserInteractionEnabled:YES];
    [self.healer setUserInteractionEnabled:YES];
    [tapHunter setNumberOfTapsRequired:1];
    [tapHealer setNumberOfTapsRequired:1];
    [tapHunter setNumberOfTouchesRequired:1];
    [tapHealer setNumberOfTouchesRequired:1];
    [self.hunter addGestureRecognizer:tapHunter];
    [self.healer addGestureRecognizer:tapHealer];
}

- (void)viewDidLoad
{
    [Game instance].numPlayers = 10;
    [Game instance].numWerewolves = 3;
    [Game instance].hunter = false;
    [Game instance].healer = false;
    [super viewDidLoad];
}

- (void)hunterTapped
{
    if([Game instance].hunter)
    {
        [Game instance].hunter = NO;
        [self.hunter dim:YES];
    }
    else
    {
        [Game instance].hunter = YES;
        [self.hunter dim:NO];
    }
    self.layout.hunter = [Game instance].hunter;
}

- (void)healerTapped
{
    if([Game instance].healer)
    {
        [Game instance].healer = NO;
        [self.healer dim:YES];
    }
    else
    {
        [Game instance].healer = YES;
        [self.healer dim:NO];
    }
    self.layout.healer = [Game instance].healer;
}

- (void)playerWasTouched:(PlayerView *)player
{
    if(player.type == C_HUNTER)
        [self hunterTapped];
    else if(player.type == C_HEALER)
        [self healerTapped];
}

- (void)playerWasLongTouched:(PlayerView *)player
{
    NSLog(@"The User is an idiot...");
}

@end
