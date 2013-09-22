//
//  FELearnViewController.m
//  TimesTableFun
//
//  Created by Felix Elliott on 09/06/2012.
//  Copyright (c) 2012 Heathen Bob. All rights reserved.
//

#import "FELearnViewController.h"
#import "FENumberLabel.h"


@implementation FELearnViewController

@synthesize myDelegate;
@synthesize instructionLabel;
@synthesize countdownButton;
@synthesize nextButton;
@synthesize layoutPanel;
@synthesize buttonTimer;
@synthesize topBar;
@synthesize bottomBar;
@synthesize freyaImage;

- (void) dealloc {
    [myDelegate release];
    [instructionLabel release];
    [countdownButton release];
    [nextButton release];
    [layoutPanel release];
    [buttonTimer release];
    [topBar release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.myDelegate = (TimesTableFunAppDelegate *) [[UIApplication sharedApplication] delegate];
        NSString *titleText = NSLocalizedStringWithDefaultValue(@"Title: Learn", @"Localizable", [NSBundle mainBundle], @"Learn",@"Learn"); 
        self.title = titleText;
        labels = [NSMutableArray arrayWithCapacity:100];
        level = 2;
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        animationDuration = 2.5;
    } else {
        animationDuration = 1.5;
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    NSURL* audioFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] 
											   pathForResource:@"correct" 
											   ofType:@"caf"]]; 
	AudioServicesCreateSystemSoundID((CFURLRef)audioFile, &successSound); 
	NSURL* audioFile2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] 
                                                pathForResource:@"wrong" 
                                                ofType:@"caf"]]; 
	AudioServicesCreateSystemSoundID((CFURLRef)audioFile2, &sorrySound); 
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated {
    UINavigationBar *bar = self.navigationController.navigationBar;
    if (bar != nil) {
        if ([bar respondsToSelector:@selector(setBarTintColor:)]) {
            [bar setBarTintColor:[self.myDelegate.selectedTheme color5]];
            [bar setTintColor:[UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1.0]];
            bar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
            [bar setTranslucent:NO];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        } else {
            [bar setTintColor:[self.myDelegate.selectedTheme color5]];
        }
    }
    [self.bottomBar setBackgroundColor:[self.myDelegate.selectedTheme color5]];
    [self.instructionLabel setHighlightedTextColor:[self.myDelegate.selectedTheme highlightTextColor]];
    [self.instructionLabel setTextColor:[self.myDelegate.selectedTheme textColor]];
    [self.countdownButton setBackgroundImage:[UIImage imageNamed:@"bigredbutton.png"] forState:UIControlStateNormal];
    [self.countdownButton setBackgroundImage:[UIImage imageNamed:@"bigredbutton.png"] forState:UIControlStateSelected];
    [self.countdownButton setBackgroundImage:[UIImage imageNamed:@"bigredbutton.png"] forState:UIControlStateHighlighted];
    [self.countdownButton setBackgroundImage:[UIImage imageNamed:@"bigredbutton.png"] forState:UIControlStateDisabled];
    [self.countdownButton setBackgroundImage:[UIImage imageNamed:@"bigredbutton.png"] forState:UIControlStateApplication];
    [self.countdownButton setBackgroundImage:[UIImage imageNamed:@"bigredbutton.png"] forState:UIControlStateReserved];
    score = 0;
    int selectedNumber = self.myDelegate.selectedNumber;
    float width = 20.0;
    float height = 20.0;
    float gap = 2.0;
    float yOffset = 2.0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        width = 40.0;
        height = 40.0;
        gap = 4.0;
        yOffset = 4.0;
    } 
    CGRect lpFrame = self.layoutPanel.frame;
    int xCenter = lpFrame.origin.x + lpFrame.size.width/2.0;
    lpFrame.size.width = yOffset + selectedNumber * (width + gap);
    lpFrame.origin.x = xCenter - (lpFrame.size.width/2.0);
    self.layoutPanel.frame = lpFrame;
    
    
    CGRect rect = self.nextButton.frame;
    rect.origin.y = self.freyaImage.frame.origin.y  - (20.0 + self.nextButton.frame.size.height);
    rect.origin.x = -100;
    self.nextButton.frame = rect;
    
    [self layoutSquares];
    
    [super viewWillAppear:animated];
}

- (void) clearBoard {
    NSArray *subViews =[self.layoutPanel subviews];
    for (int v = 0; v < [subViews count]; v++) {
        if ([subViews objectAtIndex:v] != nil && [[subViews objectAtIndex:v] class] == [FENumberLabel class]) {
            [[subViews objectAtIndex:v] removeFromSuperview];
            [[subViews objectAtIndex:v] release];
        } else if ([subViews objectAtIndex:v] != nil && [[subViews objectAtIndex:v] class] == [UILabel class]) {
            [[subViews objectAtIndex:v] removeFromSuperview];
            [[subViews objectAtIndex:v] release];
        }
    }

}

