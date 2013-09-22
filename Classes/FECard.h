//
//  FECard.h
//  Flip
//
//  Created by Felix Elliott on 31/10/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FECard : UIButton {
	BOOL faceUp;
	int intValue;
	int timesBy;
	int pos;
}

@property BOOL faceUp;
@property int timesBy;
@property int pos;

- (void) turnOver;
- (void) turnBack;
- (int) intValue;
- (void) setIntValue:(int)val andTimesBy:(int)times;

@end
