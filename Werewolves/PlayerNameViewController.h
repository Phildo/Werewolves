//
//  PlayerNameViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/8/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Player.h"
#import "PlayerView.h"
#import "CirclePositionView.h"
#import "TypePickerViewController.h"

@interface PlayerNameViewController : UIViewController <UIScrollViewDelegate,UITextFieldDelegate>{
    IBOutlet UIScrollView *scrollyPants;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollyPants;

- (IBAction)backButtonPressed;
- (IBAction)nextButtonPressed;
- (void)releaseOutlets;

@end
