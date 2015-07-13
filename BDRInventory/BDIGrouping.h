//
//  BDIGrouping.h
//  BDRInventory
//
//  Created by Amr Lotfy on 6/29/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface BDIGrouping : NSObject

typedef enum {
  BDIManufacturersGrouping,
  BDICategoryGrouping,
  BDIExporterGrouping,
  BDINoGroup
} BDInventoryGropingMode;

typedef enum {
  BDIProductExpired,
  BDIProductNonExpired,
  BDIProductInRange
} BDIExpireFilterMode;

@end
