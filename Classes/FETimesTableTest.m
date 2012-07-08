//
//  FETimesTableTest.m
//  TimesTableFun
//
//  Created by Felix Elliott on 30/08/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import "FETimesTableTest.h"
#import "FEUtils.h"


@implementation FETimesTableTest
@synthesize numberButtons;
@synthesize timesByValues;
@synthesize whichTable;
@synthesize answerSlot;
@synthesize answerSlotBackground;
@synthesize firstLabel;
@synthesize timesLabel;
@synthesize secondLabel;
@synthesize equalsLabel;
@synthesize instructionLabel;
@synthesize highScoresLabel;
@synthesize scoreLabel;
@synthesize correctButton;
@synthesize myDelegate;
@synthesize score;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.myDelegate = (TimesTableFunAppDelegate *) [[UIApplication sharedApplication] delegate];
		NSString *testTitle = NSLocalizedStringWithDefaultValue(@"Activity Title: Test", @"Localizable", [NSBundle mainBundle], @"Test", @"Test");  
		self.title = testTitle;
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
	CGRect rect = self.correctButton.frame;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        rect.origin.x = 1030;
    } else {
        rect.origin.x = 330;
    }
	//rect.origin.y = 240;
	self.correctButton.frame =rect;
	self.score = 0;
	[self.instructionLabel setTextColor:[self.myDelegate.selectedTheme textColor]];
	[self.instructionLabel setHighlightedTextColor:[self.myDelegate.selectedTheme color1]];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	NSURL* audioFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] 
											   pathForResource:@"correct" 
											   ofType:@"caf"]]; 
	AudioServicesCreateSystemSoundID((CFURLRef)audioFile, &successSound); 
	NSURL* audioFile2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] 
												pathForResource:@"wrong" 
												ofType:@"caf"]]; 
	AudioServicesCreateSystemSoundID((CFURLRef)audioFile2, &sorrySound); 
	self.whichTable = self.myDelegate.selectedNumber;
	timesByIndex = 0;
	self.timesByValues = [NSMutableArray arrayWithCapacity:10];
	for (int i = 1; i <=10; i++) {
		[self.timesByValues insertObject:[NSNumber numberWithInt:i] atIndex:i-1];
	}
	[self randomizeArray:self.timesByValues];
	timesBy = [[self.timesByValues objectAtIndex:timesByIndex] intValue];
	self.numberButtons = [NSMutableArray arrayWithCapacity:10];
	NSMutableArray *random10 = [self generateRandomAnswersArrayOfSize:10  forAnswer:(self.whichTable * timesBy)];
    
    float yO = 100.0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        yO = self.firstLabel.frame.origin.y + (2 * (self.firstLabel.frame.size.height));
    } else {
        yO = self.firstLabel.frame.origin.y + (self.firstLabel.frame.size.height) + 20.0;
    }
    
    float xO = 20.0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        xO = self.firstLabel.frame.origin.x;
    }
    
	for (int i = 0; i < 10; i++) {
		FENumberButton *numberButton = [[FENumberButton alloc] initWithNumber:[[random10 objectAtIndex:i] intValue] andPosition:i andYOffset:yO andXOffset:xO andTheme:self.myDelegate.selectedTheme andParent:self];
		
		[numberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		
		[self.numberButtons addObject:numberButton];
		[numberButton release];
		[self.view addSubview:[self.numberButtons objectAtIndex:i]];
	}
	[self.firstLabel setTextColor:[self.myDelegate.selectedTheme color1]];
	[self.timesLabel setTextColor:[self.myDelegate.selectedTheme color1]];
	[self.secondLabel setTextColor:[self.myDelegate.selectedTheme color1]];
	[self.equalsLabel setTextColor:[self.myDelegate.selectedTheme color1]];
	[self.answerSlot setTextColor:[self.myDelegate.selectedTheme color1]];
	
	[self start];
    [super viewDidLoad];
}

- (NSMutableArray *) generateRandomAnswersArrayOfSize:(NSInteger)arraySize forAnswer:(NSInteger)answer {
	NSMutableArray *randomArray = [NSMutableArray arrayWithCapacity:arraySize];
	int i = 0;
	while (i < arraySize) {
		// need to make sure we always generate enough to fill the array
		int modulusNum = (arraySize)/2;
		
		while (modulusNum <= ((answer -1) + (arraySize - answer))) {
			modulusNum++;
		}
		int random = arc4random() % modulusNum;
		int fiftyfifty = arc4random() % 2;
		NSNumber *myInt;
		if (i == 0) {
			myInt = [NSNumber numberWithInt:answer];
		} else if (fiftyfifty == 1 && answer > random) {
			myInt = [NSNumber numberWithInt:(answer - random)];
		} else {
			myInt = [NSNumber numberWithInt:(answer + random)];
		}
		if ([myInt intValue] > 0 && ![randomArray containsObject:myInt]) {
			[randomArray insertObject:myInt atIndex:i];
			//NSLog(@"OK");
			i++;
		} else {
			//NSLog(@"no good");
		}
		
		
	}
	[self randomizeArray:randomArray];
	return randomArray;
}

