//
//  FEGameViewController.m
//  TimesTableFun
//
//  Created by Felix Elliott on 20/09/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import "FEGameViewController.h"
#import "FEUtils.h"
#import "FEUtils.h"


@implementation FEGameViewController

@synthesize buttons;
@synthesize myDelegate;
@synthesize startButton;
@synthesize mainTimer;
@synthesize score;
@synthesize outof;
@synthesize wrong;
@synthesize scoreLabel;
@synthesize finishing;
@synthesize instructionLabel;
@synthesize highScoresLabel;
@synthesize freyaImage;
@synthesize topBar;
@synthesize bottomBar;
@synthesize gamePaused;
@synthesize stripeImage;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		self.myDelegate = (TimesTableFunAppDelegate *) [[UIApplication sharedApplication] delegate];
        self.buttons = [NSMutableArray arrayWithCapacity:60];
		NSString *titleString = NSLocalizedStringWithDefaultValue(@"Screen Title: Game", @"Localizable", [NSBundle mainBundle], @"Game", @"Game");  
		self.title = titleString;
    }
    return self;
}

- (void) viewDidLoad {
	NSURL* audioFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] 
											   pathForResource:@"correct" 
											   ofType:@"caf"]]; 
	AudioServicesCreateSystemSoundID((CFURLRef)audioFile, &successSound); 
	NSURL* audioFile2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] 
												pathForResource:@"wrong" 
												ofType:@"caf"]]; 
	AudioServicesCreateSystemSoundID((CFURLRef)audioFile2, &sorrySound); 
	NSURL* audioFile3 = [NSURL fileURLWithPath:[[NSBundle mainBundle] 
												pathForResource:@"oops3" 
												ofType:@"caf"]]; 
	AudioServicesCreateSystemSoundID((CFURLRef)audioFile3, &oopsSound); 
	[self.instructionLabel setTextColor:[self.myDelegate.selectedTheme textColor]];
	[self.instructionLabel setHighlightedTextColor:[self.myDelegate.selectedTheme highlightTextColor]];
	
	NSString *restart = NSLocalizedStringWithDefaultValue(@"Button: start", @"Localizable", [NSBundle mainBundle], @"start", @"start");  
	[self.startButton setTitle:restart forState:UIControlStateNormal];
	[self.startButton setTitle:restart forState:UIControlStateSelected];
	[self.startButton setTitle:restart forState:UIControlStateHighlighted];
	[self.startButton setTitle:restart forState:UIControlStateDisabled];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewWillAppear:(BOOL)animated {
    UINavigationBar *bar = self.navigationController.navigationBar;
    if (bar != nil) {
        if ([bar respondsToSelector:@selector(setBarTintColor:)]) {
            [bar setBarTintColor:[self.myDelegate.selectedTheme color3]];
            [bar setTintColor:[UIColor colorWithRed:40.0/255.0 green:40.0/255.0 blue:40.0/255.0 alpha:1.0]];
            bar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:UITextAttributeTextColor];
            [bar setTranslucent:NO];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        } else {
            [bar setTintColor:[self.myDelegate.selectedTheme color3]];
        }
    }
	//[self.topBar setBackgroundColor:[self.myDelegate.selectedTheme color3]];
    [self.topBar setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8]];
    [self.bottomBar setBackgroundColor:[self.myDelegate.selectedTheme color3]];
    [self.instructionLabel setTextColor:[self.myDelegate.selectedTheme textColor]];
	int selectedNum = self.myDelegate.selectedNumber;
	if (selectedNum < 1) {
		selectedNum = 1;
	}
	NSString *instruction = NSLocalizedStringWithDefaultValue(@"Freya: click multiples", @"Localizable", [NSBundle mainBundle], @"Click only on the numbers which are multiples of %i", @"Click only on the numbers which are multiples of %i");  
	[self.instructionLabel setText:[NSString stringWithFormat:instruction, selectedNum]];
	self.gamePaused = NO;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	self.gamePaused = YES;
	[self.mainTimer invalidate];
	[super viewWillDisappear:animated];
}

