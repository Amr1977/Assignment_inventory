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

@property(nonatomic) BDIExpireFilterMode expireFilterMode;
@property(nonatomic) BDInventoryGropingMode groupingMode;
@property(nonatomic) NSDate *startDate;
@property(nonatomic) NSDate *endDate;
@property(nonatomic) NSArray *products;
@property(nonatomic) BDIProduct *product;

- (NSDictionary *)getResults;

- (NSDictionary *)getProductsByGrouping:(BDInventoryGropingMode)grouping
                           expireFilter:(BDIExpireFilterMode)expireFilter
                              startDate:(NSDate *)startDate
                                endDate:(NSDate *)endDate;

// singleton
+ (instancetype)inventory;

@end
