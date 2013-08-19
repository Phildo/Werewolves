//
//  HistoryBrowserView.m
//  werewolves
//
//  Created by Phil Dougherty on 8/18/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import "HistoryBrowserView.h"
#import "HistoryView.h"

@interface HistoryBrowserView() <HistoryViewDelegate>
{
    UIScrollView *scrollView;
    NSMutableArray *history;
    id<HistoryBrowserViewDelegate> __unsafe_unretained delegate;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *history;
@end

@implementation HistoryBrowserView

@synthesize scrollView;
@synthesize history;

- (id) initWithFrame:(CGRect)frame delegate:(id<HistoryBrowserViewDelegate>)d history:(NSMutableArray *)h
{
    if(self = [super initWithFrame:frame])
    {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
        [self updateHistory:h];
        delegate = d;
    }
    return self;
}

- (void) updateHistory:(NSMutableArray *)h
{
    self.history = h;
    while([[self.scrollView subviews] count] > 0)
        [[[self.scrollView subviews] objectAtIndex:0] removeFromSuperview];
    for(int i = 0; i < [h count]; i++)
        [self.scrollView addSubview:[[HistoryView alloc] initWithFrame:CGRectMake(i*40,0,40,self.bounds.size.height) move:[h objectAtIndex:i] delegate:self]];
    self.scrollView.contentSize = CGSizeMake([h count]*40, self.bounds.size.height);
    [self.scrollView setContentOffset:CGPointMake([h count]*40-self.bounds.size.width,0)];
}

- (void) move:(Move *)m withView:(HistoryView *)h wasTouched:(UITapGestureRecognizer *)g
{
}

@end
