//
//  GameSettingsPickerViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/6/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerNameViewController.h"
#import "PlayerView.h"
#import "CirclePositionView.h"
#import "Game.h"
#import "Player.h"


@interface GameSettingsPickerViewController : UIViewController {
    IBOutlet UISlider *playersSlider;
    IBOutlet UISlider *splitSlider;
    IBOutlet PlayerView *werewolf;
    IBOutlet PlayerView *villager;
    IBOutlet PlayerView *hunter;
    IBOutlet PlayerView *healer;
    IBOutlet CirclePositionView *layout;
    IBOutlet UILabel *numPlayers;
    IBOutlet UILabel *numWerewolves;
    IBOutlet UILabel *numVillagers;
    IBOutlet UILabel *maxWerewolves;
    
    BOOL splitEdited;
}

@property (retain) IBOutlet UISlider *playersSlider;
@property (retain) IBOutlet UISlider *splitSlider;
@property (retain) IBOutlet PlayerView *werewolf;
@property (retain) IBOutlet PlayerView *villager;
@property (retain) IBOutlet PlayerView *hunter;
@property (retain) IBOutlet PlayerView *healer;
@property (retain) IBOutlet CirclePositionView *layout;
@property (retain) IBOutlet UILabel *numPlayers;
@property (retain) UILabel *numWerewolves;
@property (retain) UILabel *numVillagers;
@property (retain) UILabel *maxWerewolves;

@property BOOL splitEdited;

- (IBAction)numPlayersChanged:(UISlider *)sender;
- (IBAction)splitChanged:(UISlider *)sender;
- (IBAction)startButtonPressed; 
- (IBAction)backButtonPressed; 

@end
