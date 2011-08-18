//
//  WerewolfPickerViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/16/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Player.h"
#import "CampfireCircleView.h"
#import "HunterPickerViewController.h"
#import "HealerPickerViewController.h"


@interface WerewolfPickerViewController : UIViewController <CampfireCircleViewDelegate>{
    IBOutlet UILabel *numLeftLabel;
    IBOutlet UIButton *done;
    IBOutlet CampfireCircleView *campFireCircle;
}

@property (retain) IBOutlet UILabel *numLeftLabel;
@property (retain) IBOutlet UIButton *done;
@property (retain) IBOutlet CampfireCircleView *campFireCircle;


- (IBAction)backButtonPressed;
- (IBAction)diceButtonPressed;
- (IBAction)doneButtonPressed;

@end