- (IBAction) startButtonClicked {
	[self.highScoresLabel setBackgroundColor:[UIColor clearColor]];
	[self.highScoresLabel setText:@""];
	increment = 3;
	self.finishing = 0;
	self.outof = 0;
	self.score = 0;
	self.wrong = 0;
	[self.instructionLabel setHighlighted:NO];
	NSString *scoreLabelText = NSLocalizedStringWithDefaultValue(@"Label: Score short", @"Localizable", [NSBundle mainBundle], @"Score: %i", @"Score: %i"); 
	[scoreLabel setText:[NSString stringWithFormat:scoreLabelText, self.score]];
	int selectedNum = self.myDelegate.selectedNumber;
	if (selectedNum < 1) {
		selectedNum = 1;
	}
    NSString *instruction = NSLocalizedStringWithDefaultValue(@"Freya: click multiples", @"Localizable", [NSBundle mainBundle], @"Click only on the numbers which are multiples of %i", @"Click only on the numbers which are multiples of %i");  
	[self.instructionLabel setText:[NSString stringWithFormat:instruction, selectedNum]];
	self.buttons = [NSMutableArray arrayWithCapacity:60];
	self.finishing = 0;
	int smallestGap = 4;
	if (selectedNum > 4) {
		smallestGap = 2;
	}
	int lastDivisible = 0;
	for (int i = 0; i < 60; i++) {
		
		int randomNum = selectedNum;
		if (lastDivisible <= smallestGap) {
			int highest = selectedNum * 10;
			randomNum = arc4random()%highest;
			randomNum++;
            if (randomNum <= selectedNum) {
                int timesBy = (arc4random()%8) + 2;
                randomNum = (randomNum * timesBy) + selectedNum;
            }
			if (randomNum % selectedNum == 0) {
				lastDivisible = 0;
			} else {
				lastDivisible ++;
			}
			
		} else {
			randomNum = randomNum * ((arc4random()%10) + 1);
            if (randomNum == selectedNum) {
                int timesBy = (arc4random()%9) + 2;
                randomNum = randomNum * timesBy;
            }
			lastDivisible = 0;
		}
		
		FENumberButton *button = [[FENumberButton alloc] init];
		[button setNumberValue:randomNum];
		[button setBackgroundImage:[self.myDelegate.selectedTheme getNormalButtonImage]  forState:UIControlStateNormal];
		[button setBackgroundImage:[self.myDelegate.selectedTheme getHighlightButtonImage]  forState:UIControlStateHighlighted];
		[button setBackgroundImage:[self.myDelegate.selectedTheme getSelectedButtonImage]  forState:UIControlStateSelected];
		[button setBackgroundImage:[self.myDelegate.selectedTheme getDisabledButtonImage]  forState:UIControlStateDisabled];
        [button setUserInteractionEnabled:YES];
        
		CGRect buttonRect = button.frame;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            buttonRect.origin.x = (arc4random()%668);
        } else {
            buttonRect.origin.x = (arc4random()%260);
        }
		buttonRect.origin.y = 0 - (i * 100);
		button.frame = buttonRect;
		[self.buttons addObject:button];
		[button release];
	}
	for (int i = 0; i < 60; i++) {
		FENumberButton *button = (FENumberButton *) [self.buttons objectAtIndex:i];
		[self.view addSubview:button];
		button.enabled = NO;
        [button addTarget:self 
                   action:@selector(numberButtonClicked:)
         forControlEvents:UIControlEventTouchDown];
		
	}
	   
    [self.view bringSubviewToFront:self.topBar];
    //[self.view bringSubviewToFront:self.startButton];
    //[self.view bringSubviewToFront:self.scoreLabel];
    [self.view bringSubviewToFront:self.bottomBar];
    [self.view bringSubviewToFront:self.freyaImage];
    [self.view bringSubviewToFront:self.instructionLabel];
    //[self.view bringSubviewToFront:self.freyaImage];
    //[self.view bringSubviewToFront:self.instructionLabel];
    [self.view bringSubviewToFront:self.stripeImage];
    
	
	self.mainTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveFrame) userInfo:nil repeats:YES];
	[mainTimer fire];
	
	self.startButton.enabled = NO;
}



