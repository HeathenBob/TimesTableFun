//
//  FENumberLabel.h
//  TimesTableFun
//
//  Created by Felix Elliott on 09/06/2012.
//  Copyright (c) 2012 Heathen Bob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FENumberLabel : UILabel {
    NSInteger numberValue;
	NSInteger originalYOffset;
	NSInteger originalXOffset;
	BOOL done;
    UIViewController *parent;
    NSInteger width;
    NSInteger height;
    NSInteger gap;
    NSInteger leftSpace;
    int fontSize;

}

@property (nonatomic) NSInteger numberValue;
@property (nonatomic) NSInteger originalYOffset;
@property (nonatomic) NSInteger originalXOffset;
@property BOOL done;

- (id) initWithNumber:(NSInteger)number andPosition:(NSInteger)ordinal andMultiple:(NSInteger)multiple andYOffset:(float)yOffset andXOffset:(float)xOffset;   
- (void) displayValue;

@end
