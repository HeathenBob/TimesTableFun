//
//  FlipViewController.m
//  Flip
//
//  Created by Felix Elliott on 29/10/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import "FEPairsViewController.h"
#import "FEUtils.h"

@implementation FEPairsViewController

@synthesize redCards;
@synthesize blueCards;
@synthesize timesByValues;
@synthesize myDelegate;
@synthesize openRed;
@synthesize openBlue;
@synthesize openRedValue;
@synthesize openBlueValue;
@synthesize tries;
@synthesize score;
@synthesize mainTimer;
@synthesize instructionLabel;
@synthesize scoreLabel;
@synthesize congratsLabel;
@synthesize needsTurningBack;
@synthesize highScoresLabel;
@synthesize playingSurface;
@synthesize smileView;
@synthesize bottomBar;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.myDelegate = (TimesTableFunAppDelegate *) [[UIApplication sharedApplication] delegate];
		self.title = NSLocalizedStringWithDefaultValue(@"Activity Title: Pairs", @"Localizable", [NSBundle mainBundle], @"Pairs", @"Pairs"); 
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            cardWidth = 100;
            cardHeight = 140;
            gap = 20;
            leftOffset = 20;
            topOffset = 20;
        } else {
            cardWidth = 50;
            cardHeight = 70;
            gap = 5;
            leftOffset = 5;
            topOffset = 5;
        }
        
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
	NSURL* audioFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] 
											   pathForResource:@"drums" 
											   ofType:@"aiff"]]; 
	AudioServicesCreateSystemSoundID((CFURLRef)audioFile, &successSound); 
	[self.scoreLabel setBackgroundColor:[UIColor clearColor]];
	[super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    UINavigationBar *bar = self.navigationController.navigationBar;
    if (bar != nil) {
        if ([bar respondsToSelector:@selector(setBarTintColor:)]) {
            [bar setBarTintColor:[self.myDelegate.selectedTheme color2]];
            [bar setTintColor:[UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1.0]];
            bar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
            [bar setTranslucent:NO];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        } else {
            [bar setTintColor:[self.myDelegate.selectedTheme color2]];
        }
    }
    [self.bottomBar setBackgroundColor:[self.myDelegate.selectedTheme color2]];
    [self.instructionLabel setTextColor:[self.myDelegate.selectedTheme textColor]];
    [self.instructionLabel setHighlightedTextColor:[self.myDelegate.selectedTheme highlightTextColor]];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            //NSLog(@"portrait default");
            self.smileView.hidden = NO;
            self.instructionLabel.hidden = NO;
            self.bottomBar.hidden = NO;
        } else {
            //NSLog(@"Landscape left");
            self.smileView.hidden = YES;
            self.instructionLabel.hidden = YES;
            self.bottomBar.hidden = YES;
        }
    }
	[self deal];
	[super viewWillAppear:animated];
}

-(BOOL)isFourInchScreen {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
}

