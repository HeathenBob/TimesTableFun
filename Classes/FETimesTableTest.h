//
//  FETimesTableTest.h
//  TimesTableFun
//
//  Created by Felix Elliott on 30/08/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h> 
#import "FENumberButton.h"
#import "TimesTableFunAppDelegate.h"

@interface FETimesTableTest : UIViewController <UITextViewDelegate> {
	TimesTableFunAppDelegate *myDelegate;
	NSMutableArray *numberButtons;
	FENumberButton *touchedButton;
	CGPoint lastTouch;
    CGPoint currentTouch;
	int touchOffsetX;
	int touchOffsetY;
	NSInteger whichTable;
	NSInteger timesBy;
	NSInteger timesByIndex;
	NSMutableArray *timesByValues;
	NSInteger score;
	IBOutlet UILabel *answerSlot;
	IBOutlet UILabel *answerSlotBackground;
	IBOutlet UILabel *firstLabel;
	IBOutlet UILabel *timesLabel;
	IBOutlet UILabel *secondLabel;
	IBOutlet UILabel *equalsLabel;
	IBOutlet UILabel *instructionLabel;
	IBOutlet UITextView *highScoresLabel;
	IBOutlet UILabel *scoreLabel;
	IBOutlet UIButton *correctButton;
	SystemSoundID successSound;
	SystemSoundID sorrySound;
}

@property (nonatomic, retain) TimesTableFunAppDelegate *myDelegate;
@property (nonatomic, retain) NSMutableArray *numberButtons;
@property (nonatomic, retain) NSMutableArray *timesByValues;
@property (nonatomic, retain) IBOutlet UILabel *answerSlot;
@property (nonatomic, retain) IBOutlet UILabel *answerSlotBackground;
@property (nonatomic, retain) IBOutlet UILabel *firstLabel;
@property (nonatomic, retain) IBOutlet UILabel *timesLabel;
@property (nonatomic, retain) IBOutlet UILabel *secondLabel;
@property (nonatomic, retain) IBOutlet UILabel *equalsLabel;
@property (nonatomic, retain) IBOutlet UILabel *instructionLabel;
@property (nonatomic, retain) IBOutlet UITextView *highScoresLabel;
@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property (nonatomic, retain) IBOutlet UIButton *correctButton;
@property (nonatomic) NSInteger whichTable;
@property NSInteger score;

- (void) start;
- (IBAction) nextButtonClicked;
- (void)randomizeArray:(NSMutableArray *) passedArray;
- (void) playSuccessSound;
- (void) playSorrySound;
- (void) recordHighScore;
- (void) clearNumberButtons;
- (NSMutableArray *) generateRandomAnswersArrayOfSize:(NSInteger)arraySize forAnswer:(NSInteger)answer;

@end

