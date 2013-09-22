//
//  TimesTableFunAppDelegate.m
//  TimesTableFun
//
//  Created by Felix Elliott on 28/08/2010.
//  Copyright Fatrod Enterprises 2010. All rights reserved.
//

#import "TimesTableFunAppDelegate.h"
#import "RootViewController.h"
#import "FEUtils.h"


@implementation TimesTableFunAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize selectedTheme;
@synthesize selectedNumber;
@synthesize tableBackgroundView;
@synthesize userName;

@synthesize gameHighScores;
@synthesize pairsHighScores;
@synthesize testHighScores;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	CGRect viewRect = CGRectMake(0.0f, 0.0f, 320.0f, 70.0f);
    self.tableBackgroundView = [[[UIView alloc ]initWithFrame:viewRect] autorelease];
	[self.tableBackgroundView setBackgroundColor:[UIColor colorWithRed:226.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0]];
	NSString *usersName = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
	if (usersName != nil) {
		self.userName = usersName;
	}
	self.pairsHighScores = [NSMutableDictionary dictionaryWithDictionary:[FEUtils retrieveNSDictionaryFromDocumentsFolderWithFileName:@"PairsScores" withPrefix:nil]];
	self.gameHighScores = [NSMutableDictionary dictionaryWithDictionary:[FEUtils retrieveNSDictionaryFromDocumentsFolderWithFileName:@"GameScores" withPrefix:nil]];
	self.testHighScores = [NSMutableDictionary dictionaryWithDictionary:[FEUtils retrieveNSDictionaryFromDocumentsFolderWithFileName:@"TestScores" withPrefix:nil]];
    
    /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.window.rootViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    } else {
        self.window.rootViewController = [[RootViewController alloc] initWithNibName:@"RootViewController-iPad" bundle:nil];
    }
     */
    // Add the navigation controller's view to the window and display.
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [self.window setRootViewController:navigationController];
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

- (NSUInteger) application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //NSLog(@"returning all");
        return UIInterfaceOrientationMaskAll;
    } else {
        //NSLog(@"returning portrait only");
        return UIInterfaceOrientationMaskPortrait;
    }
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[selectedTheme release];
	[tableBackgroundView release];
	[userName release];
	[gameHighScores release];
	[pairsHighScores release];
	[testHighScores release];
	 
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

