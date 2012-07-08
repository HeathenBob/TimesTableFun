//
//  FTTheme.m
//  TimesTableFun
//
//  Created by Felix Elliott on 28/08/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import "FETheme.h"


@implementation FETheme

@synthesize normalButtonImage;
@synthesize selectedButtonImage;
@synthesize highlightButtonImage;
@synthesize disabledButtonImage;

-(id)init {
    if (self = [super init])  {
		// Initialization code here
    }
    return self;
}

- (UIImage *) getNormalButtonImage {
	return self.normalButtonImage;
}

- (UIImage *) getSelectedButtonImage {
	return self.selectedButtonImage;
}

- (UIImage *) getHighlightButtonImage {
	return self.highlightButtonImage;
}

- (UIImage *) getDisabledButtonImage {
	return self.disabledButtonImage;
}

- (UIColor *) color1 { // red
	return [UIColor colorWithRed:1.0 green:0.2 blue:0.4 alpha:1.0];
}
- (UIColor *) color2 { // orange
	return [UIColor colorWithRed:1.0 green:0.4 blue:0.2 alpha:1.0];
}
- (UIColor *) color3 { // yellow
	return [UIColor colorWithRed:1.0 green:0.8 blue:0.2 alpha:1.0];
}
- (UIColor *) color4 { // magenta
	return [UIColor colorWithRed:1.0 green:0.2 blue:0.8 alpha:1.0];
}
- (UIColor *) color5 { // light blue
	return [UIColor colorWithRed:0.2 green:0.8 blue:1.0 alpha:1.0];
}
- (UIColor *) color6 { // green
	return [UIColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:1.0];
}
- (UIColor *) textColor {
	//return [UIColor colorWithRed:0.2 green:0.4 blue:1.0 alpha:1.0];
	return [UIColor colorWithRed:0.0 green:0.2 blue:0.3 alpha:1.0];
}

- (void) dealloc {
	[normalButtonImage release];
	[selectedButtonImage release];
	[highlightButtonImage release];
	[disabledButtonImage release];
	[super dealloc];
}

@end