- (void) start {
	[self.highScoresLabel setBackgroundColor:[UIColor clearColor]];
	[self.highScoresLabel setText:@""];
	NSString *dragText = NSLocalizedStringWithDefaultValue(@"Freya: drag", @"Localizable", [NSBundle mainBundle], @"Drag the correct answer on to the square", @"Drag the correct answer on to the square"); 
	
	[instructionLabel setText:dragText];
	[self.instructionLabel setHighlighted:NO];
	[self.firstLabel setText:[NSString stringWithFormat:@"%i", whichTable]];
	NSMutableArray *nextRandom10 = [self generateRandomAnswersArrayOfSize:10 forAnswer:(self.whichTable * timesBy)];
	for (int i = 0; i < 10; i++) {
		@try {
		[[self.numberButtons objectAtIndex:i] setEnabled:YES];
		[[self.numberButtons objectAtIndex:i] setHighlighted:NO];
		[[self.numberButtons objectAtIndex:i] setSelected:NO];
		[[self.numberButtons objectAtIndex:i] setNumberValue:[[nextRandom10 objectAtIndex:i] intValue]];
		[[self.numberButtons objectAtIndex:i] returnToOriginalPosition];
		} @catch (NSException *e) {
			[FEUtils debug :[NSString stringWithFormat:@"on loop ",i] withException: e];
		}
	}
	[self.secondLabel setText:[NSString stringWithFormat:@"%i", timesBy]];
	CGRect rect = self.correctButton.frame;
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        rect.origin.x = 1030;
    } else {
        rect.origin.x = 330;
    }
	//rect.origin.y = 240;
	self.correctButton.frame =rect;
	
}

- (void) clearNumberButtons {
	for (int i = 0; i < 10; i++) {
		@try {
			[[self.numberButtons objectAtIndex:i] removeFromSuperview];
			
		} @catch (NSException *e) {
			[FEUtils debug :[NSString stringWithFormat:@"on loop ",i] withException: e];
		}
	}
	[self.firstLabel removeFromSuperview];
	[self.secondLabel removeFromSuperview];
	[self.timesLabel removeFromSuperview];
	[self.equalsLabel removeFromSuperview];
	[self.answerSlot removeFromSuperview];
	[self.answerSlotBackground removeFromSuperview];
}

- (void)randomizeArray:(NSMutableArray *) passedArray {
	[passedArray exchangeObjectAtIndex:([passedArray count]/2) withObjectAtIndex:0];
	for(int i=0; i<20; i++) {
		[passedArray exchangeObjectAtIndex:arc4random()%[passedArray count] withObjectAtIndex:arc4random()%[passedArray count]];
	}
}

- (IBAction) nextButtonClicked {
	if (timesByIndex < [self.timesByValues count]-1) {
		timesByIndex++;
	}
	timesBy = [[self.timesByValues objectAtIndex:timesByIndex] intValue];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:1];
	CGRect rect = self.correctButton.frame;
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        rect.origin.x = 1030;
    } else {
        rect.origin.x = 330;
    }
	//rect.origin.y = 240;
	self.correctButton.frame =rect;
	[UIView commitAnimations];
	[self start];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    currentTouch = [touch locationInView:self.view];
	for (int i = 0; i < [numberButtons count]; i++) {
		FENumberButton *button = [numberButtons objectAtIndex:i];
		if (currentTouch.x > button.frame.origin.x && currentTouch.x < (button.frame.origin.x + button.frame.size.width) && currentTouch.y > button.frame.origin.y && currentTouch.y < (button.frame.origin.y + button.frame.size.height)) {
			touchedButton = button;
			NSString *dragText = NSLocalizedStringWithDefaultValue(@"Freya: drag", @"Localizable", [NSBundle mainBundle], @"Drag the correct answer on to the square", @"Drag the correct answer on to the square"); 
			[instructionLabel setText:dragText];
			touchedButton.selected = YES;
			touchOffsetX = currentTouch.x - button.frame.origin.x;
			touchOffsetY = currentTouch.y - button.frame.origin.y;
			break;
		}
	}
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    currentTouch = [touch locationInView:self.view];
    if (touchedButton != nil) {
		touchedButton.selected = YES;
		CGRect rect = touchedButton.frame;
		rect.origin.x = currentTouch.x - touchOffsetX;
		rect.origin.y = currentTouch.y - touchOffsetY;
		touchedButton.frame = rect;
	}
	//[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveButton) userInfo:nil repeats:NO];
	
}