- (void) deal {
	[self.congratsLabel setText:@""];
    [self.view sendSubviewToBack:self.congratsLabel];
    [self.view sendSubviewToBack:self.highScoresLabel];
	for (UIView *subview in self.playingSurface.subviews)
    {
        //if (!subView.equals(self.instructionLabel) {
		if ([subview isMemberOfClass:[FECard class]] || [subview isMemberOfClass:[FECard2 class]]) {
			[subview removeFromSuperview];
		}
    }
	self.needsTurningBack = NO;
	self.tries = 0;
	self.score = 0;
	NSString *instructionText1 = NSLocalizedStringWithDefaultValue(@"Freya: tap one red one blue", @"Localizable", [NSBundle mainBundle], @"Tap one red card and one blue to find a pair", @"Tap one red card and one blue to find a pair"); 
	[self.instructionLabel setText:instructionText1];
    self.instructionLabel.highlighted = NO;
	self.redCards = [NSMutableArray arrayWithCapacity:10];
	self.blueCards = [NSMutableArray arrayWithCapacity:10];
	self.timesByValues = [NSMutableArray arrayWithCapacity:10];
	for (int i = 1; i <=10; i++) {
		[self.timesByValues insertObject:[NSNumber numberWithInt:i] atIndex:i-1];
	}
	[self randomizeArray:self.timesByValues];
	int hCount = 1;
	int vCount = 1;
    float extraGap  = 0.0;
    if ([self isFourInchScreen]) {
        extraGap = 65.0;
    }
	for (int i = 0; i < 10; i++) {
		FECard *card = [FECard buttonWithType:UIButtonTypeCustom];
        card.userInteractionEnabled = YES;
		card.frame = CGRectMake((leftOffset + (cardWidth + gap) * (hCount - 1)), (topOffset + (cardHeight + gap) * (vCount - 1)), cardWidth, cardHeight);
		[card setPos:i];
		[self.redCards addObject:card];
		[self.playingSurface addSubview:card];
		[card setIntValue:[[timesByValues objectAtIndex:i]intValue] andTimesBy:self.myDelegate.selectedNumber];
		
		[card addTarget:self action:@selector(cardClicked:) forControlEvents:UIControlEventTouchUpInside];
		hCount++;
		if (hCount > 5) {
			hCount = 1;
			vCount++;
		}
	}
	
	// now the blue ones
	[self randomizeArray:self.timesByValues];
	int hCount2 = 1;
	int vCount2 = 1;
	for (int i = 0; i < 10; i++) {
		FECard2 *card2 = [FECard2 buttonWithType:UIButtonTypeCustom];
        card2.userInteractionEnabled = YES;
		card2.frame = CGRectMake((leftOffset + (cardWidth + gap) * (hCount2 - 1)), (topOffset + extraGap +  (cardHeight + gap) * (vCount - 1 + vCount2 - 1)), cardWidth, cardHeight);
		[card2 setPos:i];
		[self.blueCards addObject:card2];
		[self.playingSurface addSubview:card2];
        [card2 addTarget:self action:@selector(card2Clicked:) forControlEvents:UIControlEventTouchUpInside];
		[card2 setIntValue:[[timesByValues objectAtIndex:i]intValue] * self.myDelegate.selectedNumber];
		
		hCount2++;
		if (hCount2 > 5) {
			hCount2 = 1;
			vCount2++;
		}
	}
	openRed = -1;
	openBlue = -1;
}

- (void)randomizeArray:(NSMutableArray *) passedArray {
	[passedArray exchangeObjectAtIndex:([passedArray count]/2) withObjectAtIndex:0];
	for(int i=0; i<20; i++) {
		[passedArray exchangeObjectAtIndex:arc4random()%[passedArray count] withObjectAtIndex:arc4random()%[passedArray count]];
	}
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void) cardClicked:(id) sender {
	if (openRed == -1) {
		@try {
			FECard *card = (FECard*) sender;
			if (card != nil) {
				if (card.faceUp == NO) {
					[card turnOver];
					self.openRed = card.pos;
					self.openRedValue = [card intValue] * self.myDelegate.selectedNumber;
					if (self.openBlue > -1) {
						[self seeIfSame];
					} else {
						NSString *instructionTextBlue = NSLocalizedStringWithDefaultValue(@"Freya: Now tap blue", @"Localizable", [NSBundle mainBundle], @"Now tap a blue card", @"Now tap a blue card"); 
						[self.instructionLabel setText:instructionTextBlue];
                        self.instructionLabel.highlighted = YES;
					}
					
				} else {
					//[self turnTwoBack];
				}
			}
		}
		@catch (NSException * e) {
			// if it's not a card don't do anythin
		}
	} else {
		@try {
			FECard *card = (FECard*) sender;
			if (card != nil) {
				if (card.faceUp == NO) {
				} else {
					//[self turnTwoBack];
				}
			}
		} @catch (NSException * e) {
			NSString *instructionText1 = NSLocalizedStringWithDefaultValue(@"Freya: tap one red one blue", @"Localizable", [NSBundle mainBundle], @"Tap one red card and one blue to find a pair", @"Tap one red card and one blue to find a pair"); 
			[self.instructionLabel setText:instructionText1];
            self.instructionLabel.highlighted = YES;
		}
	}
}

