//
//  BDInventory.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/3/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDInventory.h"

@interface BDInventory ()


@property(nonatomic)  NSMutableSet *manufacturers;
@property(nonatomic)  NSMutableSet *categories;
@property(nonatomic)  NSMutableSet *exporters;


@end

@implementation BDInventory

+ (instancetype) inventory{
    static BDInventory * inventoryObject = nil;
    if (!inventoryObject){
        inventoryObject=[[BDInventory alloc] init];
    }
    return inventoryObject;
}


-(NSDictionary *) getResults{
   return [self getProductsByGrouping:self.groupingMode expireFilter:self.expireFilterMode startDate:self.startDate endDate:self.endDate];
}


- (NSDictionary *)getProductsByGrouping:(BDInventoryGropingMode)grouping
                           expireFilter:(BDIExpireFilterMode)expireFilter
                              startDate:(NSDate *)startDate
                                endDate:(NSDate *)endDate {
  // The main method, performs filtering on expire filter then the result
  // is regrouped by grouping filter
  NSArray *expireFilteredProducts = [self getProductsByExpireFilter:expireFilter
                                                          startDate:startDate
                                                            endDate:endDate];
  NSDictionary *groupedProducts =
      [self filterProducts:expireFilteredProducts byGroupingMethod:grouping];
  return groupedProducts;
}

- (NSArray *)getProductsByExpireFilter:(BDIExpireFilterMode)expireFilterMode
                             startDate:(NSDate *)startDate
                               endDate:(NSDate *)endDate {
  NSArray *result = [self products];
    NSPredicate *expireFilter;
    switch (expireFilterMode) {
      case BDIProductExpired:  // expired
        expireFilter = [self expired];
        break;
      case BDIProductNonExpired:  // non expired
        expireFilter = [self nonExpired];
        break;

      case BDIProductInRange:  // in range
        expireFilter = [self expiresInRangeStart:startDate RangeEnd:endDate];
        break;
    }

    result = [[self products] filteredArrayUsingPredicate:expireFilter];
  

  return result;
}

+ (NSArray *)allowedGrouping {//TODO: better to use enumeration
  return [[NSArray alloc] initWithObjects:@"manufacturer", @"category",
                                          @"exporter", @"no_group", nil];
}

+ (NSArray *)allowedExpireFiltering {//TODO: better to use enumeration
  return [[NSArray alloc]
      initWithObjects:@"expired", @"non_expired", @"in_range", nil];
}

- (NSPredicate *)expired {
  return [self expiresInRangeStart:[NSDate distantPast] RangeEnd:[NSDate date]];
}

- (NSPredicate *)nonExpired {
  ;
  return [NSCompoundPredicate notPredicateWithSubpredicate:[self expired]];
}

- (NSPredicate *)expiresInRangeStart:(NSDate *)expireRangeStartDate
                            RangeEnd:(NSDate *)expireRangeEndDate {
  NSPredicate *result = [NSPredicate
      predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        BOOL inRange = false;
        BOOL afterOrEqualFirstDate = false;
        BOOL beforeOrEqualEndDate = false;
        NSDate *productExpireDate = [(BDIProduct *)evaluatedObject expireDate];
        NSComparisonResult result =
            [productExpireDate compare:expireRangeStartDate];
        afterOrEqualFirstDate =
            ((result == NSOrderedDescending) || (result == NSOrderedSame));
        if (!afterOrEqualFirstDate) {
          return (false);
        }
        result = [productExpireDate compare:expireRangeEndDate];
        beforeOrEqualEndDate =
            ((result != NSOrderedDescending) );

        inRange = (afterOrEqualFirstDate && beforeOrEqualEndDate);
        return (inRange);
      }];

  return result;
}

- (NSPredicate *)groupingBy:(BDInventoryGropingMode)group withValue:(NSString *)value {
  NSPredicate *result = [NSPredicate
      predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        BOOL result = true;
          switch (group) {
            case ManufacturersGrouping:  // manufacturer //TODO: better to define constants or enums
              return [
                  [[(BDIProduct *)evaluatedObject manufacturer] lowercaseString]
                  isEqualToString:[value lowercaseString]];

            case CategoryGrouping:  // category
              return [[[(BDIProduct *)evaluatedObject category] lowercaseString]
                  isEqualToString:[value lowercaseString]];

            case ExporterGrouping:
              return
                  [[[(BDIProduct *)evaluatedObject exporterID] lowercaseString]
                      isEqualToString:[value lowercaseString]];

            case NoGroup:  // no_group
              return true;

            default:
              NSLog(@"unknown grouping by: [%u]", group);
          }
        
        return result;
      }];

  return result;
}

