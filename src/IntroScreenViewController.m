//
//  IntroScreenViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/5/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "IntroScreenViewController.h"
#import "GameSettingsPickerViewController.h"

@implementation IntroScreenViewController

- (id)init
{
    if(self = [super initWithNibName:@"IntroScreenViewController" bundle:nil])
    {
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
