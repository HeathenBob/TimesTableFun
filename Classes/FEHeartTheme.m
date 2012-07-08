//
//  FEHeartTheme.m
//  TimesTableFun
//
//  Created by Felix Elliott on 28/08/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import "FEHeartTheme.h"


@implementation FEHeartTheme



-(id)init {
    if (self = [super init])  {
        
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.normalButtonImage = [UIImage imageNamed:@"heart_blue~ipad.png"];
            self.selectedButtonImage = [UIImage imageNamed:@"heart_green~ipad.png"];
            self.highlightButtonImage = [UIImage imageNamed:@"heart_pink~ipad.png"];
            self.disabledButtonImage = [UIImage imageNamed:@"heart_grey~ipad.png"];
        } else {
         
            self.normalButtonImage = [UIImage imageNamed:@"heart_blue.png"];
            self.selectedButtonImage = [UIImage imageNamed:@"heart_green.png"];
            self.highlightButtonImage = [UIImage imageNamed:@"heart_pink.png"];
            self.disabledButtonImage = [UIImage imageNamed:@"heart_grey.png"];
        }    
    }
    return self;
}



- (void)dealloc {
	
    [super dealloc];
}

@end