- (NSArray *)filterProducts:(NSArray *)productsArray
                  groupedBy:(BDInventoryGropingMode)grouping
                  withValue:(NSString *)value {
  return [productsArray
      filteredArrayUsingPredicate:[self groupingBy:grouping withValue:value]];
}

/**
 * returns a dictionary where the key is the the value that objects are grouped
 * by, these objects are ararnged in an array in the value part of the
 * dictionary
 */
- (NSDictionary *)filterProducts:(NSArray *)productsArray
                byGroupingMethod:(BDInventoryGropingMode)grouping {
  NSMutableDictionary *result;
  
  
    result = [NSMutableDictionary new];
    NSMutableSet *groupingSet;
    switch (grouping) {
      case ManufacturersGrouping:  // manufacturer
        groupingSet = self.manufacturers;
        break;

      case CategoryGrouping:  // category
        groupingSet = self.categories;
        break;

      case ExporterGrouping:  // exporter
        groupingSet = self.exporters;
        break;

      case NoGroup:  // no group
        groupingSet = nil;
        [result setValue:productsArray forKey:@"No Group"];
    }

    for (NSString *groupingKey in groupingSet) {
      // create dictionary entry for each manufacturer with a value which is an
      // array of the products that are produced by this manufacturer
      [result setValue:[self filterProducts:productsArray
                                  groupedBy:grouping
                                  withValue:groupingKey]
                forKey:groupingKey];
    }
  

  return [result copy];
}

- (instancetype)init {
  self = [super init];
  if (self) {
    // load data from data source
    NSString *bundlePath =
        [[NSBundle mainBundle] bundlePath];  // Path of your bundle
    NSString *path =
        [bundlePath stringByAppendingPathComponent:@"inventory_data.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSArray *data;

    if ([fileManager fileExistsAtPath:path]) {
      NSLog(@"File found [%@]", path);
      data = [NSArray arrayWithContentsOfFile:path];  // if file exist at path
                                                      // initialise your
                                                      // dictionary with its
                                                      // data
      if (data) {
        self.manufacturers = [[NSMutableSet alloc] init];
        self.categories = [[NSMutableSet alloc] init];
        self.exporters = [[NSMutableSet alloc] init];
        NSMutableArray *parsedProducts = [[NSMutableArray alloc] init];
        for (NSDictionary *productDictionary in data) {
          BDIProduct *product =
              [[BDIProduct alloc] initWithDictionary:productDictionary];
          [parsedProducts addObject:product];
          NSLog(@"=====================");
          // TODO: fill the global sets !
          if ([product manufacturer]) {
            [self.manufacturers addObject:[product manufacturer]];
            NSLog(@"number of manufacturers so far: %lu",
                  (unsigned long)[self.manufacturers count]);
          }
            
          if ([product exporterID]) {
            [self.exporters addObject:[product exporterID]];
            NSLog(@"number of exporters so far: %lu",
                  (unsigned long)[self.exporters count]);
          }
          if ([product category]) {
            [self.categories addObject:[product category]];
            NSLog(@"number of categories so far: %lu",
                  (unsigned long)[self.categories count]);
          }
        }
        _products = [parsedProducts copy];
        NSLog(@"Parsed [%lu] products, manufacturers: %lu, exporters: %lu, "
              @"categories: %lu.",
              [_products count], (unsigned long)[self.manufacturers count],
              (unsigned long)[self.exporters count],
              (unsigned long)[self.categories count]);
      }
    } else {
      NSLog(@"File not found [%@]", path);
    }
  } else {
    NSLog(@"%@ Error initializing", [self class]);
  }
  NSLog(@"products grouped by manufacturer %@",
        [self filterProducts:[self products] byGroupingMethod:ManufacturersGrouping]);
  NSLog(@"non-expired products grouped by manufacturer %@",
        [self getProductsByGrouping:ManufacturersGrouping
                       expireFilter:BDIProductNonExpired
                          startDate:nil
                            endDate:nil]);
  return self;
}

@end
