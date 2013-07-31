//
//  TypePickerViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/21/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Player.h"
#import "CampfireCircleView.h"


@interface TypePickerViewController : UIViewController <CampfireCircleViewDelegate>{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *numLeftLabel;
    IBOutlet UIButton *done;
    IBOutlet CampfireCircleView *campFireCircle;
    int numLeft;
    int state; //0- WerewolfPicker; 1- HunterPicker; 2- HealerPicker;
}

@property (retain) IBOutlet UILabel *titleLabel;
@property (retain) IBOutlet UILabel *numLeftLabel;
@property (retain) IBOutlet UIButton *done;
@property (retain) IBOutlet CampfireCircleView *campFireCircle;
@property int numLeft;
@property int state;


- (IBAction)backButtonPressed;
- (IBAction)diceButtonPressed;
- (IBAction)doneButtonPressed;

@end
