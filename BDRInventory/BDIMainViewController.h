//
//  BDIMainViewController.h
//  BDRInventory
//
//  Created by Amr Lotfy on 7/2/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BDIGrouping.h"
#import "BDInventory.h"
#import "BDIExpireFilterViewController.h"
#import "BDIProductFilter.h"
#import "BDIProductsTableViewController.h"

@interface BDIMainViewController : UIViewController<BDExpireFilterProtocol>

@property(nonatomic) NSDictionary* results;
@property(nonatomic) BDIProductFilter*
    productFilter;  // this filter instance is dedicated to this tab

@end