- (void) layoutSquares {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    beingPressed = NO;
    [self clearBoard];
    int selectedNumber = self.myDelegate.selectedNumber;
    for (int i = 1; i <= selectedNumber*level; i++) {
        FENumberLabel *numberLabel = [[FENumberLabel alloc] initWithNumber:i andPosition:i-1 andMultiple:selectedNumber andYOffset:2.0 andXOffset:2.0];
        //[numberLabel displayValue];
        [self.layoutPanel addSubview:numberLabel];
    }
    buttonNumber = (selectedNumber*level) + 5 + (arc4random() % 5);
    int rand = arc4random() % 6;
    FETheme *theme = [[FETheme alloc] init];
    
    if (rand % 2 == 0) {
        [self.countdownButton setTitleColor:[theme color1] forState:UIControlStateNormal];
        [self.countdownButton setTitleColor:[theme color2] forState:UIControlStateSelected];
        [self.countdownButton setTitleColor:[theme color4] forState:UIControlStateHighlighted];
    } else  {
        [self.countdownButton setTitleColor:[theme color2] forState:UIControlStateNormal];
        [self.countdownButton setTitleColor:[theme color1] forState:UIControlStateSelected];
        [self.countdownButton setTitleColor:[theme color4] forState:UIControlStateHighlighted];
    }
    /*
    else if (rand == 2) {
        [self.countdownButton setTitleColor:[theme color6] forState:UIControlStateNormal];
    } else if (rand == 3) {
        [self.countdownButton setTitleColor:[theme color4] forState:UIControlStateNormal];
    } else if (rand == 4) {
        [self.countdownButton setTitleColor:[theme color5] forState:UIControlStateNormal];
    } else {
        [self.countdownButton setTitleColor:[theme color6] forState:UIControlStateNormal];
    }
     */
    
    [self.countdownButton setTitle:[NSString stringWithFormat:@"%i", buttonNumber] forState:UIControlStateNormal];
    CGRect lpFrame = self.layoutPanel.frame;
    float centerX = lpFrame.origin.x + (lpFrame.size.width/2.0);
    float width = 20.0;
    float height = 20.0;
    float gap = 2.0;
    float yOffset = 2.0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        width = 40.0;
        height = 40.0;
        gap = 4.0;
        yOffset = 4.0;
    } 
    float buttonY = lpFrame.origin.y + (level * (height + gap)) + yOffset + 10.0;
    CGRect buttonFrame = self.countdownButton.frame;
    float buttonX = centerX - (buttonFrame.size.width/2);
    buttonFrame.origin.x = buttonX;
    buttonFrame.origin.y = buttonY;
    self.countdownButton.frame = buttonFrame;
    self.countdownButton.hidden = NO;
    self.nextButton.hidden = YES;
    
    NSString *instructionText = NSLocalizedStringWithDefaultValue(@"Freya: count squares", @"Localizable", [NSBundle mainBundle], @"How many squares? Press the button when it shows the correct answer.",@"How many squares? Press the button when it shows the correct answer."); 
    [self.instructionLabel setText: instructionText];
    self.instructionLabel.highlighted = NO;
    float time = 0.8 + (0.1 * selectedNumber);
    self.buttonTimer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(decrementButton) userInfo:nil repeats:YES];
    [self.buttonTimer fire];
    [UIView commitAnimations];
}

- (void) decrementButton {
    int selectedNumber = self.myDelegate.selectedNumber;
    if (beingPressed == NO) {
        buttonNumber--;
        if (buttonNumber < 1 || buttonNumber < ((selectedNumber * level) - 7) || (buttonNumber < ((selectedNumber * level) - 5) && buttonNumber % 10 == 0)) {
            buttonNumber = (selectedNumber*level) + 5 + (arc4random() % 5);
        }
        [self.countdownButton setTitle:[NSString stringWithFormat:@"%i", buttonNumber] forState:UIControlStateNormal];
    }
}

