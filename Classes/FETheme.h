//
//  FTTheme.h
//  TimesTableFun
//
//  Created by Felix Elliott on 28/08/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FETheme : NSObject {
	UIImage *normalButtonImage;
	UIImage *selectedButtonImage;
	UIImage *highlightButtonImage;
	UIImage *disabledButtonImage;
	
}

@property (nonatomic, retain) UIImage *normalButtonImage;
@property (nonatomic, retain) UIImage *selectedButtonImage;
@property (nonatomic, retain) UIImage *highlightButtonImage;
@property (nonatomic, retain) UIImage *disabledButtonImage;

- (UIColor *) color1;
- (UIColor *) color2;
- (UIColor *) color3;
- (UIColor *) color4;
- (UIColor *) color5;
- (UIColor *) color6;
- (UIColor *) textColor;
- (UIColor *) highlightTextColor;

- (UIImage *) getNormalButtonImage;
- (UIImage *) getSelectedButtonImage;
- (UIImage *) getHighlightButtonImage;
- (UIImage *) getDisabledButtonImage;

@end
