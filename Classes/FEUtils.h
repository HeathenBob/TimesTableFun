//
//  FEUtils.h
//  TimesTableFun
//
//  Created by Felix Elliott on 10/01/2011.
//  Copyright 2011 Fatrod Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FEUtils : UIView {

}

+ (void) saveNSDictionaryToDocumentsFolder:(NSDictionary *)dictionary asFileName:(NSString *)fileName withPrefix:(NSString *)prefix;
+ (NSDictionary *) retrieveNSDictionaryFromDocumentsFolderWithFileName:(NSString *)fileName withPrefix:(NSString *)prefix;
+ (void) saveNSArrayToDocumentsFolder:(NSArray *)array asFileName:(NSString *)fileName withPrefix:(NSString *)prefix;
+ (NSArray *) retrieveNSArrayFromDocumentsFolderWithFileName:(NSString *)fileName withPrefix:(NSString *)prefix;
+ (void) debug:(NSString *)message;
+ (void) info:(NSString *)message;
+ (void) displayMessage:(NSString *)message withTitle:(NSString *)title;
+ (void) debug:(NSString *)message withException:(NSException *)exception;
+ (void) log:(NSString *)message withException:(NSException *)exception;
+ (void) log:(NSString *)message withError:(NSError *)error;
+ (void) log:(NSString *)message;
+ (void) log:(NSString *)format message:(NSString *)message;


@end