- (void) moveButton {
    if (touchedButton != nil) {
		touchedButton.selected = YES;
		CGRect rect = touchedButton.frame;
		rect.origin.x = currentTouch.x - touchOffsetX;
		rect.origin.y = currentTouch.y - touchOffsetY;
		touchedButton.frame = rect;
	}
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    currentTouch = [touch locationInView:self.view];
	if (touchedButton != nil) {
		CGRect rect = touchedButton.frame;
		rect.origin.x = currentTouch.x - touchOffsetX;
		rect.origin.y = currentTouch.y - touchOffsetY;
		CGRect answerRect = self.answerSlot.frame;
		int centerX = rect.origin.x + (rect.size.width/2);
		int centerY = rect.origin.y + (rect.size.height/2);
		if (centerX >= answerRect.origin.x 
			&& centerX <= (answerRect.origin.x + answerRect.size.width) 
			&& centerY >= answerRect.origin.y 
			&& centerY <= (answerRect.origin.y + answerRect.size.height)) {
			rect.origin.x = answerRect.origin.x;
			rect.origin.y = answerRect.origin.y;
			rect.size.width = answerRect.size.width;
			rect.size.height = answerRect.size.height;
			touchedButton.frame = rect;
			if (touchedButton.numberValue == (whichTable * timesBy) ) {
				touchedButton.highlighted = YES;
				[self playSuccessSound];
				self.score++;
				if (timesByIndex < [self.timesByValues count]-1) {
					self.correctButton.hidden = NO;
					CGRect rect = self.correctButton.frame;
					rect.origin.x = -200;
					//rect.origin.y = 240;
					self.correctButton.frame =rect;
                    [self.view bringSubviewToFront:self.correctButton];
					[UIView beginAnimations:nil context:nil];
					[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
					[UIView setAnimationDuration:2];
					rect.origin.x = self.answerSlot.frame.origin.x;
					//rect.origin.y = 240;
					
					[instructionLabel setText:NSLocalizedStringWithDefaultValue(@"Freya: correct", @"Localizable", [NSBundle mainBundle], @"CORRECT - press next for another sum", @"CORRECT - press next for another sum") ];
					[self.instructionLabel setHighlighted:YES];
                    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
                    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
                        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                            for (int i = 0; i < 10; i++) {
                                if([[self.numberButtons objectAtIndex:i] numberValue] != [touchedButton numberValue]) {
                                    [[self.numberButtons objectAtIndex:i] setHidden:YES];
                                }
                            }
                        }
                    }
                    self.correctButton.frame =rect;
					[UIView commitAnimations];
				} else {
					if (score > 9) {
						NSString *excellent = NSLocalizedStringWithDefaultValue(@"Freya: Excellent score", @"Localizable", [NSBundle mainBundle], @"EXCELLENT %@, you scored %i", @"EXCELLENT %@, you scored %i");  
						[self.instructionLabel setText:[[NSString stringWithFormat:excellent, self.myDelegate.userName, score] uppercaseString]];
					} else if (score > 7) {
						NSString *wellDone = NSLocalizedStringWithDefaultValue(@"Freya: Well done score", @"Localizable", [NSBundle mainBundle], @"WELL DONE %@, you scored %i", @"WELL DONE %@, you scored %i");  
						[self.instructionLabel setText:[[NSString stringWithFormat:wellDone, self.myDelegate.userName, score] uppercaseString]];
					} else if (score > 5) {
						NSString *notBad = NSLocalizedStringWithDefaultValue(@"Freya: Not bad score", @"Localizable", [NSBundle mainBundle], @"NOT BAD %@, you scored %i", @"NOT BAD %@, you scored %i");  
						[self.instructionLabel setText:[NSString stringWithFormat:notBad, self.myDelegate.userName, score]];
					} else {
						NSString *rubbish = NSLocalizedStringWithDefaultValue(@"Freya: Rubbish score", @"Localizable", [NSBundle mainBundle], @"You scored %i. I think you need more practice %@.", @"You scored %i. I think you need more practice %@.");  
						[self.instructionLabel setText:[NSString stringWithFormat:rubbish, score, self.myDelegate.userName]];
						
					}
					[self.instructionLabel setHighlighted:YES];
					[self recordHighScore];
					
				}

				
			} else {
				[UIView beginAnimations:nil context:nil];
				[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
				[UIView setAnimationDuration:1];
				NSString *wrongText = NSLocalizedStringWithDefaultValue(@"Freya: wrong try again", @"Localizable", [NSBundle mainBundle], @"SORRY - Wrong answer, try again", @"SORRY - Wrong answer, try again"); 
				[instructionLabel setText:wrongText];
				[self.instructionLabel setHighlighted:YES];
				touchedButton.enabled = NO;
				[self playSorrySound];
				[touchedButton returnToOriginalPosition];
				[UIView commitAnimations];
				if (self.score > 0) {
					self.score --;
				}
			}
			
		} else {
			[touchedButton returnToOriginalPosition];
		}
		
	}
	NSString *scoreText = NSLocalizedStringWithDefaultValue(@"Label: score with score", @"Localizable", [NSBundle mainBundle], @"score:  %i", @"score:  %i"); 
	[self.scoreLabel setText:[NSString stringWithFormat:scoreText,self.score]];
	touchedButton = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
   // NSLog(@"Touches CANCELLED");
}

