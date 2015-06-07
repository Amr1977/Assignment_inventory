//
//  BDInventory.h
//  BDRInventory
//
//  Created by Amr Lotfy on 6/3/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDIProduct.h"

@interface BDInventory : NSObject
- (NSDictionary *)getProductsByGrouping:(NSString *)grouping
                           expireFilter:(NSString *)expireFilter
                              startDate:(NSDate *)startDate
                                endDate:(NSDate *)endDate;

@end
