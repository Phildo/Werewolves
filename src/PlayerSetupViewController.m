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
    UIScrollView *scrollView;
    NSMutableArray *playerNameViews;
    id<PlayerSetupViewControllerDelegate> __unsafe_unretained delegate;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *playerNameViews;
@end

@implementation PlayerSetupViewController

@synthesize scrollView;
@synthesize playerNameViews;

- (id) initWithViewFrame:(CGRect)f delegate:(id<PlayerSetupViewControllerDelegate>)d numPlayers:(int)p
{
    if (self = [super initWithViewFrame:f])
    {
        self.title = @"player setup";
        self.playerNameViews = [[NSMutableArray alloc] initWithCapacity:p];
        for(int i = 0; i < p; i++)
        {
            UITextField *playerNameView = [[UITextField alloc] init];
            playerNameView.autocorrectionType = UITextAutocorrectionTypeNo;
            playerNameView.autocapitalizationType = UITextAutocapitalizationTypeNone;
            playerNameView.text = [NSString stringWithFormat:@"player %d",i+1];
            [self.playerNameViews addObject:playerNameView];
        }
    }
    return self;
}

- (void) loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 10+(58*[self.playerNameViews count])+50+300);
    int cellHeight = 48;
    int padding = 10;
    int yPos = padding;
    for(int i = 0; i < [self.playerNameViews count]; i++)
    {
        CGFloat iconx = padding;
        CGFloat icony = yPos;
        CGFloat iconw = 32;
        CGFloat iconh = cellHeight;
        UIImageView *playerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(iconx, icony, iconw, iconh)];
        [playerIcon setImage:[UIImage imageNamed:@"villager.png"]];
        [self.scrollView addSubview:playerIcon];
        
        CGFloat posiconx = self.view.bounds.size.width-padding-(cellHeight-2);
        CGFloat posicony = yPos+1;
        CGFloat posiconw = cellHeight-2;
        CGFloat posiconh = cellHeight-2;
        PlayerPositionView *positionView = [[PlayerPositionView alloc] initWithFrame:CGRectMake(posiconx, posicony, posiconw, posiconh)];
        [positionView setCount:[self.playerNameViews count]];
        [positionView setPosition:i];
        [self.scrollView addSubview:positionView];
        
        CGFloat textfieldx = iconx+iconw+padding;
        CGFloat textfieldy = yPos+(int)((cellHeight-31)/2);
        CGFloat textfieldw = posiconx-padding-textfieldx;
        CGFloat textfieldh = 31;
        UITextField *playerNameView = [self.playerNameViews objectAtIndex:i];
        playerNameView.frame = CGRectMake(textfieldx, textfieldy, textfieldw, textfieldh);
        playerNameView.tag = i;
        playerNameView.delegate = self;
        [self.scrollView addSubview:playerNameView];
        
        yPos+=cellHeight+padding;
    }
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(padding, yPos, self.view.bounds.size.width-(2*padding), 40);
    [nextButton setTitle:@"next" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:nextButton];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField.text isEqualToString:[NSString stringWithFormat:@"player %d", textField.tag+1]]) textField.text = @"";
    
    int keyboardReach = self.scrollView.frame.size.height-300;
    if(textField.frame.origin.y-self.scrollView.contentOffset.y > keyboardReach)
        [self.scrollView setContentOffset:CGPointMake(0, textField.frame.origin.y-(self.scrollView.frame.size.height-keyboardReach)) animated:YES];
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text isEqualToString:@""]) textField.text = [NSString stringWithFormat:@"player %d", textField.tag+1];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField.tag+1 != [self.playerNameViews count]) [[self.playerNameViews objectAtIndex:textField.tag+1] becomeFirstResponder];
    return YES;
}

- (void) nextButtonTouched
{
    [self.view endEditing:YES];
    //TypePickerViewController *typePicker = [[TypePickerViewController alloc] init];
    //[self.navigationController pushViewController:typePicker animated:YES];
}

@end
