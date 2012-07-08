//
//  NumberButton.m
//  MovingButtons
//
//  Created by Felix Elliott on 23/08/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import "FENumberButton.h"
#import "FEUtils.h"

@implementation FENumberButton

@synthesize originalYOffset;
@synthesize originalXOffset;
@synthesize done;
@synthesize parent;
@synthesize passOnTouches;

- (id) init {
    if (self = [super init]) {  
		self.numberValue = -1;
		self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
		[self.titleLabel setTextAlignment:UITextAlignmentCenter];
		//[self setBackgroundColor:[UIColor clearColor]];
		[self setBackgroundImage:[UIImage imageNamed:@"heart_blue.png"] forState:UIControlStateNormal];
		[self setBackgroundImage:[UIImage imageNamed:@"heart_green.png"] forState:UIControlStateHighlighted];
		[self setBackgroundImage:[UIImage imageNamed:@"heart_pink.png"] forState:UIControlStateSelected];
		[self setBackgroundImage:[UIImage imageNamed:@"heart_grey.png"] forState:UIControlStateDisabled];
		CGRect rect = self.frame;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            rect.size.width = 100;
            rect.size.height = 100;
        } else {
            rect.size.width = 50;
            rect.size.height = 50;
        }
		self.frame = rect;
        self.done = NO;
        self.passOnTouches = false;
    }
	
    return self;
}

- (id) initWithNumber:(NSInteger)number andPosition:(NSInteger)ordinal andYOffset:(float)yOffset andXOffset:(float)xOffset andTheme:(FETheme *)theme andParent:(UIViewController *)parentController {
    if (self = [super init]) {  
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            width = 100;
            height = 100;
            gap = 20;
            leftSpace = xOffset;
            fontSize = 30;
        } else {
            width = 50;
            height = 50;
            gap = 10;
            leftSpace = xOffset;
            fontSize = 18;
        }
		self.numberValue = number;
        self.parent = parentController;
		self.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
		[self.titleLabel setTextAlignment:UITextAlignmentCenter];
		[self setBackgroundImage:[theme getNormalButtonImage] forState:UIControlStateNormal];
		[self setBackgroundImage:[theme getHighlightButtonImage] forState:UIControlStateHighlighted];
		[self setBackgroundImage:[theme getSelectedButtonImage] forState:UIControlStateSelected];
		[self setBackgroundImage:[theme getDisabledButtonImage] forState:UIControlStateDisabled];
		CGRect rect = self.frame;
		rect.size.width = width;
		rect.size.height = height;
		rect.origin.x = leftSpace + (width * (ordinal % 5)) + (6 * (ordinal % 5));
		self.originalXOffset = leftSpace + (width * (ordinal % 5)) + (6 * (ordinal % 5));
		if (ordinal < 5) {
			rect.origin.y = yOffset;
			self.originalYOffset = yOffset;
		} else {
			rect.origin.y = yOffset + height + gap;
			self.originalYOffset = yOffset + height + gap;
		}
		self.frame = rect;
        self.done = NO;
        self.passOnTouches = YES;
    }
	
    return self;
}


- (void) setNumberValue:(NSInteger) number {
	numberValue = number;
	[self setTitle:[NSString stringWithFormat:@"%i", number] forState:UIControlStateNormal];
	[self setTitle:[NSString stringWithFormat:@"%i", number] forState:UIControlStateHighlighted];
	[self setTitle:[NSString stringWithFormat:@"%i", number] forState:UIControlStateSelected];
	[self setTitle:[NSString stringWithFormat:@"%i", number] forState:UIControlStateDisabled];
}
- (NSInteger) numberValue {
	return numberValue;
}

- (void) returnToOriginalPosition {
	
	
	CGRect rect = self.frame;
	rect.origin.x = self.originalXOffset;
	rect.origin.y = self.originalYOffset;
	rect.size.width = width;
	rect.size.height = height;
	self.frame = rect;
	
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.passOnTouches) {
        self.selected = YES;
        [self.parent touchesBegan:touches withEvent:event];
    } else {
        [super touchesBegan:touches withEvent:event];
    }
	
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.passOnTouches) {
        //[FEUtils debug:@"FENumberButton touches moved"];
        [self.parent touchesMoved:touches withEvent:event];
    } else {
        [super touchesMoved:touches withEvent:event];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.passOnTouches) {
        self.selected = NO;
        [self.parent touchesEnded:touches withEvent:event];
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.passOnTouches) {
        self.selected = NO;
        [self.parent touchesCancelled:touches withEvent:event];
    } else {
        [super touchesCancelled:touches withEvent:event];
    }
}
 

@end

