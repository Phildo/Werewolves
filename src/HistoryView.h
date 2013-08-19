//
//  HistoryView.h
//  werewolves
//
//  Created by Phil Dougherty on 8/18/13.
//  Copyright (c) 2013 Phildo Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Move;
@class HistoryView;

@protocol HistoryViewDelegate
- (void) move:(Move *)m withView:(HistoryView *)h wasTouched:(UITapGestureRecognizer *)g;
@end

@interface HistoryView : UIView
- (id) initWithFrame:(CGRect)frame move:(Move *)m delegate:(id<HistoryViewDelegate>)d;
@end