- (void) moveFrame {
	if (!self.gamePaused) {
		
		int lastOne = -1;
		for (int i = 0; i < 60; i++) {
			FENumberButton *button = [self.buttons objectAtIndex:i];
			
			CGRect rect = button.frame;
			rect.origin.y += increment;
			button.frame = rect;
			if (rect.origin.y > 0 && rect.origin.y <= (0 + increment) && ![button isEnabled]) {
				button.enabled = YES;
				int number = button.numberValue;
				int divider = self.myDelegate.selectedNumber;
				if (divider == 0) {
					divider = 1;
				}
				int remainder = number % divider;
				if (remainder == 0) {
					self.outof++;
				}
				if (lastOne == -1 && self.outof >= 10 && self.finishing == 0) {
					lastOne = i;
					//NSLog(@"lastOne = %i", lastOne);
				}
			}
			if (rect.origin.y > self.bottomBar.frame.origin.y) {
				int number = button.numberValue;
				int divider = self.myDelegate.selectedNumber;
				if (divider == 0) {
					divider = 1;
				}
				int remainder = number % divider;
				if (remainder == 0 && button.done == NO) {
					[self playOopsSound];
					button.highlighted = YES;
                    button.done = YES;
				}
				button.enabled = NO;
				[button removeFromSuperview];
				NSString *scoreLabelText = NSLocalizedStringWithDefaultValue(@"Label: Score short", @"Localizable", [NSBundle mainBundle], @"Score: %i", @"Score: %i"); 
				NSString *scoreLabelTextOutOf = NSLocalizedStringWithDefaultValue(@"Label: Score out of", @"Localizable", [NSBundle mainBundle], @"Score: %i out of %i", @"Score: %i out of %i"); 
				
				if (self.finishing > 0 && i == finishing + 1) {
                    

					[mainTimer invalidate];
					NSString *restart = NSLocalizedStringWithDefaultValue(@"Button: restart", @"Localizable", [NSBundle mainBundle], @"restart", @"restart");  
					[self.startButton setTitle:restart forState:UIControlStateNormal];
					[self.startButton setTitle:restart forState:UIControlStateSelected];
					[self.startButton setTitle:restart forState:UIControlStateHighlighted];
					self.startButton.enabled = YES;
					[scoreLabel setText:[NSString stringWithFormat:scoreLabelTextOutOf, self.score, self.outof]];
					int numWrong = self.outof - self.score;
					
					NSString *excellent = NSLocalizedStringWithDefaultValue(@"Freya: Excellent", @"Localizable", [NSBundle mainBundle], @"EXCELLENT %@", @"EXCELLENT %@");  
					NSString *wellDone = NSLocalizedStringWithDefaultValue(@"Freya: Well done", @"Localizable", [NSBundle mainBundle], @"WELL DONE %@", @"WELL DONE %@"); 
					NSString *notBad = NSLocalizedStringWithDefaultValue(@"Freya: Not bad", @"Localizable", [NSBundle mainBundle], @"NOT BAD. Press restart to try again  %@.", @"NOT BAD. Press restart to try again  %@."); 
					NSString *rubbish = NSLocalizedStringWithDefaultValue(@"Freya: Rubbish", @"Localizable", [NSBundle mainBundle], @"I think you need a little more practice %@.", @"I think you need a little more practice %@."); 
					
					if (numWrong < 2) {
						[self.instructionLabel setText:[[NSString stringWithFormat:excellent, self.myDelegate.userName] uppercaseString]];
					} else if (numWrong < 4) {
						[self.instructionLabel setText:[[NSString stringWithFormat:wellDone, self.myDelegate.userName] uppercaseString]];
					} else if (numWrong < 6) {
						[self.instructionLabel setText:[NSString stringWithFormat:notBad, self.myDelegate.userName]];
					} else {
						[self.instructionLabel setText:[NSString stringWithFormat:rubbish, self.myDelegate.userName]];

					}
					[self.instructionLabel setHighlighted:YES];
                    NSTimer *timer3 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(recordHighScore:) userInfo:nil repeats:NO];
					//[self recordHighScore];

				} else {
					[scoreLabel setText:[NSString stringWithFormat:scoreLabelText, self.score]];
				}

				
			}
			
		}
		
		if (self.finishing == 0 && lastOne > -1) {
			for (int i = (lastOne + 1); i < 60; i++) {
				FENumberButton *button = [self.buttons objectAtIndex:i];
				if (button.frame.origin.y < (button.frame.size.height * -1)) {
					button.enabled = YES;
					[button removeFromSuperview];
				}
			}
			self.finishing = lastOne;
		}
	}
}

