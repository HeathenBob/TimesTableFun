//
//  NumberButton.h
//  MovingButtons
//
//  Created by Felix Elliott on 23/08/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FETheme.h"


@interface FENumberButton : UIButton {
	NSInteger numberValue;
	NSInteger originalYOffset;
	NSInteger originalXOffset;
	BOOL done;
    UIViewController *parent;
    NSInteger width;
    NSInteger height;
    NSInteger gap;
    NSInteger leftSpace;
    BOOL passOnTouches;
    int fontSize;
}

@property (nonatomic) NSInteger numberValue;
@property (nonatomic) NSInteger originalYOffset;
@property (nonatomic) NSInteger originalXOffset;
@property BOOL done;
@property (nonatomic, retain) UIViewController *parent;
@property BOOL passOnTouches;

- (id) initWithNumber:(NSInteger)number andPosition:(NSInteger)ordinal andYOffset:(float)yOffset andXOffset:(float)xOffset andTheme:(FETheme *)theme andParent:(UIViewController *)parentController;    
- (void) returnToOriginalPosition;


@end
