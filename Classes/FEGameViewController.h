//
//  FEGameViewController.h
//  TimesTableFun
//
//  Created by Felix Elliott on 20/09/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "FENumberButton.h"
#import "TimesTableFunAppDelegate.h"


@interface FEGameViewController : UIViewController <UITextViewDelegate> {
	TimesTableFunAppDelegate *myDelegate;
	NSMutableArray *buttons;
	IBOutlet UIButton *startButton;
	NSTimer *mainTimer;
	NSInteger score;
	NSInteger outof;
	NSInteger wrong;
	NSInteger increment;
	IBOutlet UILabel *scoreLabel;
	CGPoint currentTouch;
	SystemSoundID successSound;
	SystemSoundID sorrySound;
	SystemSoundID oopsSound;
	NSInteger finishing;
	IBOutlet UILabel *instructionLabel;
	IBOutlet UITextView *highScoresLabel;
	IBOutlet UIImageView *freyaImage;
    IBOutlet UIImageView *stripeImage;
	IBOutlet UIView *topBar;
    IBOutlet UIView *bottomBar;
	BOOL gamePaused;
}

@property (nonatomic, retain) TimesTableFunAppDelegate *myDelegate;
@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) UIButton *startButton;
@property (nonatomic, retain) NSTimer *mainTimer;
@property NSInteger score;
@property NSInteger outof;
@property NSInteger wrong;
@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property NSInteger finishing;
@property (nonatomic, retain) IBOutlet UILabel *instructionLabel;
@property (nonatomic, retain) IBOutlet UITextView *highScoresLabel;
@property (nonatomic, retain) IBOutlet UIImageView *freyaImage;
@property (nonatomic, retain) IBOutlet UIImageView *stripeImage;
@property (nonatomic, retain) IBOutlet UIView *topBar;
@property (nonatomic, retain) IBOutlet UIView *bottomBar;
@property BOOL gamePaused;

- (IBAction) startButtonClicked;

- (void) playSuccessSound;
- (void) playSorrySound;
- (void) playOopsSound;
- (void) recordHighScore:(NSTimer *)timer;
- (void) numberButtonClicked:(id)sender;


static void completionCallback (SystemSoundID  mySSID, void* myself);

@end
