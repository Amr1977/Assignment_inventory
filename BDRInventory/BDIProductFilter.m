//
//  BDIFilter.m
//  BDRInventory
//
//  Created by Amr Lotfy on 7/6/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDIProductFilter.h"

@implementation BDIProductFilter
- (instancetype)
initProductFilterWithGroupingMode:(BDInventoryGropingMode)groupingMode
                 expireFilterMode:(BDIExpireFilterMode)expireFilterMode
                        startDate:(NSDate *)startDate
                          enddate:(NSDate *)endDate {
  self = [super init];
  if (self) {
    _groupingMode = groupingMode;
    _expireFilterMode = expireFilterMode;
    _startDate = startDate;
    _endDate = endDate;
  }
  return self;
}
-(id) copyWithZone:(NSZone *)zone{
    BDIProductFilter * newProductFilter=[[[self class] allocWithZone:zone] init];
    if(newProductFilter){
        newProductFilter.groupingMode=self.groupingMode;
        newProductFilter.expireFilterMode=self.expireFilterMode;
        newProductFilter.startDate=self.startDate;
        newProductFilter.endDate=self.endDate;
    }
    return newProductFilter;
}
@end