- (void) turnTwoBack {
	if (needsTurningBack) {
		[[self.blueCards objectAtIndex:self.openBlue] turnBack];
		[[self.redCards objectAtIndex:self.openRed] turnBack];
		self.openRed = -1;
		self.openRedValue = -1;
		self.openBlue = -1;
		self.openBlueValue = -1;
		NSString *instructionText1 = NSLocalizedStringWithDefaultValue(@"Freya: tap one red one blue", @"Localizable", [NSBundle mainBundle], @"Tap one red card and one blue to find a pair", @"Tap one red card and one blue to find a pair"); 
		[instructionLabel setText:instructionText1];
        self.instructionLabel.highlighted = NO;
		self.needsTurningBack = NO;
	}
	
}

- (void) removeTwo {
	[self.mainTimer invalidate];
	[[self.blueCards objectAtIndex:self.openBlue] removeFromSuperview];
	[[self.redCards objectAtIndex:self.openRed] removeFromSuperview];
	self.openRed = -1;
	self.openRedValue = -1;
	self.openBlue = -1;
	self.openBlueValue = -1;
	NSString *wellDone = NSLocalizedStringWithDefaultValue(@"Freya: Well done", @"Localizable", [NSBundle mainBundle], @"WELL DONE %@", @"WELL DONE %@"); 
	[instructionLabel setText:[NSString stringWithFormat:wellDone,self.myDelegate.userName]];
    self.instructionLabel.highlighted = NO;
}

- (void) seeIfSame {
	tries ++;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.scoreLabel setBackgroundColor:[UIColor clearColor]];
    } else {
        [self.scoreLabel setBackgroundColor:[self.myDelegate.selectedTheme color3]];
    }
	[self.scoreLabel setTextColor:[self.myDelegate.selectedTheme textColor]];
	if (self.openRedValue == self.openBlueValue) {
		//self.mainTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(removeTwo) userInfo:nil repeats:NO];
		//[self.mainTimer fire];
		[self performSelector:@selector(removeTwo) withObject:nil afterDelay:2.0f];
		score++;
	} else {
		//self.mainTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(turnTwoBack) userInfo:nil repeats:NO];
		//[self.mainTimer fire];
		NSString *hardLuck = NSLocalizedStringWithDefaultValue(@"Freya: Pairs hard luck", @"Localizable", [NSBundle mainBundle], @"Hard luck. Wait a few seconds to try again.", @"Hard luck. Wait a few seconds to try again."); 
		[instructionLabel setText:hardLuck];
        self.instructionLabel.highlighted = NO;
		self.needsTurningBack = YES;
		[self performSelector:@selector(turnTwoBack) withObject:nil afterDelay:4.0f];
	}
	NSString *scoreText = NSLocalizedStringWithDefaultValue(@"Label: Pairs score", @"Localizable", [NSBundle mainBundle], @"Tries:%i Score:%i", @"Tries:%i Score:%i"); 
	[self.scoreLabel setText:[NSString stringWithFormat:scoreText, tries, score]];
	if (score > 9) {
		NSString *pairsCongrats = NSLocalizedStringWithDefaultValue(@"Freya: Pairs congrats", @"Localizable", [NSBundle mainBundle], @"Congratulations you cleared the table in %i goes.", @"Congratulations you cleared the table in %i goes."); 
		
		[self.congratsLabel setText:[NSString stringWithFormat:pairsCongrats, tries]];
        [self.view bringSubviewToFront:self.congratsLabel];
		AudioServicesPlaySystemSound(successSound);
		[self recordHighScore];
	}
}

