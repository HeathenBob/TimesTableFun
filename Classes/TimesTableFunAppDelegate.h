//
//  TimesTableFunAppDelegate.h
//  TimesTableFun
//
//  Created by Felix Elliott on 28/08/2010.
//  Copyright Fatrod Enterprises 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FETheme.h"

@interface TimesTableFunAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	FETheme *selectedTheme;
	NSInteger selectedNumber;
	UIView *tableBackgroundView;
	NSString *userName;
	NSMutableDictionary *gameHighScores;
	NSMutableDictionary *pairsHighScores;
	NSMutableDictionary *testHighScores;
	 
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) FETheme *selectedTheme;
@property (nonatomic) NSInteger selectedNumber;
@property (nonatomic, retain) UIView *tableBackgroundView;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSMutableDictionary *gameHighScores;
@property (nonatomic, retain) NSMutableDictionary *pairsHighScores;
@property (nonatomic, retain) NSMutableDictionary *testHighScores;



@end

