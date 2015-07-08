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

@class BDIExpireFilterViewController;

@protocol BDExpireFilterViewControllerDelegate <NSObject>

- (void)expireFilterViewController:(BDIExpireFilterViewController *)viewController didChooseDate:(NSDate *)date;
- (void)expireFilterViewControllerDidCancel:(BDIExpireFilterViewController *)viewController;

@end

@interface BDIExpireFilterViewController : UIViewController
//@property (nonatomic) BDIExpireFilterMode storedFilterMode;
//@property (nonatomic) NSDate * storedStartDate;
//@property (nonatomic) NSDate * storedEndDate;

@property (weak, nonatomic) id<BDExpireFilterViewControllerDelegate> delegate;

@end
