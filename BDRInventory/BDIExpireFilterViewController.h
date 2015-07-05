//
//  BDIExpireFilterViewController.h
//  BDRInventory
//
//  Created by Amr Lotfy on 7/2/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDIMainViewController.h"
#import "BDInventory.h"

@interface BDIExpireFilterViewController : UIViewController
@property (nonatomic) BDIExpireFilterMode storedFilterMode;
@property (nonatomic) NSDate * storedStartDate;
@property (nonatomic) NSDate * storedEndDate;
@end
