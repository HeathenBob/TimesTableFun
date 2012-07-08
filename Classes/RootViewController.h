//
//  RootViewController.h
//  TimesTableFun
//
//  Created by Felix Elliott on 28/08/2010.
//  Copyright Fatrod Enterprises 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimesTableFunAppDelegate.h"

@interface RootViewController : UIViewController <UITableViewDelegate>  {
	IBOutlet UITableView *table;
	TimesTableFunAppDelegate *myDelegate;
    IBOutlet UIImageView *footerView;
    IBOutlet UIImageView *headerView;
    IBOutlet UILabel *instructionLabel;
}

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) TimesTableFunAppDelegate *myDelegate;
@property (nonatomic, retain) UIImageView *footerView;
@property (nonatomic, retain) UIImageView *headerView;
@property (nonatomic, retain) UILabel *instructionLabel;

@end
