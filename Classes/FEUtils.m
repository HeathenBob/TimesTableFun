//
//  FEUtils.m
//  TimesTableFun
//
//  Created by Felix Elliott on 10/01/2011.
//  Copyright 2011 Fatrod Enterprises. All rights reserved.
//

#import "FEUtils.h"


@implementation FEUtils


+ (void) saveNSDictionaryToDocumentsFolder:(NSDictionary *)dictionary asFileName:(NSString *)fileName withPrefix:(NSString *)prefix  {
	if (fileName != nil) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentDirectory = [paths objectAtIndex:0];
		NSString *fullPath;
		if (prefix != nil) {
			fullPath = [NSString stringWithFormat:@"%@_%@",[prefix stringByReplacingOccurrencesOfString:@"." withString:@"_"],fileName];
			
		} else {
			fullPath = fileName;
		}
		NSString *filePath = [documentDirectory stringByAppendingPathComponent:fullPath];
		[dictionary writeToFile:filePath atomically:YES];
	}
}


+ (NSDictionary *) retrieveNSDictionaryFromDocumentsFolderWithFileName:(NSString *)fileName withPrefix:(NSString *)prefix  {
	if (fileName != nil) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentDirectory = [paths objectAtIndex:0];
		//[FEUtils debug:[NSString stringWithFormat:@"%@",documentDirectory]];
		NSString *fullPath;
		if (prefix != nil) {
			fullPath = [NSString stringWithFormat:@"%@_%@",[prefix stringByReplacingOccurrencesOfString:@"." withString:@"_"],fileName];
			
		} else {
			fullPath = fileName;
		}
		
		NSString *filePath = [documentDirectory stringByAppendingPathComponent:fullPath];
		NSDictionary *retrievedDictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
		return [retrievedDictionary autorelease];
	} else {
		return nil;
	}
	
}

+ (NSArray *) retrieveNSArrayFromDocumentsFolderWithFileName:(NSString *)fileName withPrefix:(NSString *)prefix  {
	if (fileName != nil) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentDirectory = [paths objectAtIndex:0];
		NSString *fullPath;
		if (prefix != nil) {
			fullPath = [NSString stringWithFormat:@"%@_%@",[prefix stringByReplacingOccurrencesOfString:@"." withString:@"_"],fileName];
			
		} else {
			fullPath = fileName;
		}
		NSString *filePath = [documentDirectory stringByAppendingPathComponent:fullPath];
		
		NSArray *retrievedDictionary = [[NSArray alloc] initWithContentsOfFile:filePath];
		return [retrievedDictionary autorelease];
	} else {
		return nil;
	}
	
}

+ (void) saveNSArrayToDocumentsFolder: (NSArray *) array asFileName: (NSString *) fileName withPrefix:(NSString *)prefix  {
	if (fileName != nil) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentDirectory = [paths objectAtIndex:0];
		NSString *fullPath;
		if (prefix != nil) {
			fullPath = [NSString stringWithFormat:@"%@_%@",[prefix stringByReplacingOccurrencesOfString:@"." withString:@"_"],fileName];
			
		} else {
			fullPath = fileName;
		}
		NSString *filePath = [documentDirectory stringByAppendingPathComponent:fullPath];
		[array writeToFile:filePath atomically:YES];
	}
}


+ (void) displayMessage:(NSString *)message withTitle:(NSString *)title {
	UIAlertView *buttonAlert = [[UIAlertView alloc] 
								initWithTitle:title 
								message:message 
								delegate:nil 
								cancelButtonTitle:@"OK" 
								otherButtonTitles:nil];
	[buttonAlert show];
	[buttonAlert release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		[alertView dismissWithClickedButtonIndex:0 animated:YES];
	} else if (buttonIndex == 1) {
		[alertView dismissWithClickedButtonIndex:1 animated:YES];
	}
}

+ (void) debug:(NSString *)message {
	/*
	 UIAlertView *buttonAlert = [[UIAlertView alloc] 
	 initWithTitle:@"Debug" 
	 message:message 
	 delegate:nil 
	 cancelButtonTitle:@"OK" 
	 otherButtonTitles:nil];
	 [buttonAlert show];
	 [buttonAlert release];
	 */
	//NSLog(@"DEBUG: %@", message);
}

+ (void) debug:(NSString *)message withException:(NSException *)exception {
	/*
	 NSMutableString *string = [NSMutableString stringWithCapacity:500];
	 [string appendString:@"DEBUG: "];
	 [string appendString: message];
	 [string appendString:@" %@"];
	 NSLog(string,exception);
	 */
}

+ (void) info:(NSString *)message {
	//NSLog(@"INFO: %@", message);
}

+ (void) log:(NSString *)message {
	//NSLog(@"LOG: %@",message);
}

+ (void) log:(NSString *)format message:(NSString *)message {
	//NSLog(format,message);
}

+ (void) log:(NSString *)message withException:(NSException *)exception {
	NSMutableString *string = [NSMutableString stringWithCapacity:500];
	[string appendString:@"EXCEPTION: "];
	[string appendString: message];
	[string appendString:@" %@"];
	NSLog(string,exception);
}

+ (void) log:(NSString *)message withError:(NSError *)error {
	NSMutableString *string = [NSMutableString stringWithCapacity:500];
	[string appendString:@"ERROR: "];
	[string appendString: message];
	[string appendString:@" %@"];
	NSLog(string,error);
}

@end
