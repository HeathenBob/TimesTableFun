//
//  FENumberLabel.m
//  TimesTableFun
//
//  Created by Felix Elliott on 09/06/2012.
//  Copyright (c) 2012 Heathen Bob. All rights reserved.
//

#import "FENumberLabel.h"
#import "FETheme.h"

@implementation FENumberLabel

@synthesize originalYOffset;
@synthesize originalXOffset;
@synthesize numberValue;
@synthesize done;

- (void) dealloc {
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithNumber:(NSInteger)number andPosition:(NSInteger)ordinal andMultiple:(NSInteger)multiple andYOffset:(float)yOffset andXOffset:(float)xOffset {
    
    self = [super init];
    if (self) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            width = 40;
            height = 40;
            gap = 4;
            leftSpace = xOffset;
            fontSize = 28;
        } else {
            width = 20;
            height = 20;
            gap = 2;
            leftSpace = xOffset;
            fontSize = 14;
        }
		self.numberValue = number;
		self.font = [UIFont boldSystemFontOfSize:fontSize];
		[self setTextAlignment:UITextAlignmentCenter];
        self.textColor = [UIColor whiteColor];
        int rand = number % 6;
        FETheme *theme = [[FETheme alloc] init];
        if (rand == 1) {
            self.backgroundColor = [theme color1];
        } else if (rand == 2) {
            self.backgroundColor = [theme color2];
        } else if (rand == 3) {
            self.backgroundColor = [theme color3];
        } else if (rand == 4) {
            self.backgroundColor = [theme color4];
        } else if (rand == 5) {
            self.backgroundColor = [theme color5];
        } else {
            self.backgroundColor = [theme color6];
        }
        [theme release];
        CGRect rect = self.frame;
		rect.size.width = width;
		rect.size.height = height;
		rect.origin.x = xOffset + ((ordinal % multiple) *(width + gap));
		self.originalXOffset = xOffset + ((ordinal % multiple) *(width + gap));
		if (ordinal < multiple) {
			rect.origin.y = yOffset;
			self.originalYOffset = yOffset;
		} else {
			rect.origin.y = yOffset + ((ordinal/multiple) *(height + gap));
			self.originalYOffset = yOffset + ((ordinal/multiple) *(height + gap));
		}
		self.frame = rect;
        self.done = NO;
    }
    return self;
}

- (void) displayValue {
    if (self.numberValue > 0) {
    self.text = [NSString stringWithFormat:@"%i", self.numberValue];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
