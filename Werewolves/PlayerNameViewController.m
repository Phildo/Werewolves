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
    WerewolfPickerViewController *wolfPicker = [[WerewolfPickerViewController alloc] init];
    [self.navigationController pushViewController:wolfPicker animated:YES];
    [wolfPicker release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)releaseOutlets
{
    self.scrollyPants = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    int yPos = 20;
    self.scrollyPants.contentSize = CGSizeMake(320, 20+51*[[Game instance].players count]);
    for(int x = 0; x < [[Game instance].players count]; x++)
    {
        PlayerView *tempPlayer = [[PlayerView alloc] initWithFrame:CGRectMake(15, yPos-10, 32, 48)];
        [tempPlayer setAppearanceToType:[AppConstants instance].VILLAGER state:[AppConstants instance].AWAKE faded:NO];
        [self.scrollyPants addSubview:tempPlayer];
        [tempPlayer release];
        
        UITextField *tempText = [[UITextField alloc] initWithFrame:CGRectMake(60, yPos, 200, 31)];
        tempText.delegate = self;
        tempText.borderStyle = UITextBorderStyleRoundedRect;
        tempText.tag = x;
        tempText.clearsOnBeginEditing = YES;
        tempText.text = ((Player *)[[Game instance].players objectAtIndex:x]).name;
        [self.scrollyPants addSubview:tempText];
        [tempText release];
        
        CirclePositionView *tempCV = [[CirclePositionView alloc] initWithFrame:CGRectMake(265, yPos-8, 50, 50)];
        tempCV.backgroundColor = [UIColor clearColor];
        tempCV.delegate = self;
        tempCV.location = x;
        tempCV.count = [Game instance].numPlayers;
        [tempCV setup];
        [self.scrollyPants addSubview:tempCV];
        [tempCV release];
        
        yPos+=51;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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

- (void)viewDidUnload
{
    [self releaseOutlets];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [self releaseOutlets];
    [super dealloc];
}

@end
