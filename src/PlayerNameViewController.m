//
//  PlayerNameViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/8/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "PlayerNameViewController.h"


@implementation PlayerNameViewController

@synthesize scrollyPants;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) nextButtonPressed
{
    TypePickerViewController *typePicker = [[TypePickerViewController alloc] init];
    [self.navigationController pushViewController:typePicker animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    int yPos = 20;
    self.scrollyPants.contentSize = CGSizeMake(320, 20+51*[[Game instance].players count]);
    for(int x = 0; x < [[Game instance].players count]; x++)
    {
        PlayerView *tempPlayer = [[PlayerView alloc] initWithFrame:CGRectMake(15, yPos-10, 32, 48)];
        [tempPlayer setAppearanceToType:C_VILLAGER state:C_AWAKE faded:NO];
        [self.scrollyPants addSubview:tempPlayer];
        
        UITextField *tempText = [[UITextField alloc] initWithFrame:CGRectMake(60, yPos, 200, 31)];
        tempText.delegate = self;
        tempText.borderStyle = UITextBorderStyleRoundedRect;
        tempText.tag = x;
        tempText.clearsOnBeginEditing = YES;
        tempText.text = ((Player *)[[Game instance].players objectAtIndex:x]).name;
        [self.scrollyPants addSubview:tempText];
        
        CirclePositionView *tempCV = [[CirclePositionView alloc] initWithFrame:CGRectMake(265, yPos-8, 50, 50)];
        tempCV.backgroundColor = [UIColor clearColor];
        tempCV.delegate = self;
        tempCV.location = x;
        tempCV.count = [Game instance].numPlayers;
        [tempCV setup];
        [self.scrollyPants addSubview:tempCV];
        
        yPos+=51;
    }
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scrollyPants setContentOffset:CGPointMake(0, textField.center.y - 150) animated:YES];
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text isEqualToString:@""]){
        textField.text = [NSString stringWithFormat:@"Player %d", textField.tag+1];
    }
    else ((Player *)[[Game instance].players objectAtIndex:textField.tag]).name= textField.text;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
