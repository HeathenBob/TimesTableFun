//
//  FEName.m
//  TimesTableFun
//
//  Created by Felix Elliott on 09/01/2011.
//  Copyright 2011 Fatrod Enterprises. All rights reserved.
//

#import "FEName.h"
#import "FEChooseNumberViewController.h"


@implementation FEName

@synthesize myDelegate;
@synthesize nameField;
@synthesize instructionLabel;
@synthesize nameLabel;
@synthesize nextButton;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.myDelegate = (TimesTableFunAppDelegate *) [[UIApplication sharedApplication] delegate];
		self.nameField.delegate = self;
		NSString *titleString = NSLocalizedStringWithDefaultValue(@"Page title: Your name", @"Localizable", [NSBundle mainBundle], @"Your name", @"Your name");
		
		self.title = titleString;
		
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        animationDuration = 2.5;
    } else {
        animationDuration = 1.5;
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    UINavigationBar *bar = self.navigationController.navigationBar;
    if (bar != nil) {
        if ([bar respondsToSelector:@selector(setBarTintColor:)]) {
            [bar setBarTintColor:[self.myDelegate.selectedTheme color6]];
            [bar setTintColor:[UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1.0]];
            bar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
            [bar setTranslucent:NO];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        } else {
            [bar setTintColor:[self.myDelegate.selectedTheme color6]];
        }
    }
    [super viewDidLoad];
}


- (void) viewWillAppear:(BOOL)animated {
	NSString *enterName = NSLocalizedStringWithDefaultValue(@"Freya: Type name", @"Localizable", [NSBundle mainBundle], @"Type your name, then tap on the bus", @"Type your name, then tap on the bus");
	[self.instructionLabel setText:enterName];
    [self.instructionLabel setTextColor:[self.myDelegate.selectedTheme textColor]];
	NSString *labelName = NSLocalizedStringWithDefaultValue(@"Label: name", @"Localizable", [NSBundle mainBundle], @"my name is", @"my name is");
	[self.nameLabel setText:labelName];
	CGRect rect = self.nextButton.frame;
	rect.origin.x = self.nameField.frame.origin.x;
	self.nextButton.frame = rect;
	NSString *userName = myDelegate.userName;
	if (userName != nil) {
		[self.nameField setText:userName];
	}
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if ([self.nameField.text length] > 0) {
		[self.myDelegate setUserName:self.nameField.text];
		[[NSUserDefaults standardUserDefaults] setObject:self.nameField.text forKey:@"USER_NAME"];
	} else {
		[self.myDelegate setUserName:NSLocalizedStringWithDefaultValue(@"Default: name", @"Localizable", [NSBundle mainBundle], @"Player 1", @"Player 1")];
		[[NSUserDefaults standardUserDefaults] setObject:@"Player1" forKey:@"USER_NAME"];
	}
	[textField resignFirstResponder];
	return YES;
}

- (IBAction) nextButtonPressed {
    
    if ([self.nameField.text length] > 0) {
		[self.myDelegate setUserName:self.nameField.text];
		[[NSUserDefaults standardUserDefaults] setObject:self.nameField.text forKey:@"USER_NAME"];
	} else {
		[self.myDelegate setUserName:NSLocalizedStringWithDefaultValue(@"Default: name", @"Localizable", [NSBundle mainBundle], @"Player 1", @"Player 1")];
		[[NSUserDefaults standardUserDefaults] setObject:@"Player1" forKey:@"USER_NAME"];
	}
	[self.nameField resignFirstResponder];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:animationDuration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	CGRect rect = self.nextButton.frame;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        rect.origin.x = 1130;
    } else {
        rect.origin.x = 360;
    }
	self.nextButton.frame = rect;
	[UIView commitAnimations];
	
	[self performSelector:@selector(goNext) withObject:nil afterDelay:1.0f];
	
}

- (void) goNext {
	FEChooseNumberViewController *detailViewController = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        detailViewController = [[FEChooseNumberViewController alloc] initWithNibName:@"FEChooseNumberViewController~ipad" bundle:nil];
    } else {
        detailViewController = [[FEChooseNumberViewController alloc] initWithNibName:@"FEChooseNumberViewController" bundle:nil];
    }
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[myDelegate release];
	[nameField release];
	[nameLabel release];
	[instructionLabel release];
	[nextButton release];
    [super dealloc];
}


@end
