//
//  FELearnViewController.h
//  TimesTableFun
//
//  Created by Felix Elliott on 09/06/2012.
//  Copyright (c) 2012 Heathen Bob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h> 
#import "TimesTableFunAppDelegate.h"

@interface FELearnViewController : UIViewController  {
    TimesTableFunAppDelegate *myDelegate;
    IBOutlet UILabel *instructionLabel;
    IBOutlet UIButton *countdownButton;
    IBOutlet UIButton *nextButton;
    IBOutlet UIView *layoutPanel;
    IBOutlet UIView *topBar;
    IBOutlet UIView *bottomBar;
    IBOutlet UIImageView *freyaImage;
    NSMutableArray *labels;
    int level;
    int buttonNumber;
    NSTimer *buttonTimer;
    SystemSoundID successSound;
	SystemSoundID sorrySound;
    int score;
    BOOL beingPressed;
    float animationDuration;
}

@property (nonatomic, retain) TimesTableFunAppDelegate *myDelegate;
@property (nonatomic, retain) IBOutlet UILabel *instructionLabel;
@property (nonatomic, retain) IBOutlet UIButton *countdownButton;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) IBOutlet UIView *layoutPanel;
@property (nonatomic, retain) IBOutlet UIView *topBar;
@property (nonatomic, retain) IBOutlet UIView *bottomBar;
@property (nonatomic, retain) NSTimer *buttonTimer;
@property (nonatomic, retain) UIImageView *freyaImage;

- (IBAction) countDownButtonClicked:(id)sender;
- (IBAction) nextButtonClicked:(id)sender;
- (void) decrementButton;
- (void) playSuccessSound;
- (void) playSorrySound;
- (void) clearBoard;
- (void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context;


@end
