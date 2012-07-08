//
//  FEStarTheme.m
//  TimesTableFun
//
//  Created by Felix Elliott on 28/08/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import "FEStarTheme.h"


@implementation FEStarTheme


-(id)init {
    if (self = [super init])  {
        
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.normalButtonImage = [UIImage imageNamed:@"star_blue~ipad.png"];
            self.selectedButtonImage = [UIImage imageNamed:@"star_green~ipad.png"];
            self.highlightButtonImage = [UIImage imageNamed:@"star_pink~ipad.png"];
            self.disabledButtonImage = [UIImage imageNamed:@"star_grey~ipad.png"];
        } else {
         
            self.normalButtonImage = [UIImage imageNamed:@"star_blue.png"];
            self.selectedButtonImage = [UIImage imageNamed:@"star_green.png"];
            self.highlightButtonImage = [UIImage imageNamed:@"star_pink.png"];
            self.disabledButtonImage = [UIImage imageNamed:@"star_grey.png"];
       }
    }
    return self;
}




- (void)dealloc {
    [super dealloc];
}

@end