int memberSort3(id item1, id item2, void *context)
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

- (void) recordHighScore {
	NSMutableDictionary *highScores = self.myDelegate.testHighScores;
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
	
	[scores sortUsingFunction:memberSort3 context:nil];
	NSMutableString *scoreSummary = [[NSMutableString alloc] init];
	
	if ([scores count] > 1) {
		NSDateFormatter *format = [[NSDateFormatter alloc] init];
		[format setDateFormat:@"MMM dd yyyy"];
		NSString *highScoreTitle = NSLocalizedStringWithDefaultValue(@"High score: title", @"Localizable", [NSBundle mainBundle], @"HIGH SCORES:", @"HIGH SCORES:"); 
		NSString *scoredIOn = NSLocalizedStringWithDefaultValue(@"High score: scored score on", @"Localizable", [NSBundle mainBundle], @"%@ scored %i on %@", @"%@ scored %i on %@"); 
		
		
		[scoreSummary appendString:highScoreTitle];
		[scoreSummary appendString:@"\n"];
		for (int i =0; i < [scores count] && i < 9; i++) {
			//if ([[scores objectAtIndex:i] isMemberOfClass: [NSMutableDictionary class]] ) {
			NSMutableDictionary *hs = [scores objectAtIndex:i];
			if (hs != nil) {
				//[FEUtils debug:[NSString stringWithFormat:@"%@ scored %i on ",[hs objectForKey:@"name"], [[hs objectForKey:@"score"] intValue]]];
				[scoreSummary appendFormat:scoredIOn,[hs objectForKey:@"name"], [[hs objectForKey:@"score"] intValue], [format stringFromDate:(NSDate*)[hs objectForKey:@"date"]]];
				[scoreSummary appendString:@"\n"];
			}
			//} else {
			//[scores removeObjectAtIndex:i];
			//}
		}
		[format release];
	} else {
		NSString *youScored = NSLocalizedStringWithDefaultValue(@"Score: You scored", @"Localizable", [NSBundle mainBundle], @"You scored %i\n", @"You scored %i\n"); 
		NSString *remember = NSLocalizedStringWithDefaultValue(@"Title: REMEMBER", @"Localizable", [NSBundle mainBundle], @"REMEMBER", @"REMEMBER"); 
		
		[scoreSummary appendFormat:youScored, self.score];
		[scoreSummary appendString:remember];
		[scoreSummary appendString:@"\n"];
		for (int i = 1; i < 11; i++) {
			[scoreSummary appendFormat:@"%i x %i = %i\n", i, self.myDelegate.selectedNumber, (i * self.myDelegate.selectedNumber)];
		}
		
	}
	[self clearNumberButtons];
	[self.highScoresLabel setTextColor:[UIColor clearColor]];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:10];
	[self.highScoresLabel setText:[scoreSummary description]];
	[self.highScoresLabel setBackgroundColor:[self.myDelegate.selectedTheme color3]];
	[self.highScoresLabel setTextColor:[UIColor blackColor]];
	[UIView commitAnimations];
	
	[scoreSummary release];
	[highScores setObject:scores forKey:key];
	self.myDelegate.testHighScores = highScores;
	[FEUtils saveNSDictionaryToDocumentsFolder:highScores asFileName:@"TestScores" withPrefix:nil];
}


- (void) playSuccessSound {
	AudioServicesPlaySystemSound(successSound);
}

- (void) playSorrySound {
	AudioServicesPlaySystemSound(sorrySound);
}



/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[myDelegate release];
	[numberButtons release];
	[timesByValues release];
	[answerSlot release];
	[answerSlotBackground release];
	[firstLabel release];
	[timesLabel release];
	[secondLabel release];
	[equalsLabel release];
	[instructionLabel release];
	[highScoresLabel release];
	[scoreLabel release];
	[correctButton release];
	AudioServicesDisposeSystemSoundID(successSound);
	AudioServicesDisposeSystemSoundID(sorrySound);
    [super dealloc];
}

@end
