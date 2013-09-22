//
//  FEFootballTheme.m
//  TimesTableFun
//
//  Created by Felix Elliott on 05/09/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import "FEFootballTheme.h"


@implementation FEFootballTheme

-(id)init {
    
    if (self = [super init])  {
        /*
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.normalButtonImage = [UIImage imageNamed:@"ball_blue~ipad.png"];
            self.selectedButtonImage = [UIImage imageNamed:@"ball_green~ipad.png"];
            self.highlightButtonImage = [UIImage imageNamed:@"ball_red~ipad.png"];
            self.disabledButtonImage = [UIImage imageNamed:@"ball_white~ipad.png"];
        } else {
         */
            self.normalButtonImage = [UIImage imageNamed:@"ball_blue.png"];
            self.selectedButtonImage = [UIImage imageNamed:@"ball_red.png"];
            self.highlightButtonImage = [UIImage imageNamed:@"ball_green.png"];
            self.disabledButtonImage = [UIImage imageNamed:@"ball_white.png"];
        //}
    }
    return self;
}



- (void)dealloc {
    [super dealloc];
}

@end

