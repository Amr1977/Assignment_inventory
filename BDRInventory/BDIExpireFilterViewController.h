//
//  BDIExpireFilterViewController.h
//  BDRInventory
//
//  Created by Amr Lotfy on 7/2/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDInventory.h"

@class BDIExpireFilterViewController;

@protocol BDExpireFilterProtocol<NSObject>
- (void)expireFilterViewController:
            (BDIExpireFilterViewController *)viewController
               didChooseFilterType:(BDIExpireFilterMode)expireFilterMode
                         startDate:(NSDate *)startDate
                           endDate:(NSDate *)endDate;

- (void)expireFilterViewControllerDidCancel:
    (BDIExpireFilterViewController *)viewController;

@end

@interface BDIExpireFilterViewController : UIViewController

@property(weak, nonatomic) id<BDExpireFilterProtocol> delegate;
@property(nonatomic) BDIProductFilter *productFilter;

@end
