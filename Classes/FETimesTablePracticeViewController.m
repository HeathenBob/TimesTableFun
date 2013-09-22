//
//  MovingButtonsViewController.m
//  MovingButtons
//
//  Created by Felix Elliott on 21/08/2010.
//  Copyright Fatrod Enterprises 2010. All rights reserved.
//

#import "FETimesTablePracticeViewController.h"


@implementation FETimesTablePracticeViewController
@synthesize numberButtons;
@synthesize whichTable;
@synthesize answerSlot;
@synthesize firstLabel;
@synthesize timesLabel;
@synthesize secondLabel;
@synthesize equalsLabel;
@synthesize instructionLabel;
@synthesize correctButton;
@synthesize myDelegate;
@synthesize slideView;
@synthesize slideViewLabel;
@synthesize slideViewButton;
@synthesize titleView;
@synthesize bottomView;
@synthesize holderView;


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.myDelegate = (TimesTableFunAppDelegate *) [[UIApplication sharedApplication] delegate];
		NSString *practiceTitle = NSLocalizedStringWithDefaultValue(@"Activity Title: Practice", @"Localizable", [NSBundle mainBundle], @"Practice", @"Practice");  
		self.title = practiceTitle;
		self.correctButton.hidden = YES;
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewWillAppear:(BOOL)animated {
    UINavigationBar *bar = self.navigationController.navigationBar;
    if (bar != nil) {
        if ([bar respondsToSelector:@selector(setBarTintColor:)]) {
            [bar setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:45.0/255.0 blue:197.0/255.0 alpha:1.0]];
            [bar setTintColor:[UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1.0]];
            bar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
            [bar setTranslucent:NO];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
    }
    [self.slideView setBackgroundColor:[self.myDelegate.selectedTheme color5]];
    [self.bottomView setBackgroundColor:[self.myDelegate.selectedTheme color4]];
    [self.slideViewButton.titleLabel setTextColor:[self.myDelegate.selectedTheme color1]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        animationDuration = 2.0;
    } else {
        animationDuration = 1.5;
    }
    
	CGRect rect = self.correctButton.frame;
	rect.origin.x = -100;
	//rect.origin.y = -100;
	self.correctButton.frame = rect;
	[self.view setBackgroundColor:[UIColor whiteColor]];
	[self.instructionLabel setTextColor:[self.myDelegate.selectedTheme textColor]];
	[self.instructionLabel setHighlightedTextColor:[self.myDelegate.selectedTheme highlightTextColor]];
    self.instructionLabel.highlighted = NO;
	NSURL* audioFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
											   pathForResource:@"correct"
											   ofType:@"caf"]];
	AudioServicesCreateSystemSoundID((CFURLRef)audioFile, &successSound);
	NSURL* audioFile2 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                pathForResource:@"wrong"
                                                ofType:@"caf"]];
	AudioServicesCreateSystemSoundID((CFURLRef)audioFile2, &sorrySound);
	self.whichTable = self.myDelegate.selectedNumber;
	timesBy = 1;
	self.numberButtons = [NSMutableArray arrayWithCapacity:10];
	NSMutableArray *random10 = [NSMutableArray arrayWithCapacity:10];
	for (int i = 0; i < 10; i++) {
		NSNumber *myInt = [NSNumber numberWithInt:i];
		[random10 insertObject:myInt atIndex:i];
	}
	[self randomizeArray:random10];
    
    /*
     float yO = 100.0;
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
     yO = self.firstLabel.frame.origin.y + (2 * (self.firstLabel.frame.size.height));
     } else {
     yO = self.firstLabel.frame.origin.y + (self.firstLabel.frame.size.height) + 20.0;
     }
     */
    //float xO = 20.0;
    float holdery = 100.0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //xO = self.firstLabel.frame.origin.x;
        holdery = 150.0;
    }
    
    float holderx = 15.0;
    
	for (int i = 0; i < 10; i++) {
		FENumberButton *numberButton = [[FENumberButton alloc] initWithNumber:(NSInteger)whichTable * (i + 1) andPosition:[[random10 objectAtIndex:i] intValue]andYOffset:holdery andXOffset:holderx andTheme:self.myDelegate.selectedTheme andParent:self];
		
		[numberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		
		[self.numberButtons addObject:numberButton];
		[numberButton release];
		[self.holderView addSubview:[self.numberButtons objectAtIndex:i]];
	}
	[self.firstLabel setTextColor:[self.myDelegate.selectedTheme color5]];
	[self.timesLabel setTextColor:[self.myDelegate.selectedTheme color5]];
	[self.secondLabel setTextColor:[self.myDelegate.selectedTheme color5]];
	[self.equalsLabel setTextColor:[self.myDelegate.selectedTheme color5]];
	[self.answerSlot setTextColor:[self.myDelegate.selectedTheme color5]];
    
    
	[self start];

    [super viewWillAppear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
        [super viewDidLoad];
}

- (void) start {
	self.correctButton.hidden = NO;
	NSString *dragText = NSLocalizedStringWithDefaultValue(@"Freya: drag", @"Localizable", [NSBundle mainBundle], @"Drag the correct answer on to the square", @"Drag the correct answer on to the square"); 
	[instructionLabel setText:dragText];
    self.instructionLabel.highlighted = NO;
	[self.firstLabel setText:[NSString stringWithFormat:@"%i", whichTable]];
	for (int i = 0; i < 10; i++) {
        [[self.numberButtons objectAtIndex:i] setHidden:NO];
		[[self.numberButtons objectAtIndex:i] setEnabled:YES];
		[[self.numberButtons objectAtIndex:i] setHighlighted:NO];
		[[self.numberButtons objectAtIndex:i] setSelected:NO];
		[[self.numberButtons objectAtIndex:i] returnToOriginalPosition];
	}
	[self.secondLabel setText:[NSString stringWithFormat:@"%i", timesBy]];
    CGRect rect = self.correctButton.frame;
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        rect.origin.x = 1030;
    } else {
        rect.origin.x = 360;
    }
    float ybus = 100.0;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(orientation)) {
            ybus = 22.0;
        } else {
            ybus = self.bottomView.frame.origin.y - (rect.size.height + 40.0);
        }
    } else {
        ybus = self.bottomView.frame.origin.y - (rect.size.height + 20.0);
    }
    
	rect.origin.y = ybus;
	self.correctButton.frame =rect;
	
}