- (IBAction) countDownButtonClicked:(id)sender {
    beingPressed = YES;
    int selectedNumber = self.myDelegate.selectedNumber;
    
    if (buttonNumber == (selectedNumber*level)) {
        [self playSuccessSound];
        score++;
        if (self.buttonTimer != nil) {
            [self.buttonTimer invalidate];
        }
        
        if (level < 10) {
            NSString *correctText = NSLocalizedStringWithDefaultValue(@"Freya: correct", @"Localizable", [NSBundle mainBundle], @"CORRECT - press next for another sum", @"CORRECT - press next for another sum"); 
            [self.instructionLabel setText:correctText];
            self.instructionLabel.highlighted = YES;
        } else {
            NSString *nextText = NSLocalizedStringWithDefaultValue(@"Freya: Press next to see your score", @"Localizable", [NSBundle mainBundle], @"Correct. Press next to see your score",@"Correct. Press next to see your score"); 
            [self.instructionLabel setText:nextText];
            self.instructionLabel.highlighted = YES;
        }
        
        CGRect rect = self.nextButton.frame;
        rect.origin.y = self.freyaImage.frame.origin.y  - (20.0 + self.nextButton.frame.size.height);
        rect.origin.x = -100;
        self.nextButton.frame = rect;
        
        self.nextButton.hidden = NO;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
       
        rect.origin.x = self.layoutPanel.frame.origin.x + self.layoutPanel.frame.size.width ;//- self.nextButton.frame.size.width;
        //self.countdownButton.hidden = YES;
        self.nextButton.frame = rect;
        
        [UIView commitAnimations];
        NSArray *subViews =[self.layoutPanel subviews];
        for (int v = 0; v < [subViews count]; v++) {
            if ([subViews objectAtIndex:v] != nil && [[subViews objectAtIndex:v] class] == [FENumberLabel class]) {
                FENumberLabel *numberLabel = (FENumberLabel*) [subViews objectAtIndex:v];
                [numberLabel displayValue];
            }
        }
    } else {
        [self playSorrySound];
        if (score > 0) {
            score--;
        }
        NSString *wrongText = NSLocalizedStringWithDefaultValue(@"Freya: wrong try again", @"Localizable", [NSBundle mainBundle], @"SORRY - Wrong answer, try again", @"SORRY - Wrong answer, try again"); 
        [self.instructionLabel setText:wrongText];
        self.instructionLabel.highlighted = YES;
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(starCountDownAgain:) userInfo:nil repeats:NO];
    }
}

- (void) starCountDownAgain:(NSTimer*)theTimer {
    beingPressed = NO;
    [theTimer invalidate];
}

- (IBAction) nextButtonClicked:(id)sender {
    level++;
    
    [UIView beginAnimations:@"next_button_animation" context:NULL];
	[UIView setAnimationDuration:animationDuration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    
	CGRect rect = self.nextButton.frame;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        rect.origin.x = 1030;
    } else {
        rect.origin.x = 360;
    }
    rect.origin.y = self.freyaImage.frame.origin.y  - (20.0 + self.nextButton.frame.size.height);
	self.nextButton.frame = rect;
    
	[UIView commitAnimations];
    
    
    
    
}

- (void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
    
    if (level <= 10) {
        
        CGRect rect = self.nextButton.frame;
        rect.origin.x = -100;
        self.nextButton.frame = rect;
        
        [self layoutSquares];
    } else {
        [self clearBoard];
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.layoutPanel.frame.size.width, self.layoutPanel.frame.size.height)];
        [scoreLabel setText:[NSString stringWithFormat:@"%i", score]];
        [scoreLabel setTextAlignment:UITextAlignmentCenter];
        [scoreLabel setFont:[UIFont boldSystemFontOfSize:100.0]];
        [scoreLabel setTextColor:[self.myDelegate.selectedTheme color1]]; 
        [self.layoutPanel addSubview:scoreLabel];
    }
    if (level > 10) {
        if (score > 8) {
            NSString *excellent = NSLocalizedStringWithDefaultValue(@"Freya: Excellent score", @"Localizable", [NSBundle mainBundle], @"EXCELLENT %@, you scored %i", @"EXCELLENT %@, you scored %i");  
            [self.instructionLabel setText:[[NSString stringWithFormat:excellent, self.myDelegate.userName, score] uppercaseString]];
        } else if (score > 6) {
            NSString *wellDone = NSLocalizedStringWithDefaultValue(@"Freya: Well done score", @"Localizable", [NSBundle mainBundle], @"WELL DONE %@, you scored %i", @"WELL DONE %@, you scored %i");  
            [self.instructionLabel setText:[[NSString stringWithFormat:wellDone, self.myDelegate.userName, score] uppercaseString]];
        } else if (score > 4) {
            NSString *notBad = NSLocalizedStringWithDefaultValue(@"Freya: Not bad score", @"Localizable", [NSBundle mainBundle], @"NOT BAD %@, you scored %i", @"NOT BAD %@, you scored %i");  
            [self.instructionLabel setText:[NSString stringWithFormat:notBad, self.myDelegate.userName, score]];
        } else {
            NSString *rubbish = NSLocalizedStringWithDefaultValue(@"Freya: Rubbish score", @"Localizable", [NSBundle mainBundle], @"You scored %i. I think you need more practice %@.", @"You scored %i. I think you need more practice %@.");  
            [self.instructionLabel setText:[NSString stringWithFormat:rubbish, score, self.myDelegate.userName]];
            
        }
        self.instructionLabel.highlighted = NO;
        
        CGRect rect = self.nextButton.frame;
        rect.origin.x = -100;
        
        
        self.nextButton.frame = rect;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        rect.origin.x = self.layoutPanel.frame.origin.x + self.layoutPanel.frame.size.width;// s - rect.size.width;
        self.nextButton.frame = rect;
        
        [UIView commitAnimations];
        level = 1;
        score = 0;
    } 
}

