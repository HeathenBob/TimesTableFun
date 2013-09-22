//
//  FlipViewController.h
//  Flip
//
//  Created by Felix Elliott on 29/10/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FECard.h"
#import "FECard2.h"
#import "TimesTableFunAppDelegate.h"
#import <AudioToolbox/AudioToolbox.h> 

@interface FEPairsViewController : UIViewController <UITextViewDelegate>  {
	TimesTableFunAppDelegate *myDelegate;
	NSMutableArray *redCards;
	NSMutableArray *blueCards;
	NSMutableArray *timesByValues;
	int openRed;
	int openBlue;
	int openRedValue;
	int openBlueValue;
	int tries;
	int score;
	BOOL needsTurningBack;
	NSTimer *mainTimer;
	IBOutlet UILabel *instructionLabel;
	IBOutlet UILabel *scoreLabel;
	IBOutlet UILabel *congratsLabel;
	IBOutlet UITextView *highScoresLabel;
    IBOutlet UIView *playingSurface;
    IBOutlet UIImageView *smileView;
    IBOutlet UIView *bottomBar;
	SystemSoundID successSound;
    
    float cardWidth;
    float cardHeight;
    float gap;
    float leftOffset;
    float topOffset;

}

@property (nonatomic, retain) TimesTableFunAppDelegate *myDelegate;
@property (nonatomic, retain) NSMutableArray *redCards;
@property (nonatomic, retain) NSMutableArray *blueCards;
@property (nonatomic, retain) NSMutableArray *timesByValues;
@property int openRed;
@property int openBlue;
@property int openRedValue;
@property int openBlueValue;
@property int tries;
@property int score;
@property BOOL needsTurningBack;
@property (nonatomic, retain) NSTimer *mainTimer;
@property (nonatomic, retain) IBOutlet UILabel *instructionLabel;
@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *congratsLabel;
@property (nonatomic, retain) IBOutlet UITextView *highScoresLabel;
@property (nonatomic, retain) IBOutlet UIView *playingSurface;
@property (nonatomic, retain) IBOutlet UIImageView *smileView;
@property (nonatomic, retain) IBOutlet UIView *bottomBar;


- (void) deal;
- (void) cardClicked:(id)sender;
- (void) card2Clicked:(id)sender;
- (void) randomizeArray:(NSMutableArray *) passedArray;
- (void) turnTwoBack;
- (void) removeTwo;
- (void) seeIfSame;
- (void) recordHighScore;
-(BOOL)isFourInchScreen;

@end

