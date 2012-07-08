//
//  FEAppleTheme.m
//  TimesTableFun
//
//  Created by Felix Elliott on 05/09/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import "FEAppleTheme.h"


@implementation FEAppleTheme

-(id)init {
    self = [super init];
    if (self != nil)  {
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.normalButtonImage = [UIImage imageNamed:@"apple_red~ipad.png"];
            self.selectedButtonImage = [UIImage imageNamed:@"apple_yellow~ipad.png"];
            self.highlightButtonImage = [UIImage imageNamed:@"apple_green~ipad.png"];
            self.disabledButtonImage = [UIImage imageNamed:@"apple_grey~ipad.png"];
        } else {
         
            self.normalButtonImage = [UIImage imageNamed:@"apple_red.png"];
            self.selectedButtonImage = [UIImage imageNamed:@"apple_yellow.png"];
            self.highlightButtonImage = [UIImage imageNamed:@"apple_green.png"];
            self.disabledButtonImage = [UIImage imageNamed:@"apple_grey.png"];
        }
    }
    return self;
}



- (void)dealloc {
    [super dealloc];
}

@end