- (void) playSuccessSound {
	AudioServicesPlaySystemSound(successSound);
}

- (void) playSorrySound {
	AudioServicesPlaySystemSound(sorrySound);
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            self.topBar.hidden = YES;
            CGRect frame = layoutPanel.frame;
            frame.origin.y = 10.0;
            layoutPanel.frame = frame;
        } else {
            self.topBar.hidden = NO;
            CGRect frame = layoutPanel.frame;
            frame.origin.y = 113.0;
            layoutPanel.frame = frame;
        }
        
        
        CGRect rect = self.nextButton.frame;
        rect.origin.y = self.freyaImage.frame.origin.y  - (20.0 + self.nextButton.frame.size.height);
        self.nextButton.frame = rect;
        
        CGRect lpFrame = self.layoutPanel.frame;
        float centerX = lpFrame.origin.x + (lpFrame.size.width/2.0);
        float width = 20.0;
        float height = 20.0;
        float gap = 2.0;
        float yOffset = 2.0;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            width = 40.0;
            height = 40.0;
            gap = 4.0;
            yOffset = 4.0;
        } 
        float buttonY = lpFrame.origin.y + (level * (height + gap)) + yOffset + 10.0;
        CGRect buttonFrame = self.countdownButton.frame;
        float buttonX = centerX - (buttonFrame.size.width/2);
        buttonFrame.origin.x = buttonX;
        buttonFrame.origin.y = buttonY;
        self.countdownButton.frame = buttonFrame;
        return YES;
    } else {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}

- (BOOL)shouldAutorotate {
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        /*
        if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            self.topBar.hidden = YES;
            CGRect frame = layoutPanel.frame;
            frame.origin.y = 10.0;
            layoutPanel.frame = frame;
        } else {
            self.topBar.hidden = NO;
            CGRect frame = layoutPanel.frame;
            frame.origin.y = 113.0;
            layoutPanel.frame = frame;
        }
        
        
        CGRect rect = self.nextButton.frame;
        rect.origin.y = self.freyaImage.frame.origin.y  - (20.0 + self.nextButton.frame.size.height);
        self.nextButton.frame = rect;
        
        CGRect lpFrame = self.layoutPanel.frame;
        float centerX = lpFrame.origin.x + (lpFrame.size.width/2.0);
        float width = 20.0;
        float height = 20.0;
        float gap = 2.0;
        float yOffset = 2.0;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            width = 40.0;
            height = 40.0;
            gap = 4.0;
            yOffset = 4.0;
        }
        float buttonY = lpFrame.origin.y + (level * (height + gap)) + yOffset + 10.0;
        CGRect buttonFrame = self.countdownButton.frame;
        float buttonX = centerX - (buttonFrame.size.width/2);
        buttonFrame.origin.x = buttonX;
        buttonFrame.origin.y = buttonY;
        self.countdownButton.frame = buttonFrame;
         */
        return YES;
    } else {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }

}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            self.topBar.hidden = YES;
            CGRect frame = layoutPanel.frame;
            frame.origin.y = 10.0;
            layoutPanel.frame = frame;
        } else {
            self.topBar.hidden = NO;
            CGRect frame = layoutPanel.frame;
            frame.origin.y = 113.0;
            layoutPanel.frame = frame;
        }
        
        
        CGRect rect = self.nextButton.frame;
        rect.origin.y = self.freyaImage.frame.origin.y  - (20.0 + self.nextButton.frame.size.height);
        self.nextButton.frame = rect;
        
        CGRect lpFrame = self.layoutPanel.frame;
        float centerX = lpFrame.origin.x + (lpFrame.size.width/2.0);
        float width = 20.0;
        float height = 20.0;
        float gap = 2.0;
        float yOffset = 2.0;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            width = 40.0;
            height = 40.0;
            gap = 4.0;
            yOffset = 4.0;
        }
        float buttonY = lpFrame.origin.y + (level * (height + gap)) + yOffset + 10.0;
        CGRect buttonFrame = self.countdownButton.frame;
        float buttonX = centerX - (buttonFrame.size.width/2);
        buttonFrame.origin.x = buttonX;
        buttonFrame.origin.y = buttonY;
        self.countdownButton.frame = buttonFrame;
    }
}

@end
