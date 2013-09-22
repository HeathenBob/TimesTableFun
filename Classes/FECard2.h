//
//  FECard2.h
//  TimesTableFun
//
//  Created by Felix Elliott on 29/12/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface FECard2 : UIButton {
	BOOL faceUp;
	int intValue;
	int pos;
}

@property BOOL faceUp;
@property int pos;

- (void) turnOver;
- (void) turnBack;
- (int) intValue;
- (void) setIntValue: (int) val;

@end
