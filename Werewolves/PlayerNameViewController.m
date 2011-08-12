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

- (void)viewDidLoad
{
    int yPos = 20;
    self.scrollyPants.contentSize = CGSizeMake(320, 20+51*[[Game instance].players count]);
    for(int x = 0; x < [[Game instance].players count]; x++)
    {
        UITextField *temp = [[UITextField alloc] initWithFrame:CGRectMake(60, yPos, 200, 31)];
        temp.delegate = self;
        temp.borderStyle = UITextBorderStyleRoundedRect;
        temp.tag = x;
        temp.clearsOnBeginEditing = YES;
        temp.text = ((Player *)[[Game instance].players objectAtIndex:x]).name;
        [self.scrollyPants addSubview:temp];
        [temp release];
        yPos+=51;
    }
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
