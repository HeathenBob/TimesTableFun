//
//  MovingButtonsViewController.h
//  MovingButtons
//
//  Created by Felix Elliott on 21/08/2010.
//  Copyright Fatrod Enterprises 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h> 
#import "FENumberButton.h"
#import "TimesTableFunAppDelegate.h"

@interface FETimesTablePracticeViewController : UIViewController {
	TimesTableFunAppDelegate *myDelegate;
	NSMutableArray *numberButtons;
	FENumberButton *touchedButton;
	CGPoint lastTouch;
    CGPoint currentTouch;
	int touchOffsetX;
	int touchOffsetY;
	NSInteger whichTable;
	NSInteger timesBy;
	IBOutlet UILabel *answerSlot;
	IBOutlet UILabel *firstLabel;
	IBOutlet UILabel *timesLabel;
	IBOutlet UILabel *secondLabel;
	IBOutlet UILabel *equalsLabel;
	IBOutlet UILabel *instructionLabel;
	IBOutlet UIButton *correctButton;
	SystemSoundID successSound;
	SystemSoundID sorrySound;
	IBOutlet UIView *slideView;
	IBOutlet UILabel *slideViewLabel;
	IBOutlet UIButton *slideViewButton;
}

@property (nonatomic, retain) TimesTableFunAppDelegate *myDelegate;
@property (nonatomic, retain) NSMutableArray *numberButtons;
@property (nonatomic, retain) IBOutlet UILabel *answerSlot;
@property (nonatomic, retain) IBOutlet UILabel *firstLabel;
@property (nonatomic, retain) IBOutlet UILabel *timesLabel;
@property (nonatomic, retain) IBOutlet UILabel *secondLabel;
@property (nonatomic, retain) IBOutlet UILabel *equalsLabel;
@property (nonatomic, retain) IBOutlet UILabel *instructionLabel;
@property (nonatomic, retain) IBOutlet UIButton *correctButton;
@property (nonatomic) NSInteger whichTable;
@property (nonatomic, retain) IBOutlet UIView *slideView;
@property (nonatomic, retain) IBOutlet UILabel *slideViewLabel;
@property (nonatomic, retain) IBOutlet UIButton *slideViewButton;

- (void) start;
- (IBAction) nextButtonClicked;
- (void)randomizeArray:(NSMutableArray *) passedArray;
- (void) playSuccessSound;
- (void) playSorrySound;
- (IBAction) slideViewButtonClicked;
- (void) alternateColor;

@end

