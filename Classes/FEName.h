//
//  FEName.h
//  TimesTableFun
//
//  Created by Felix Elliott on 09/01/2011.
//  Copyright 2011 Fatrod Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimesTableFunAppDelegate.h"

@interface FEName : UIViewController <UITextFieldDelegate> {
	TimesTableFunAppDelegate *myDelegate;
	IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *instructionLabel;
	IBOutlet UITextField *nameField;
	IBOutlet UIButton *nextButton;
}

@property (nonatomic, retain) TimesTableFunAppDelegate *myDelegate;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *instructionLabel;
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;

- (IBAction) nextButtonPressed;
- (void) goNext;

@end
