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


@interface WerewolfPickerViewController : UIViewController <CampfireCircleViewDelegate>{
    int numLeft;
    IBOutlet UILabel *numLeftLabel;
    IBOutlet UIButton *done;
    IBOutlet CampfireCircleView *campFireCircle;
}

@property int numLeft;
@property (retain) IBOutlet UILabel *numLeftLabel;
@property (retain) IBOutlet UIButton *done;
@property (retain) IBOutlet CampfireCircleView *campFireCircle;


- (IBAction)backButtonPressed;
- (IBAction)diceButtonPressed;
- (IBAction)doneButtonPressed;

@end