int memberSort2(id item1, id item2, void *context) {
	NSNumber *score1 = [item1 objectForKey:@"score"];
	NSNumber *score2 = [item2 objectForKey:@"score"];
	if ([score1 intValue] > [score2 intValue]) {
		return 1;
	} else if ([score1 intValue] < [score2 intValue]) {
		return -1;
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

- (void) recordHighScore {
	NSMutableDictionary *highScores = self.myDelegate.pairsHighScores;
	if (highScores == nil) {
		highScores = [NSMutableDictionary dictionaryWithCapacity:10];
	}
	//NSString *theScore = [NSString stringWithFormat:@"%i %@",self.score, self.myDelegate.userName];
	NSMutableDictionary *highScore = [NSMutableDictionary dictionaryWithCapacity:3];
	[highScore setObject:[NSNumber numberWithInteger:self.tries] forKey:@"score"];
	[highScore setObject:[NSDate date] forKey:@"date"];
	[highScore setObject:self.myDelegate.userName forKey:@"name"];
	NSString *key = [NSString stringWithFormat:@"%ikey",self.myDelegate.selectedNumber];
	NSMutableArray *scores = [NSMutableArray  arrayWithArray:(NSArray *) [highScores objectForKey:key]];
	if (scores == nil) {
		scores = [NSMutableArray arrayWithCapacity:100];
	}
	[scores addObject:highScore];
	
	[scores sortUsingFunction:memberSort2 context:nil];
	NSMutableString *scoreSummary = [[NSMutableString alloc] init];
	if ([scores count] > 1) {
		NSDateFormatter *format = [[NSDateFormatter alloc] init];
		[format setDateFormat:@"MMM dd yyyy"];
		NSString *highScoreTitle = NSLocalizedStringWithDefaultValue(@"High score: title", @"Localizable", [NSBundle mainBundle], @"HIGH SCORES:", @"HIGH SCORES:"); 
		[scoreSummary appendString:highScoreTitle];
		[scoreSummary appendString:@"\n"];
		NSString *cleared = NSLocalizedStringWithDefaultValue(@"High score: cleared", @"Localizable", [NSBundle mainBundle], @"%@ cleared in %i on %@",@"%@ cleared in %i on %@"); 
		
		for (int i =0; i < [scores count] && i < 9; i++) {
			//if ([[scores objectAtIndex:i] isMemberOfClass: [NSMutableDictionary class]] ) {
			NSMutableDictionary *hs = [scores objectAtIndex:i];
			if (hs != nil) {
				//[FEUtils debug:[NSString stringWithFormat:@"%@ scored %i on ",[hs objectForKey:@"name"], [[hs objectForKey:@"score"] intValue]]];
				[scoreSummary appendFormat:cleared,[hs objectForKey:@"name"], [[hs objectForKey:@"score"] intValue], [format stringFromDate:(NSDate*)[hs objectForKey:@"date"]]];
				[scoreSummary appendString:@"\n"];
			}
			//} else {
			//[scores removeObjectAtIndex:i];
			//}
		}
		[self.highScoresLabel setText:scoreSummary];
        [self.view bringSubviewToFront:self.highScoresLabel];
		[format release];
	}
	
	[scoreSummary release];
	[highScores setObject:scores forKey:key];
	self.myDelegate.gameHighScores = highScores;
	[FEUtils saveNSDictionaryToDocumentsFolder:highScores asFileName:@"PairsScores" withPrefix:nil];
}



- (void) card2Clicked:(id)sender {
	if (openBlue == -1) {
		@try {
			FECard2 *card = (FECard2*) sender;
			if (card != nil) {
				if (card.faceUp == NO) {
					[card turnOver];
					self.openBlue = card.pos;
					self.openBlueValue = [card intValue];
					if (self.openRed > -1) {
						
						[self seeIfSame];					
					} else {
						NSString *instructionTextRed = NSLocalizedStringWithDefaultValue(@"Freya: Now tap red", @"Localizable", [NSBundle mainBundle], @"Now tap a red card", @"Now tap a red card"); 
						[instructionLabel setText:instructionTextRed];
                        self.instructionLabel.highlighted = YES;
					}

				} else {
					//[self turnTwoBack];
				}
			}
		}
		@catch (NSException * e) {
			// if it's not a card don't do anythin
		}
	} else {
		@try {
			FECard2 *card = (FECard2*) sender;
			if (card != nil) {
				if (card.faceUp == NO) {
										
				} else {
					//[self turnTwoBack];
				}
			}
		}
		@catch (NSException * e) {
			// if it's not a card don't do anythin
		}
	}

}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	return NO;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
    
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            self.smileView.hidden = NO;
            self.instructionLabel.hidden = NO;
            self.bottomBar.hidden = NO;
        } else {
            self.smileView.hidden = YES;
            self.instructionLabel.hidden = YES;
            self.bottomBar.hidden = YES;
        }
    }
}


- (void)dealloc {
	[redCards release];
	[blueCards release];
	[timesByValues release];
	[mainTimer release];
	[instructionLabel release];
	[scoreLabel release];
	[congratsLabel release];
	[highScoresLabel release];
    [playingSurface release];
    [bottomBar release];
	
	AudioServicesDisposeSystemSoundID(successSound);
    [super dealloc];
}

@end
