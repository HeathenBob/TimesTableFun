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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	CGRect rect = self.correctButton.frame;
	rect.origin.x = -100;
	//rect.origin.y = -100;
	self.correctButton.frame = rect;
	[self.view setBackgroundColor:[UIColor whiteColor]];
	[self.instructionLabel setTextColor:[self.myDelegate.selectedTheme textColor]];
	[self.instructionLabel setHighlightedTextColor:[self.myDelegate.selectedTheme color1]];
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
		FENumberButton *numberButton = [[FENumberButton alloc] initWithNumber:(NSInteger)whichTable * (i + 1) andPosition:[[random10 objectAtIndex:i] intValue] andYOffset:yO andXOffset:xO  andTheme:self.myDelegate.selectedTheme andParent:self];
		
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

- (void) start {
	self.correctButton.hidden = NO;
	NSString *dragText = NSLocalizedStringWithDefaultValue(@"Freya: drag", @"Localizable", [NSBundle mainBundle], @"Drag the correct answer on to the square", @"Drag the correct answer on to the square"); 
	[instructionLabel setText:dragText];
	[self.firstLabel setText:[NSString stringWithFormat:@"%i", whichTable]];
	for (int i = 0; i < 10; i++) {
        [[self.numberButtons objectAtIndex:i] setHidden:NO];
		[[self.numberButtons objectAtIndex:i] setEnabled:YES];
		[[self.numberButtons objectAtIndex:i] setHighlighted:NO];
		[[self.numberButtons objectAtIndex:i] setSelected:NO];
		[[self.numberButtons objectAtIndex:i] returnToOriginalPosition];
	}
	[self.secondLabel setText:[NSString stringWithFormat:@"%i", timesBy]];
	
}

- (void) alternateColor {
	UIColor *colorToUse = [self.myDelegate.selectedTheme color1];
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
	[UIView setAnimationDuration:1];
	CGRect rect = self.correctButton.frame;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        rect.origin.x = 1100;
    } else {
        rect.origin.x = 330;
    }
	
	//rect.origin.y = 240;
	self.correctButton.frame =rect;
	[self alternateColor];
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
    
    @try {
	UITouch *touch = [touches anyObject];
    currentTouch = [touch locationInView:self.view];
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
				[UIView beginAnimations:nil context:nil];
				[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
				
				if (timesBy < 10) {
					
					CGRect rect = self.correctButton.frame;
					rect.origin.x = -100;
					//rect.origin.y = 240;
					self.correctButton.frame =rect;
					[UIView setAnimationDuration:2];
                    
					
					NSString *correctText = NSLocalizedStringWithDefaultValue(@"Freya: correct", @"Localizable", [NSBundle mainBundle], @"CORRECT - press next for another sum", @"CORRECT - press next for another sum"); 
					
					[instructionLabel setText:correctText];
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
					rect.origin.x = answerSlot.frame.origin.x;
					//rect.origin.y = 240;
					self.correctButton.frame =rect;
				} else {
					[UIView setAnimationDuration:2];
					for (int i = 0; i < 10; i++) {
						[[self.numberButtons objectAtIndex:i] setHidden:YES];
					}
					CGRect rect = self.slideView.frame;
					rect.origin.y = 0;
					self.slideView.frame = rect;
					NSString *correctText2 = NSLocalizedStringWithDefaultValue(@"Freya: correct done", @"Localizable", [NSBundle mainBundle], @"CORRECT - well done", @"CORRECT - well done"); 
					
					[instructionLabel setText:correctText2];
				}

				
				[UIView commitAnimations];
			} else {
				[UIView beginAnimations:nil context:nil];
				[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
				[UIView setAnimationDuration:1];
				NSString *wrongText = NSLocalizedStringWithDefaultValue(@"Freya: wrong try again", @"Localizable", [NSBundle mainBundle], @"SORRY - Wrong answer, try again", @"SORRY - Wrong answer, try again"); 
				
				[instructionLabel setText:wrongText];
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
	AudioServicesDisposeSystemSoundID(successSound);
	AudioServicesDisposeSystemSoundID(sorrySound);
    [super dealloc];
}

@end
