//
//  BDITableViewController.h
//  BDRInventory
//
//  Created by Amr Lotfy on 6/29/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDIProduct.h"
#import "BDIProductDetailsViewController.h"
#import "BDInventory.h"

@interface BDIProductsTableViewController
    : UITableViewController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic) NSDictionary* results;
@property(nonatomic,copy) BDIProduct* product;
@end
