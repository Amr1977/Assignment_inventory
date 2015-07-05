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
#import "BDIExpireFilterViewController.h"

@interface BDIMainViewController : UIViewController
@property (nonatomic) BDIExpireFilterMode expireFilterMode;
@property (nonatomic) NSDate * startDate;
@property (nonatomic) NSDate * endDate;

@end
