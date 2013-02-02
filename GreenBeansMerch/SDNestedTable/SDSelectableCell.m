//
//  SDSelectableCell.m
//  SDNestedTablesExample
//
//  Created by Daniele De Matteis on 23/05/2012.
//  Copyright (c) 2012 Daniele De Matteis. All rights reserved.
//

#import "SDSelectableCell.h"

@implementation SDSelectableCell

@synthesize itemText, parentTable, selectableCellState;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        selectableCellState = Unchecked;
    }
    return self;
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    [self setupInterface];
}

- (void) setupInterface
{
    [self setClipsToBounds: YES];
    
    tapTransitionsOverlay.backgroundColor = [UIColor colorWithRed:0.15 green:0.54 blue:0.93 alpha:1.0];
    
    CGRect frame = self.itemText.frame;
    frame.size.width = checkBox.frame.origin.x - frame.origin.x - (int)(self.frame.size.width/30);
    self.itemText.frame = frame;
}

- (SelectableCellState) toggleCheck
{
    if (selectableCellState == Checked)
    {
        selectableCellState = Unchecked;
        [self styleDisabled];
    }
    else
    {
        selectableCellState = Checked;
        [self styleEnabled];
    }
    return selectableCellState;
}

- (void) check
{
    selectableCellState = Checked;
    [self styleEnabled];
}

- (void) uncheck
{
    selectableCellState = Unchecked;
    [self styleDisabled];
}

- (void) halfCheck
{
    selectableCellState = Halfchecked;
    [self styleHalfEnabled];
}

- (void) styleEnabled
{
//    itemText.alpha = 1.0;
//    itemText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
//    self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient_header"]];
//    self.backgroundView.alpha = 1.0f;
}

- (void) styleDisabled
{
    itemText.alpha = 1.0;
    itemText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0f];
    self.backgroundView.backgroundColor = [UIColor grayColor];
    self.backgroundView.alpha = 1.0f;
}

- (void) styleHalfEnabled
{
//    itemText.alpha = 1.0;
//    itemText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
//    self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient_header"]];
//    self.backgroundView.alpha = 1.0f;
}

- (void) tapTransition
{
    tapTransitionsOverlay.alpha = 1.0;
    [UIView beginAnimations:@"tapTransition" context:nil];
    [UIView setAnimationDuration:0.8];
    tapTransitionsOverlay.alpha = 0.0;
    [UIView commitAnimations];
}

@end
