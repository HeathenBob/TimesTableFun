//
//  FEChooseNumberViewController.h
//  TimesTableFun
//
//  Created by Felix Elliott on 29/08/2010.
//  Copyright 2010 Fatrod Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimesTableFunAppDelegate.h"

@interface FEChooseNumberViewController : UIViewController <UITableViewDelegate> {
	TimesTableFunAppDelegate *myDelegate;
	IBOutlet UITableView *table;
}

@property (nonatomic, retain) TimesTableFunAppDelegate *myDelegate;
@property (nonatomic, retain) IBOutlet UITableView *table;

@end
