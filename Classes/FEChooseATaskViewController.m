//
//  FEChooseATaskViewController.m
//  TimesTableFun
//
//  Created by Felix Elliott on 29/08/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import "FEChooseATaskViewController.h"
#import "FETimesTablePracticeViewController.h"
#import "FETimesTableTest.h"
#import "FEGameViewController.h"
#import "FEPairsViewController.h"
#import "FELearnViewController.h"

@implementation FEChooseATaskViewController

@synthesize table;
@synthesize myDelegate;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		self.myDelegate = (TimesTableFunAppDelegate *) [[UIApplication sharedApplication] delegate];
		NSString *titleString = NSLocalizedStringWithDefaultValue(@"ScreenTitle: Choose a task", @"Localizable", [NSBundle mainBundle], @"Choose an activity", @"Choose an activity");        
		self.title = titleString;
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
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
    [super viewWillAppear:animated];
}




#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	NSString *practiceTitle = NSLocalizedStringWithDefaultValue(@"Activity Title: Practice", @"Localizable", [NSBundle mainBundle], @"Practice", @"Practice");  
	NSString *practiceDetail = NSLocalizedStringWithDefaultValue(@"Activity Detail: Practice", @"Localizable", [NSBundle mainBundle], @"An easy start to learning this table", @"An easy start to learning this table");  
	NSString *gameTitle = NSLocalizedStringWithDefaultValue(@"Activity Title: Game", @"Localizable", [NSBundle mainBundle], @"Game", @"Game");  
	NSString *gameDetail = NSLocalizedStringWithDefaultValue(@"Activity Detail: Game", @"Localizable", [NSBundle mainBundle], @"Have fun learning this table", @"Have fun learning this table");  
	NSString *pairsTitle = NSLocalizedStringWithDefaultValue(@"Activity Title: Pairs", @"Localizable", [NSBundle mainBundle], @"Pairs", @"Pairs");  
	NSString *pairsDetail = NSLocalizedStringWithDefaultValue(@"Activity Detail: Pairs", @"Localizable", [NSBundle mainBundle], @"A challenging memory game", @"A challenging memory game");  
	NSString *testTitle = NSLocalizedStringWithDefaultValue(@"Activity Title: Test", @"Localizable", [NSBundle mainBundle], @"Test", @"Test");  
	NSString *testDetail = NSLocalizedStringWithDefaultValue(@"Activity Detail: Test", @"Localizable", [NSBundle mainBundle], @"See how much you've learned", @"See how much you've learned");  
    NSString *learnTitle = NSLocalizedStringWithDefaultValue(@"Title: Learn", @"Localizable", [NSBundle mainBundle], @"Learn", @"Learn");  
	NSString *learnDetail = NSLocalizedStringWithDefaultValue(@"Activity Detail: Learn", @"Localizable", [NSBundle mainBundle], @"Start from the begining", @"Start from the begining"); 
    
	if (indexPath.row == 0) {
        [cell.textLabel setText:learnTitle];
		[cell.textLabel setTextColor:[self.myDelegate.selectedTheme color5]];
		[cell.textLabel setHighlightedTextColor:[self.myDelegate.selectedTheme color5]];
		[cell.detailTextLabel setText:learnDetail];

    } else if (indexPath.row == 1) {
		[cell.textLabel setText:practiceTitle];
		[cell.textLabel setTextColor:[self.myDelegate.selectedTheme color4]];
		[cell.textLabel setHighlightedTextColor:[self.myDelegate.selectedTheme color4]];
		[cell.detailTextLabel setText:practiceDetail];
	} else 	if (indexPath.row == 2) {
		[cell.textLabel setText:gameTitle];
		[cell.textLabel setTextColor:[self.myDelegate.selectedTheme color3]];
		[cell.textLabel setHighlightedTextColor:[self.myDelegate.selectedTheme color3]];
		[cell.detailTextLabel setText:gameDetail];
	} else if (indexPath.row == 3) {
		[cell.textLabel setText:pairsTitle];
		[cell.textLabel setTextColor:[self.myDelegate.selectedTheme color2]];
		[cell.textLabel setHighlightedTextColor:[self.myDelegate.selectedTheme color2]];
		[cell.detailTextLabel setText:pairsDetail];
	} else if (indexPath.row == 4) {
		[cell.textLabel setText:testTitle];
		[cell.textLabel setTextColor:[self.myDelegate.selectedTheme color1]];
		[cell.textLabel setHighlightedTextColor:[self.myDelegate.selectedTheme color6]];
		[cell.detailTextLabel setText:testDetail];
	} 
	[cell setSelectedBackgroundView:self.myDelegate.tableBackgroundView];
	
	[cell.detailTextLabel setTextColor:[self.myDelegate.selectedTheme textColor]];
	[cell.detailTextLabel setHighlightedTextColor:[self.myDelegate.selectedTheme textColor]];
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	UIViewController *detailViewController = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if (indexPath.row == 0) {
            detailViewController = [[FELearnViewController alloc] initWithNibName:@"FELearnViewController~ipad" bundle:nil];
        } else if (indexPath.row == 1) {
            detailViewController = [[FETimesTablePracticeViewController alloc] initWithNibName:@"FETimesTablePracticeViewController~ipad" bundle:nil];
        } else if (indexPath.row == 2) {
            detailViewController = [[FEGameViewController alloc] initWithNibName:@"FEGameViewController~ipad" bundle:nil];
        } else if (indexPath.row == 3) {
            detailViewController = [[FEPairsViewController alloc] initWithNibName:@"FEPairsViewController~ipad" bundle:nil];
        } else if (indexPath.row == 4) {
            detailViewController = [[FETimesTableTest alloc] initWithNibName:@"FETimesTableTest~ipad" bundle:nil];
        } 
    } else {
        if (indexPath.row == 0) {
            detailViewController = [[FELearnViewController alloc] initWithNibName:@"FELearnViewController" bundle:nil];
        } else if (indexPath.row == 1) {
            detailViewController = [[FETimesTablePracticeViewController alloc] initWithNibName:@"FETimesTablePracticeViewController" bundle:nil];
        } else if (indexPath.row == 2) {
            detailViewController = [[FEGameViewController alloc] initWithNibName:@"FEGameViewController" bundle:nil];
        } else if (indexPath.row == 3) {
            detailViewController = [[FEPairsViewController alloc] initWithNibName:@"FEPairsViewController" bundle:nil];
        } else if (indexPath.row == 4) {
            detailViewController = [[FETimesTableTest alloc] initWithNibName:@"FETimesTableTest" bundle:nil];
        } 
    }
	// ...
	// Pass the selected object to the new view controller.
	if (detailViewController != nil) {
		[self.navigationController pushViewController:detailViewController animated:YES];
		[detailViewController release];
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

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[table release];
	[myDelegate release];
    [super dealloc];
}


@end
