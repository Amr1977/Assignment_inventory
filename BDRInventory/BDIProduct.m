//
//  BDIProduct.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/3/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDIProduct.h"

@implementation BDIProduct
-(id) copyWithZone:(NSZone *)zone{
    BDIProduct * newProduct=[[[self class] allocWithZone:zone] init];
    if(newProduct){
        newProduct.name=self.name;
        newProduct.manufacturer=self.manufacturer;
        newProduct.category=self.category;
        newProduct.expireDate=self.expireDate;
        newProduct.exporterID=self.exporterID;
        newProduct.price=self.price;
        newProduct.quantity=self.quantity;
    }
    return newProduct;
}

- (NSString *)description {
  NSDateFormatter *format = [[NSDateFormatter alloc] init];
  [format setDateFormat:@"dd/MMM/yyyy"];

  NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
  [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];

  NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
  //[numberFormatter setNumberStyle:NSnu];
  [numberFormatter
      setGroupingSeparator:[[NSLocale currentLocale]
                               objectForKey:NSLocaleGroupingSeparator]];
  [numberFormatter setUsesGroupingSeparator:YES];

  return [NSString
      stringWithFormat:
          @"\n[%@] in [%@] \n "  //[self name],[self category],
          @"[%@] %@ \n"  //([self isExpired]?@"Expired":@"Not-Expired"),[self
          // expireDate],
          @"[%@] items. [%@] \n"  //(unsigned long)[self quantity],[self price],
          @"[%@]\n",              //[self manufacturer]
          [self name],
          [self category], ([self isExpired] ? @"Expired" : @"Not-Expired"),
          [format stringFromDate:[self expireDate]],
          [numberFormatter
              stringFromNumber:[NSNumber numberWithInteger:[self quantity]]],
          [currencyFormatter stringFromNumber:[self price]], [self manufacturer]

  ];
}

- (instancetype)initWithDictionary:(NSDictionary *)productAttributes {
  self = [super init];
  if (self) {
    if (productAttributes) {
      for (NSString *key in productAttributes) {
        NSLog(@"key:[%@], value:[%@]", key, productAttributes[key]);
        if ([key isEqualToString:@"expiration_date"]) {
          _expireDate = productAttributes[key];
        } else if ([key isEqualToString:@"name"]) {
          NSString *nameString = productAttributes[key];
          NSArray *subStrings = [nameString componentsSeparatedByString:@"-"];
          for (NSString *substring in subStrings) {
            // NSLog(@"Name substring: [%@]",substring);
            NSArray *subNameComponent =
                [substring componentsSeparatedByString:@":"];
            // TODO: need to handle empty valued entries

            if ([subNameComponent count] == 1) {
              subNameComponent = [NSArray
                  arrayWithObjects:subNameComponent[0], @"<UNDEFINED>", nil];
              NSLog(@"subNameComponent: %@", subNameComponent);
            }
            NSLog(@"subNameComponent: %@", subNameComponent);
            if ([subNameComponent[0] isEqualToString:@"pr"]) {
              // product name
              _name = subNameComponent[1];
              NSLog(@"Product Name: %@", _name);
            } else if ([subNameComponent[0]
                           isEqualToString:@"man"]) {  // product naufacturer
              _manufacturer = subNameComponent[1];
              NSLog(@"Manufacturer: %@", _manufacturer);
            } else if ([subNameComponent[0]
                           isEqualToString:@"cat"]) {  // product category
              _category = subNameComponent[1];
              NSLog(@"Category: %@", _category);
            } else if ([subNameComponent[0]
                           isEqualToString:@"exp"]) {  // product exporter
              _exporterID = subNameComponent[1];
              NSLog(@"Exported ID: %@", _exporterID);
            }
          }

        } else if ([key isEqualToString:@"price"]) {
          _price = productAttributes[key];

        } else if ([key isEqualToString:@"quantity"]) {
          _quantity = [productAttributes[key] integerValue];
        }
      }
    }
  }
  return self;
}
- (BOOL)isExpired {
  NSComparisonResult result = [[self expireDate] compare:[NSDate date]];

  return (result != NSOrderedDescending);
}


@end
