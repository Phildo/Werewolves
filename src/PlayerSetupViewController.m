//
//  PlayerSetupViewController.m
//  Werewolves
//
//  Created by Philip Dougherty on 8/8/11.
//  Copyright 2011 UW Madison. All rights reserved.
//

#import "PlayerSetupViewController.h"
#import "Game.h"
#import "Player.h"
#import "PlayerView.h"
#import "PlayerPositionView.h"
//#import "TypePickerViewController.h"

@interface PlayerSetupViewController() <UIScrollViewDelegate,UITextFieldDelegate>
{
    IBOutlet UIScrollView *scrollView;
    NSMutableArray *playerNames;
    id<PlayerSetupViewControllerDelegate> __unsafe_unretained delegate;
}
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *playerNames;
@end

@implementation PlayerSetupViewController

@synthesize scrollView;
@synthesize playerNames;

- (id) initWithDelegate:(id<PlayerSetupViewControllerDelegate>)d numPlayers:(int)p
{
    if (self = [super initWithNibName:@"PlayerSetupViewController" bundle:nil])
    {
        playerNames = [[NSMutableArray alloc] initWithCapacity:p];
        for(int i = 0; i < p; i++)
            [playerNames addObject:[NSString stringWithFormat:@"Player %d",i+1]];
    }
    return self;
}

- (void) viewDidLoad
{
    int yPos = 20;
    self.scrollView.contentSize = CGSizeMake(320, 20+(51*[self.playerNames count]));
    for(int i = 0; i < [self.playerNames count]; i++)
    {
        UIImageView *playerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, yPos-10, 32, 48)];
        [playerIcon setImage:[UIImage imageNamed:@"villager.png"]];
        [self.scrollView addSubview:playerIcon];
        
        UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(60, yPos, 200, 31)];
        nameField.borderStyle = UITextBorderStyleRoundedRect;
        nameField.clearsOnBeginEditing = YES;
        nameField.tag = i;
        nameField.delegate = self;
        nameField.text = [NSString stringWithFormat:@"Player %d",i+1];
        [self.scrollView addSubview:nameField];
        
        PlayerPositionView *positionView = [[PlayerPositionView alloc] initWithFrame:CGRectMake(265, yPos-8, 50, 50)];
        [positionView setCount:[self.playerNames count]];
        [positionView setPosition:i];
        [self.scrollView addSubview:positionView];
        
        yPos+=51;
    }
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(0, textField.center.y - 150) animated:YES];
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text isEqualToString:@""]) textField.text = [NSString stringWithFormat:@"Player %d", textField.tag+1];
    [playerNames replaceObjectAtIndex:textField.tag withObject:textField.text];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) nextButtonPressed
{
    //TypePickerViewController *typePicker = [[TypePickerViewController alloc] init];
    //[self.navigationController pushViewController:typePicker animated:YES];
}

@end
