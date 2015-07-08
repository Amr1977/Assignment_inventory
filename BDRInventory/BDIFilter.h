//
//  BDIFilter.h
//  BDRInventory
//
//  Created by Amr Lotfy on 7/6/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDIGrouping.h"

@interface BDIFilter : NSObject
@property (nonatomic)  BDInventoryGropingMode groupingMode;
@property (nonatomic)  BDIExpireFilterMode expireFilterMode;
@property (nonatomic)  NSDate * startDate;
@property (nonatomic)  NSDate * endDate;

@end