int memberSort(id item1, id item2, void *context)
{
	NSNumber *score1 = [item1 objectForKey:@"score"];
	NSNumber *score2 = [item2 objectForKey:@"score"];
	if ([score1 intValue] > [score2 intValue]) {
		return -1;
	} else if ([score1 intValue] < [score2 intValue]) {
		return 1;
	} else {
		@try {
			NSDate *date1 = [item1 objectForKey:@"date"];
			NSDate *date2 = [item1 objectForKey:@"date"];
			if ([date1 compare:date2] == NSOrderedDescending) {
				return -1;
			} else {
				return 1;
			}
		}
		@catch (NSException * e) {
			return 0;
		}
		
	}
	return 0;
}

- (void) recordHighScore:(NSTimer *)timer {
    [timer invalidate];
	NSString *highScoreText = NSLocalizedStringWithDefaultValue(@"High score: scored score on", @"Localizable", [NSBundle mainBundle], @"%1$@ scored %2$i on %3$@", @"%1$@ scored %2$i on %3$@"); 
	NSString *highScoreTitle = NSLocalizedStringWithDefaultValue(@"High score: title", @"Localizable", [NSBundle mainBundle], @"HIGH SCORES:", @"HIGH SCORES:"); 
	
	NSMutableDictionary *highScores = self.myDelegate.gameHighScores;
	if (highScores == nil) {
		highScores = [NSMutableDictionary dictionaryWithCapacity:10];
	}
	//NSString *theScore = [NSString stringWithFormat:@"%i %@",self.score, self.myDelegate.userName];
	NSMutableDictionary *highScore = [NSMutableDictionary dictionaryWithCapacity:3];
	[highScore setObject:[NSNumber numberWithInteger:self.score] forKey:@"score"];
	[highScore setObject:[NSDate date] forKey:@"date"];
	[highScore setObject:self.myDelegate.userName forKey:@"name"];
	NSString *key = [NSString stringWithFormat:@"%ikey",self.myDelegate.selectedNumber];
	NSMutableArray *scores = [NSMutableArray  arrayWithArray:(NSArray *) [highScores objectForKey:key]];
	if (scores == nil) {
		scores = [NSMutableArray arrayWithCapacity:100];
	}
	[scores addObject:highScore];
	
	[scores sortUsingFunction:memberSort context:nil];
	NSMutableString *scoreSummary = [[NSMutableString alloc] init];
	if ([scores count] > 1) {
		NSDateFormatter *format = [[NSDateFormatter alloc] init];
		[format setDateFormat:@"MMM dd yyyy"];
		[scoreSummary appendString:highScoreTitle];
		[scoreSummary appendString:@"\n"];
		for (int i =0; i < [scores count] && i < 9; i++) {
			//if ([[scores objectAtIndex:i] isMemberOfClass: [NSMutableDictionary class]] ) {
			NSMutableDictionary *hs = [scores objectAtIndex:i];
			if (hs != nil && [hs objectForKey:@"name"] != nil &&  [hs objectForKey:@"score"] != nil &&  [hs objectForKey:@"score"] != nil) {
				[scoreSummary appendFormat:highScoreText,[hs objectForKey:@"name"], [[hs objectForKey:@"score"] intValue], [format stringFromDate:(NSDate*)[hs objectForKey:@"date"]]];
				[scoreSummary appendString:@"\n"];
			}
			//} else {
			//[scores removeObjectAtIndex:i];
			//}
		}
		[self.highScoresLabel setText:scoreSummary];
		[self.highScoresLabel setBackgroundColor:[self.myDelegate.selectedTheme color3]];
		[format release];
	}
	
	[scoreSummary release];
	[highScores setObject:scores forKey:key];
	self.myDelegate.gameHighScores = highScores;
	[FEUtils saveNSDictionaryToDocumentsFolder:highScores asFileName:@"GameScores" withPrefix:nil];
}
/*
- (NSComparisonResult) compareScores:(NSString *) score {
	double lhs, rhs;
	
	lhs = [self distance];
	rhs = [iRHS distance];
	
	if ( lhs < rhs ) return NSOrderedAscending;
	if ( lhs > rhs ) return NSOrderedDescending;
	
	return NSOrderedSame;
}
*/

