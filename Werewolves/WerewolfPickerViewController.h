//
//  WerewolfPickerViewController.h
//  Werewolves
//
//  Created by Philip Dougherty on 8/16/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WerewolfPickerViewController : UIViewController {
    int numLeft;
    IBOutlet UILabel *numLeftLabel;
    IBOutlet UIButton *done;
}

@property int numLeft;
@property (retain) IBOutlet UILabel *numLeftLabel;
@property (retain) IBOutlet UIButton *done;

- (IBAction)backButtonPressed;
- (IBAction)diceButtonPressed;
- (IBAction)doneButtonPressed;

@end
