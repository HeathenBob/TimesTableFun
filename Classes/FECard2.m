//
//  FECard.m
//  Flip
//
//  Created by Felix Elliott on 31/10/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import "FECard2.h"


@implementation FECard2

@synthesize faceUp;
@synthesize pos;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        intValue = 1;
        // Initialization code
		NSString *stringValue = [NSString stringWithFormat:@"%i", intValue];
		[self setTitle:stringValue forState:UIControlStateNormal];
		[self setTitle:stringValue forState:UIControlStateHighlighted];
		[self setTitle:stringValue forState:UIControlStateSelected];
		[self setTitle:stringValue forState:UIControlStateDisabled];
		[self setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
		[self setTitleColor:[UIColor clearColor] forState:UIControlStateSelected];
		[self setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
		UIImage *face;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            face = [UIImage imageNamed:@"card_blue~ipad"];
        } else {
            face = [UIImage imageNamed:@"card_blue"];
        }
		[self setBackgroundImage:face forState:UIControlStateNormal];
		[self setBackgroundImage:face forState:UIControlStateSelected];
		[self setBackgroundImage:face forState:UIControlStateHighlighted];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void) setIntValue: (int) val {
	intValue = val;
	NSString *stringValue = [NSString stringWithFormat:@"%i", intValue];
	[self.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
	[self setTitle:stringValue forState:UIControlStateNormal];
	[self setTitle:stringValue forState:UIControlStateHighlighted];
	[self setTitle:stringValue forState:UIControlStateSelected];
	[self setTitle:stringValue forState:UIControlStateDisabled];
}

- (int) intValue {
	return intValue;
}

- (void) turnOver {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
						   forView:self
							 cache:YES];
	UIImage *face;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        face = [UIImage imageNamed:@"card_blue_front~ipad"];
    } else {
        face = [UIImage imageNamed:@"card_blue_front"];
    }
	[self setBackgroundImage:face forState:UIControlStateNormal];
	[self setBackgroundImage:face forState:UIControlStateSelected];
	[self setBackgroundImage:face forState:UIControlStateHighlighted];
	[self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
	[self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
	self.faceUp = YES;
	[UIView commitAnimations];
}

- (void) turnBack {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
						   forView:self
							 cache:YES];
	UIImage *face;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        face = [UIImage imageNamed:@"card_blue~ipad"];
    } else {
        face = [UIImage imageNamed:@"card_blue"];
    }
	[self setBackgroundImage:face forState:UIControlStateNormal];
	[self setBackgroundImage:face forState:UIControlStateSelected];
	[self setBackgroundImage:face forState:UIControlStateHighlighted];
	[self setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
	[self setTitleColor:[UIColor clearColor] forState:UIControlStateSelected];
	[self setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
	self.faceUp = NO;
	[UIView commitAnimations];
}




- (void)dealloc {
    [super dealloc];
}


@end
