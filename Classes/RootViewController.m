//
//  RootViewController.m
//  TimesTableFun
//
//  Created by Felix Elliott on 28/08/2010.
//  Copyright Fatrod Enterprises 2010. All rights reserved.
//

#import "RootViewController.h"
#import "FETimesTablePracticeViewController.h"
#import "FEStarTheme.h"
#import "FEHeartTheme.h"
#import "FEAppleTheme.h"
#import "FEFootballTheme.h"
#import "FEChooseNumberViewController.h"
#import "FEName.h"

@implementation RootViewController

@synthesize table;
@synthesize myDelegate;
@synthesize headerView;
@synthesize footerView;
@synthesize instructionLabel;


#pragma mark -
#pragma mark View lifecycle

- (void)dealloc {
	[myDelegate release];
	[table release];
    [headerView release];
    [footerView release];
    [instructionLabel release];
    [super dealloc];
}


- (void)viewDidLoad {
	self.myDelegate = (TimesTableFunAppDelegate *) [[UIApplication sharedApplication] delegate];
	self.myDelegate.selectedTheme = [[[FEStarTheme alloc]init]autorelease];
	self.title = @"Times Table Fun";
    
    NSString *welcomeString = NSLocalizedStringWithDefaultValue(@"Freya: Welcome to", @"Localizable", [NSBundle mainBundle], @"Hello - Welcome to Times Table Fun. Pick a theme", @"Hello - Welcome to Times Table Fun. Pick a theme");
	[self.instructionLabel setText:welcomeString];
	[self.instructionLabel setTextColor:[self.myDelegate.selectedTheme textColor]];
	[self.instructionLabel setBackgroundColor:[UIColor clearColor]];
    
	[self.instructionLabel setNumberOfLines:0];

    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/


 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark -
#pragma mark Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return 0;
    } else {
        return 0;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return 0;
    } else {
        return 0;
    }
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	UIImageView *footerView = nil;
    UILabel *headerLabel = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        footerView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 230)] autorelease];
        [footerView setImage:[UIImage imageNamed:@"smile4~ipad.png"]];
        
        headerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20.0, 2.0, 195, 65)] autorelease];
    } else {
        footerView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 96)] autorelease];
        [footerView setImage:[UIImage imageNamed:@"speech3.png"]];
	
        headerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20.0, 2.0, 195, 65)] autorelease];
    }
	NSString *welcomeString = NSLocalizedStringWithDefaultValue(@"Freya: Welcome to", @"Localizable", [NSBundle mainBundle], @"Hello - Welcome to Times Table Fun. Pick a theme", @"Hello - Welcome to Times Table Fun. Pick a theme");
	[headerLabel setText:welcomeString];
	[headerLabel setTextColor:[self.myDelegate.selectedTheme textColor]];
	[headerLabel setBackgroundColor:[UIColor clearColor]];
	[headerLabel setFont:[UIFont italicSystemFontOfSize:14]];
	[headerLabel setNumberOfLines:0];
	[footerView addSubview:headerLabel];
	return footerView;
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSString *stars = NSLocalizedStringWithDefaultValue(@"Theme: Starts", @"Localizable", [NSBundle mainBundle], @"Stars", @"Stars");
	NSString *hearts = NSLocalizedStringWithDefaultValue(@"Theme: Hearts", @"Localizable", [NSBundle mainBundle], @"Hearts", @"Hearts");
	NSString *apples = NSLocalizedStringWithDefaultValue(@"Theme: Apples", @"Localizable", [NSBundle mainBundle], @"Apples", @"Apples");
	NSString *footballs = NSLocalizedStringWithDefaultValue(@"Theme: Footballs", @"Localizable", [NSBundle mainBundle], @"Footballs", @"Footballs");
	// Configure the cell.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if (indexPath.row == 0) {
            [cell.textLabel setText:stars];
            [cell.imageView setImage:[UIImage imageNamed:@"star_blue~ipad.png"]];
        } else if (indexPath.row == 1) {
            [cell.textLabel setText:hearts];
            [cell.imageView setImage:[UIImage imageNamed:@"heart_pink~ipad.png"]];
        } else if (indexPath.row == 2) {
            [cell.textLabel setText:apples];
            [cell.imageView setImage:[UIImage imageNamed:@"apple_red~ipad.png"]];
        }  else if (indexPath.row == 3) {
            [cell.textLabel setText:footballs];
            [cell.imageView setImage:[UIImage imageNamed:@"ball_green~ipad.png"]];
        }
    } else {
        if (indexPath.row == 0) {
            [cell.textLabel setText:stars];
            [cell.imageView setImage:[UIImage imageNamed:@"star_blue.png"]];
        } else if (indexPath.row == 1) {
            [cell.textLabel setText:hearts];
            [cell.imageView setImage:[UIImage imageNamed:@"heart_pink.png"]];
        } else if (indexPath.row == 2) {
            [cell.textLabel setText:apples];
            [cell.imageView setImage:[UIImage imageNamed:@"apple_red.png"]];
        }  else if (indexPath.row == 3) {
            [cell.textLabel setText:footballs];
            [cell.imageView setImage:[UIImage imageNamed:@"ball_green.png"]];
        }
    }
	
	[cell setSelectedBackgroundView:self.myDelegate.tableBackgroundView];
	[cell.textLabel setHighlightedTextColor:[self.myDelegate.selectedTheme color5]];
	[cell.textLabel setTextColor:[self.myDelegate.selectedTheme textColor]];
	 
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
    
	if (indexPath.row == 0) {
		[self.myDelegate setSelectedTheme:[[[FEStarTheme alloc] init] autorelease]];
	} else if (indexPath.row == 1) {
		[self.myDelegate setSelectedTheme:[[[FEHeartTheme alloc] init] autorelease]];
	} else if (indexPath.row == 2) {
		[self.myDelegate setSelectedTheme:[[[FEAppleTheme alloc] init] autorelease]];
	} else if (indexPath.row == 3) {
		[self.myDelegate setSelectedTheme:[[[FEFootballTheme alloc] init] autorelease]];
	} 
	 //FEChooseNumberViewController *detailViewController = [[FEChooseNumberViewController alloc] init];
	FEName *detailViewController = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        detailViewController = [[FEName alloc] initWithNibName:@"FEName" bundle:nil];
    } else {
        detailViewController = [[FEName alloc] initWithNibName:@"FEName-iPad" bundle:nil];
    }
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}





@end

