//
//  NumberLabel.m
//  MovingButtons
//
//  Created by Felix Elliott on 21/08/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import "NumberLabel.h"


@implementation NumberLabel

@synthesize originalYOffset;
@synthesize originalXOffset;

- (id) init {
    if (self = [super init]) {  
		self.numberValue = -1;
		[self setTextAlignment:UITextAlignmentCenter];
		//[self setBackgroundColor:[UIColor clearColor]];
		[self setBackgroundColor:[UIColor blueColor]];
		CGRect rect = self.frame;
		rect.size.width = 30;
		rect.size.height = 30;
		self.frame = rect;
    }
    return self;
}

- (id) initWithNumber: (NSInteger) number andPosition: (NSInteger) ordinal andYOffset: (NSInteger) yOffset {
    if (self = [super init]) {  
		self.numberValue = number;
		[self setTextAlignment:UITextAlignmentCenter];
		//[self setBackgroundColor:[UIColor clearColor]];
		CGRect rect = self.frame;
		rect.size.width = 50;
		rect.size.height = 30;
		rect.origin.x = 20 + (50 * (ordinal % 5)) + (6 * (ordinal % 5));
		self.originalXOffset = 20 + (50 * (ordinal % 5)) + (6 * (ordinal % 5));
		if (ordinal < 5) {
			rect.origin.y = yOffset;
			self.originalYOffset = yOffset;
		} else {
			rect.origin.y = yOffset + 50;
			self.originalYOffset = yOffset + 50;
		}
		self.frame = rect;
    }
    return self;
}


- (void) setNumberValue:(NSInteger) number {
	numberValue = number;
	[self setText:[NSString stringWithFormat:@"%i", number]];
}
- (NSInteger) numberValue {
	return numberValue;
}

- (void) returnToOriginalPosition {
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:10];
	CGRect rect = self.frame;
	rect.origin.x = self.originalXOffset;
	rect.origin.y = self.originalYOffset;
	rect.size.width = 50;
	rect.size.height = 30;
	self.frame = rect;
	[UIView commitAnimations];
	
}

@end