-(void)numberButtonClicked:(id)sender {
    for (int i = 0; i < [self.buttons count]; i++) {
		FENumberButton *button = [self.buttons objectAtIndex:i];
		if ([button isEqual:sender]) {
			if (button.done == NO) {
				
				button.selected = YES;
				int number = button.numberValue;
				int divider = self.myDelegate.selectedNumber;
				if (divider == 0) {
					divider = 1;
				}
				int remainder = number % divider;
				if (remainder == 0) {
					button.highlighted = YES;
					self.score++;
					if (self.score % 4 == 0) {
						increment++;
					}
					[self playSuccessSound];
					button.done = YES;
					NSString *scoreLabelText = NSLocalizedStringWithDefaultValue(@"Label: Score short", @"Localizable", [NSBundle mainBundle], @"Score: %i", @"Score: %i"); 
					[scoreLabel setText:[NSString stringWithFormat:scoreLabelText, self.score]];
				} else {
					button.enabled = NO;
					[self playSorrySound];
					self.wrong++;
					if (self.wrong >= 2) {
						if (self.score > 0) {
							self.score--;
							self.wrong = 0;
						}
					}
					//increment++;
				}
			}
			break;
		}
    }

}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    currentTouch = [touch locationInView:self.view];
	for (int i = 0; i < [self.buttons count]; i++) {
		FENumberButton *button = [self.buttons objectAtIndex:i];
		if (currentTouch.x > button.frame.origin.x && currentTouch.x < (button.frame.origin.x + button.frame.size.width) && currentTouch.y > button.frame.origin.y && currentTouch.y < (button.frame.origin.y + button.frame.size.height)) {
			if (button.done == NO) {
				
				button.selected = YES;
				int number = button.numberValue;
				int divider = self.myDelegate.selectedNumber;
				if (divider == 0) {
					divider = 1;
				}
				int remainder = number % divider;
				if (remainder == 0) {
					button.highlighted = YES;
					self.score++;
					if (self.score % 4 == 0) {
						increment++;
					}
					[self playSuccessSound];
					button.done = YES;
					NSString *scoreLabelText = NSLocalizedStringWithDefaultValue(@"Label: Score short", @"Localizable", [NSBundle mainBundle], @"Score: %i", @"Score: %i"); 
					[scoreLabel setText:[NSString stringWithFormat:scoreLabelText, self.score]];
				} else {
					button.enabled = NO;
					[self playSorrySound];
					self.wrong++;
					if (self.wrong >= 2) {
						if (self.score > 0) {
							self.score--;
							self.wrong = 0;
						}
					}
					//increment++;
				}
			}
			break;
		}
	}
	
}
 */

static BOOL soundPlaying;

- (void) playSuccessSound {
	if (!soundPlaying) {
		soundPlaying = YES;
		AudioServicesAddSystemSoundCompletion (successSound,NULL,NULL,
											   completionCallback,
											   (void*) self);
		AudioServicesPlaySystemSound(successSound);
	}
	
}

- (void) playSorrySound {
	if (!soundPlaying) {
		soundPlaying = YES;
		AudioServicesAddSystemSoundCompletion (sorrySound,NULL,NULL,
											   completionCallback,
											   (void*) self);
		AudioServicesPlaySystemSound(sorrySound);
	}
	
}

- (void) playOopsSound {
	if (!soundPlaying) {
		soundPlaying = YES;
		AudioServicesAddSystemSoundCompletion (oopsSound,NULL,NULL,
											   completionCallback,
											   (void*) self);
		AudioServicesPlaySystemSound(oopsSound);
	}
}

static void completionCallback (SystemSoundID  mySSID, void* myself) {
	soundPlaying = NO;
	AudioServicesRemoveSystemSoundCompletion (mySSID);
}




- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	return NO;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationPortrait || [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
        
    }
    
    return NO;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[buttons release];
	[myDelegate release];
	[startButton release];
	[mainTimer release];
	[scoreLabel release];
	[instructionLabel release];
	[highScoresLabel release];
	[freyaImage release];
	[topBar release];
    [bottomBar release];
    [stripeImage release];
	AudioServicesDisposeSystemSoundID(successSound);
	AudioServicesDisposeSystemSoundID(sorrySound);
	AudioServicesDisposeSystemSoundID(oopsSound);
    [super dealloc];
}


@end
