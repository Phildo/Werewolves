//
//  HealerPickerViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/18/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Player.h"
#import "CampfireCircleView.h"

@interface HealerPickerViewController : UIViewController <CampfireCircleViewDelegate>{
    
    IBOutlet UIButton *done;
    IBOutlet CampfireCircleView *campFireCircle;
}

@property (retain) IBOutlet UIButton *done;
@property (retain) IBOutlet CampfireCircleView *campFireCircle;


- (IBAction)backButtonPressed;
- (IBAction)diceButtonPressed;
- (IBAction)doneButtonPressed;

@end