- (void) alternateColor {
	UIColor *colorToUse = [self.myDelegate.selectedTheme color2];
	if (timesBy % 2 == 0) {
		colorToUse = [self.myDelegate.selectedTheme color5];
	}
	[self.firstLabel setTextColor:colorToUse];
	[self.timesLabel setTextColor:colorToUse];
	[self.equalsLabel setTextColor:colorToUse];
	[self.secondLabel setTextColor:colorToUse];
	[self.answerSlot setTextColor:colorToUse];
}

- (void)randomizeArray:(NSMutableArray *) passedArray {
	for(int i=0; i<10; i++) {
		[passedArray exchangeObjectAtIndex:arc4random()%[passedArray count] withObjectAtIndex:arc4random()%[passedArray count]];
	}
}

- (IBAction) nextButtonClicked {
	timesBy++;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:animationDuration];
	CGRect rect = self.correctButton.frame;
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        rect.origin.x = 1030;
    } else {
        rect.origin.x = 360;
    }
	float ybus = 100.0;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(orientation)) {
            ybus = 25.0;
        } else {
            ybus = self.bottomView.frame.origin.y - (rect.size.height + 40.0);
        }
    } else {
        ybus = self.bottomView.frame.origin.y - (rect.size.height + 20.0);
    }
    
	rect.origin.y = ybus;
	self.correctButton.frame =rect;
	[UIView commitAnimations];
    [self alternateColor];
    [self start];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    currentTouch = [touch locationInView:self.holderView];
	for (int i = 0; i < [numberButtons count]; i++) {
		FENumberButton *button = [numberButtons objectAtIndex:i];
		if (currentTouch.x > button.frame.origin.x && currentTouch.x < (button.frame.origin.x + button.frame.size.width) && currentTouch.y > button.frame.origin.y && currentTouch.y < (button.frame.origin.y + button.frame.size.height)) {
			touchedButton = button;
			NSString *dragText = NSLocalizedStringWithDefaultValue(@"Freya: drag", @"Localizable", [NSBundle mainBundle], @"Drag the correct answer on to the square", @"Drag the correct answer on to the square"); 
			[instructionLabel setText:dragText];
            self.instructionLabel.highlighted = YES;
			touchedButton.selected = YES;
			touchOffsetX = currentTouch.x - button.frame.origin.x;
			touchOffsetY = currentTouch.y - button.frame.origin.y;
			break;
		}
	}

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    @try {
	UITouch *touch = [touches anyObject];
    currentTouch = [touch locationInView:self.holderView];
	if (touchedButton != nil) {
		touchedButton.selected = YES;
		CGRect rect = touchedButton.frame;
		rect.origin.x = currentTouch.x - touchOffsetX;
		rect.origin.y = currentTouch.y - touchOffsetY;
		touchedButton.frame = rect;
	}
    } @catch (NSException *e) {
        NSLog(@"error in touches moved %@", [e debugDescription]);
    }
     
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    @try {
	UITouch *touch = [touches anyObject];
    currentTouch = [touch locationInView:self.holderView];
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
				[UIView beginAnimations:nil context:nil];
				[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
				
				if (timesBy < 10) {
					
					CGRect rect = self.correctButton.frame;
					rect.origin.x = -100;
					//rect.origin.y = 240;
                    float ybus = 100.0;
                    
                    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
                        if (UIInterfaceOrientationIsLandscape(orientation)) {
                            ybus = 25.0;
                        } else {
                            ybus = self.bottomView.frame.origin.y - (rect.size.height + 40.0);
                        }
                    } else {
                        ybus = self.bottomView.frame.origin.y - (rect.size.height + 20.0);
                    }
                    
                    rect.origin.y = ybus;
					self.correctButton.frame =rect;
					[UIView setAnimationDuration:animationDuration];
                    
					
					NSString *correctText = NSLocalizedStringWithDefaultValue(@"Freya: correct", @"Localizable", [NSBundle mainBundle], @"CORRECT - press next for another sum", @"CORRECT - press next for another sum"); 
					
					[instructionLabel setText:correctText];
                    self.instructionLabel.highlighted = YES;
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
                    //CGRect rect = self.correctButton.frame;
					rect.origin.x = self.holderView.frame.origin.x + self.holderView.frame.size.width - self.correctButton.frame.size.width;
					//rect.origin.y = 240;
					self.correctButton.frame =rect;
				} else {
                    CGRect rect = self.slideView.frame;
                    CGRect screenBounds = [[UIScreen mainScreen] bounds];
                    rect.size.height = screenBounds.size.height - 64.0;
                    rect.origin.y = (screenBounds.size.height - 64.0) * -1;
                    self.slideView.frame = rect;
					[UIView setAnimationDuration:animationDuration];
					for (int i = 0; i < 10; i++) {
						[[self.numberButtons objectAtIndex:i] setHidden:YES];
					}
					
					rect.origin.y = 0;
                    
					self.slideView.frame = rect;
					NSString *correctText2 = NSLocalizedStringWithDefaultValue(@"Freya: correct done", @"Localizable", [NSBundle mainBundle], @"CORRECT - well done", @"CORRECT - well done"); 
					
					[instructionLabel setText:correctText2];
                    self.instructionLabel.highlighted = YES;
				}

				
				[UIView commitAnimations];
			} else {
				[UIView beginAnimations:nil context:nil];
				[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
				[UIView setAnimationDuration:animationDuration];
				NSString *wrongText = NSLocalizedStringWithDefaultValue(@"Freya: wrong try again", @"Localizable", [NSBundle mainBundle], @"SORRY - Wrong answer, try again", @"SORRY - Wrong answer, try again"); 
				
				[instructionLabel setText:wrongText];
                self.instructionLabel.highlighted = YES;
				touchedButton.enabled = NO;
				[self playSorrySound];
				[touchedButton returnToOriginalPosition];
				[UIView commitAnimations];
			}

		} else {
			[touchedButton returnToOriginalPosition];
		}
	}
	touchedButton = nil;
    } @catch (NSException *e) {
        NSLog(@"error in touches eneded %@", [e debugDescription]);
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"Touches CANCELLED");
}

- (void) playSuccessSound {
	AudioServicesPlaySystemSound(successSound);
}

- (void) playSorrySound {
	AudioServicesPlaySystemSound(sorrySound);
}

- (IBAction) slideViewButtonClicked {
	[self.navigationController popViewControllerAnimated:YES];
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
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
    
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    CGRect rect = self.correctButton.frame;
    float ybus = 100.0;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(orientation)) {
            ybus = 25.0;
        } else {
            ybus = self.bottomView.frame.origin.y - (rect.size.height + 40.0);
        }
    } else {
        ybus = self.bottomView.frame.origin.y - (rect.size.height + 20.0);
    }
    
    rect.origin.y = ybus;
    self.correctButton.frame = rect;
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[myDelegate release];
	[numberButtons release];
	[answerSlot release];
	[firstLabel release];
	[timesLabel release];
	[secondLabel release];
	[equalsLabel release];
	[instructionLabel release];
	[correctButton release];
	[slideView release];
	[slideViewLabel release];
	[slideViewButton release];
    [titleView release];
    [holderView release];
	AudioServicesDisposeSystemSoundID(successSound);
	AudioServicesDisposeSystemSoundID(sorrySound);
    [super dealloc];
}

@end
