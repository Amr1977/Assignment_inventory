//
//  BDIProduct.h
//  BDRInventory
//
//  Created by Amr Lotfy on 6/3/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDIGrouping.h"
#import "BDIProductFilter.h"

@interface BDIProduct : NSObject <NSCopying>

@property(nonatomic) NSString *name;
@property(nonatomic) NSString *manufacturer;
@property(nonatomic) NSString *category;
@property(nonatomic) NSString *exporterID;
@property(nonatomic) NSDate *expireDate;
@property(nonatomic) NSNumber *price;
@property(nonatomic) NSUInteger quantity;

- (instancetype)initWithDictionary:(NSDictionary *)productAttributes;
- (BOOL)isExpired;

@end
