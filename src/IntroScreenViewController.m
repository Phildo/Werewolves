//
//  IntroScreenViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/5/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "IntroScreenViewController.h"


@implementation IntroScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) playButtonPressed
{
    GameSettingsPickerViewController *settings = [[GameSettingsPickerViewController alloc] init];
    [self.navigationController pushViewController:settings animated:YES];
}

- (IBAction) instructionsButtonPressed
{
    NSLog(@"Instructions Button Pressed");
}

@end
