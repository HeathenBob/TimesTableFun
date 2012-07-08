//
//  NumberLabel.h
//  MovingButtons
//
//  Created by Felix Elliott on 21/08/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NumberLabel : UILabel {
	NSInteger numberValue;
	NSInteger originalYOffset;
	NSInteger originalXOffset;
}

@property (nonatomic) NSInteger numberValue;
@property (nonatomic) NSInteger originalYOffset;
@property (nonatomic) NSInteger originalXOffset;

- (id) initWithNumber: (NSInteger) number andPosition: (NSInteger) ordinal andYOffset: (NSInteger) yOffset;
- (void) returnToOriginalPosition;

@end
